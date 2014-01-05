package com.theimpossibleastronaut.humboldtjs.stl.view.template
{
	import com.humboldtjs.display.DisplayObject;
	import com.humboldtjs.events.HJSEvent;
	import com.humboldtjs.net.PrefixLoader;
	import com.humboldtjs.net.URLRequest;
	import com.humboldtjs.system.Convert;
	import com.humboldtjs.system.Logger;
	import com.theimpossibleastronaut.humboldtjs.stl.model.ObjectStoreProxy;
	import com.theimpossibleastronaut.humboldtjs.stl.notes.ObjectStoreNotes;
	import com.theimpossibleastronaut.humboldtjs.stl.notes.TemplateNotes;
	
	import dom.domobjects.HTMLElement;
	import dom.eventFunction;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * Base class for mediating the template loading and the template view for html based
	 * templates. Inherit your mediator and views from this if you want to change behaviour.
	 * If you want to show unprocessed html, just instantiate a new TemplateViewMediator
	 * and add it's viewcomponent to your stage.
	 * 
	 * This mediator uses the ObjectStoreProxy to cache the loaded template files.
	 * We expect files in the htmlp or non processed xmlp format. You can create this file 
	 * using the xmlpconverter with the -n flag (for no processing).
	 * 
	 * @example
	 * loadTemplate("path/to/template.htmlp");
	 * 
	 * @see com.theimpossibleastronaut.humboldtjs.stl.model.ObjectStoreProxy
	 */
	public class TemplateViewMediator extends Mediator
	{
		protected var mObjectStore:ObjectStoreProxy;
		protected var mObjectStoreIdentifier:String;
		protected var mDynamicMediatorObjectStore:ObjectStoreProxy;
		protected var mActiveMediators:Array = new Array();
		
		public function TemplateViewMediator(aName:String = "", aView:DisplayObject = null)
		{			
			var theView:DisplayObject = aView;
			
			if (theView == null)
				theView = new TemplateView();
						
			super(aName == null || aName == "" ? TemplateNotes.TEMPLATE_VIEW_MEDIATOR_NAME : aName, theView);			
		}
		
		override public function onRegister():void
		{
			if (!facade.hasProxy(ObjectStoreNotes.TEMPLATE_OBJECT_STORE_PROXY_NAME))
				facade.registerProxy(new ObjectStoreProxy(ObjectStoreNotes.TEMPLATE_OBJECT_STORE_PROXY_NAME));

			if (!facade.hasProxy(ObjectStoreNotes.TEMPLATE_DYNAMIC_MEDIATORS_OBJECT_STORE_PROXY_NAME))
				facade.registerProxy(new ObjectStoreProxy(ObjectStoreNotes.TEMPLATE_DYNAMIC_MEDIATORS_OBJECT_STORE_PROXY_NAME));
			
			mObjectStore = facade.retrieveProxy(ObjectStoreNotes.TEMPLATE_OBJECT_STORE_PROXY_NAME) as ObjectStoreProxy;
			mDynamicMediatorObjectStore = facade.retrieveProxy(ObjectStoreNotes.TEMPLATE_DYNAMIC_MEDIATORS_OBJECT_STORE_PROXY_NAME) as ObjectStoreProxy;
		}
		
		override public function onRemove():void
		{
			for (var i:int = 0; i < mActiveMediators.length; i++)
				facade.removeMediator(mActiveMediators[i]);
			
			mActiveMediators = new Array();
		}
		
		/**
		 * Load a template and tell the world we completed afterwards.
		 * If we have a cached version call onLoadComplete, otherwise start loading it
		 * and hook up onTemplateInnerLoadComplete.
		 * 
		 * @param aTemplatePath String Path at which the template is located. Ideally should be a .htmlp file.
		 */
		protected function loadTemplate(aTemplatePath:String):void
		{
			mObjectStoreIdentifier = aTemplatePath;
			
			if (mObjectStore.contains(mObjectStoreIdentifier))
				return onLoadComplete();
			
			var theLoader:PrefixLoader = new PrefixLoader();
			theLoader.addEventListener(HJSEvent.COMPLETE, eventFunction(this, onTemplateInnerLoadComplete));
			theLoader.load(new URLRequest(aTemplatePath));
		}
		
		/**
		 * Gets called whenever the PrefixLoader has completed, we now cache the loaded contents
		 * and call the onLoadComplete function.
		 */
		protected function onTemplateInnerLoadComplete(aEvent:HJSEvent):void
		{
			var thePrefixLoader:PrefixLoader = aEvent.getCurrentTarget() as PrefixLoader;
			mObjectStore.store(mObjectStoreIdentifier, thePrefixLoader.getContent() as String);
			
			onLoadComplete();
		}
		
		/**
		 * Set the element contents to whatever we can grab from the ObjectStoreProxy.
		 * Always overwrites the full innerHTML of the associated viewComponent.
		 */		
		protected function onLoadComplete():void
		{			
			(viewComponent as DisplayObject).getHtmlElement().innerHTML = mObjectStore.retrieve(mObjectStoreIdentifier) as String;
			
			parseViewComponentTree();
		}
		
		/**
		 * Parses the viewComponent tree and tries to resolve all tags within.
		 * Uses stl:Template, stl:SubTemplate for templates and stl:SiteText for texts.
		 * 
		 * Make sure your template contains a wrapping tag defining the namespace stl.
		 */
		protected function parseViewComponentTree():void
		{
			var i:int = 0;
			var theHtmlElement:HTMLElement;
			
			var theWrappingTags:Array = (viewComponent as DisplayObject).getHtmlElement().getElementsByTagName(getNamespacedTag(TemplateNotes.TEMPLATE_TAG));
			if (theWrappingTags.length == 0) // For IE < 9
				theWrappingTags = (viewComponent as DisplayObject).getHtmlElement().getElementsByTagName(TemplateNotes.TEMPLATE_TAG);
			
			if (theWrappingTags.length == 0)
				Logger.error("There was no wrapping tag specified for this template (" + mObjectStoreIdentifier + "). Did you forget the wrapping " + getNamespacedTag(TemplateNotes.TEMPLATE_TAG) + " tag?");
			
			for (i = 0; i < theWrappingTags.length; i++)
			{
				theHtmlElement = Convert.toUnTyped(theWrappingTags[i]);
				while (theHtmlElement.childNodes.length > 0)
					theHtmlElement.parentNode.appendChild(theHtmlElement.childNodes[0]);
			}
			
			for (i = theWrappingTags.length - 1; i >= 0; i--)
			{
				theHtmlElement = Convert.toUnTyped(theWrappingTags[i]);
				theHtmlElement.parentNode.removeChild(theHtmlElement);
			}
						
			var theTemplateTags:Array = (viewComponent as DisplayObject).getHtmlElement().getElementsByTagName(getNamespacedTag(TemplateNotes.SUBTEMPLATE_TAG));
			if (theTemplateTags.length == 0) // For IE < 9
				theTemplateTags = (viewComponent as DisplayObject).getHtmlElement().getElementsByTagName(TemplateNotes.SUBTEMPLATE_TAG);
			
			for(i = theTemplateTags.length - 1; i >= 0; i--)
			{
				theHtmlElement = Convert.toUnTyped(theTemplateTags[i]);
				
				var theMediatorName:String = theHtmlElement.getAttribute("mediator").toString();
				if (mDynamicMediatorObjectStore.contains(theMediatorName))
				{
					var theMediatorClass:* = mDynamicMediatorObjectStore.retrieve(theMediatorName);
					var theMediator:Mediator = (new theMediatorClass) as Mediator;
					facade.registerMediator(theMediator);
					
					mActiveMediators.push(theMediator);
					
					var theReplacementElement:HTMLElement = (theMediator.getViewComponent() as DisplayObject).getHtmlElement();
					theHtmlElement.parentNode.replaceChild(theReplacementElement, theHtmlElement);
					
					// Reset position, default is set to absolute (we dont like this :')
					theReplacementElement.style["position"] = "static";
				}
			}
		}
		
		/**
		 * Return a proper namespaced element for the given tag.
		 *  
		 * @see com.theimpossibleastronaut.humboldtjs.stl.notes.TemplateNotes
		 * @param aTag String A template tag.
		 */
		protected function getNamespacedTag(aTag:String):String
		{
			return TemplateNotes.STL_NAMESPACE + ":" + aTag;
		}
	}
}