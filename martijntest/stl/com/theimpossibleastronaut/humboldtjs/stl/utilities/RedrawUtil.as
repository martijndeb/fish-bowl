package com.theimpossibleastronaut.humboldtjs.stl.utilities
{
	import com.humboldtjs.system.Convert;
	
	import dom.document;
	import dom.domobjects.HTMLElement;
	import dom.eventFunction;
	import dom.window;

	/**
	 * Redraw the dom to prevent issues. Specifically Safari 5 on Mac OS X is prone to having
	 * these issues after an element has been added or been removed.
	 * 
	 * Invalidates the whole dom. This is a costy process, use it wisely.
	 */
	public class RedrawUtil
	{
		protected static const REPAINT_ELEMENT:String = "stlRepaintElement";
		protected static const REPAINT_TIMEOUT:Number = 0;
		
		/**
		 * Simple hack to repaint the dom. If you don't specify a target then
		 * document.body will be used. Using document.body is the most costly
		 * operation, but yields the most usable results.
		 * 
		 * @param aTarget HTMLElement of the target to repaint.
		 */
		public static function repaint(aTarget:HTMLElement = null):void
		{
			var theTarget:HTMLElement = Convert.toUnTyped(aTarget);
			if (typeof theTarget == "undefined" || theTarget == null)
				theTarget = document.body;
			
			if (typeof window[REPAINT_ELEMENT] == "undefined" || window[REPAINT_ELEMENT] == null)
			{
				window[REPAINT_ELEMENT] = document.createElement("div");
				theTarget.appendChild(window[REPAINT_ELEMENT]);
			}
			
			window[REPAINT_ELEMENT].id = REPAINT_ELEMENT + new Date().getTime().toString();
			window[REPAINT_ELEMENT].innerHTML = "&nbsp;";
			window[REPAINT_ELEMENT].style.width = "100%";			
			window[REPAINT_ELEMENT].style.height = "100%";
			window[REPAINT_ELEMENT].style.position = "absolute";
			window[REPAINT_ELEMENT].style.top = "0px";
			window[REPAINT_ELEMENT].style.left = "0px";
			window[REPAINT_ELEMENT].style.display = "block";
			
			window.setTimeout(eventFunction(RedrawUtil, removeRepaint), REPAINT_TIMEOUT);
		}
		
		/**
		 * Resets the repaint element, so it doesn't block the interface.
		 */
		protected static function removeRepaint():void
		{
			window[REPAINT_ELEMENT].innerHTML = "&nbsp;";
			window[REPAINT_ELEMENT].style.width = "0px";
			window[REPAINT_ELEMENT].style.height = "0px";
			window[REPAINT_ELEMENT].style.display = "none";
		}
	}
}