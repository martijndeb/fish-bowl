package com.theimpossibleastronaut.humboldtjs.stl.view.template
{
	import com.humboldtjs.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.INotifier;
	
	/**
	 * Empty TemplateView which will be constructed if an inheriting view isn't set
	 * in the TemplateViewMediator. You will need to add the view to your stage yourself.
	 * 
	 * @see com.theimpossibleastronaut.humboldtjs.stl.view.template.TemplateViewMediator
	 */
	public class TemplateView extends DisplayObject
	{
		protected var mMediator:INotifier;
		public function setNotifier(value:INotifier):void { mMediator = value; }
		
		public function TemplateView()
		{
			super();
		}
	}
}