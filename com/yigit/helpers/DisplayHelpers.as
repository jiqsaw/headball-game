package com.yigit.helpers 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 
	 * Math Helpers Class
	 * @author		Emin Yiğit KULA
	 * @mail		yigitkula@gmail.com
	 * @website		http://www.yigitkula.com
	 * 
	 * This class includes simple display object processes.
	 * @method		addContent			add an object to a container
	 * @method		removeContent		remove an object from a container
	 * @method		removeAllChildren	remove all childrens of a container
	 * @method		enableMouse			enable mouse properties of an object or array
	 * @method		disableMouse		disable mouse properties of an object or array
	 * 
	 */
	
	public class DisplayHelpers
	{
		public static function addContent($container:*, $content:*):void
		{
			$container.addChild($content);
		}
		
		public static function removeContent($container:*, $content:*):void
		{
			$container.removeChild($content);
		}
		
		public static function removeAllChildren($container:*):Boolean
		{
			while ($container.numChildren)
				$container.removeChildAt(0);
			if ($container.numChildren == 0)	return true;
			return false;
		}
		
		public static function enableMouse($targetObjects:Array):void
		{
			for (var i:uint = 0; i < $targetObjects.length; i++)
			{
				$targetObjects[i].tabEnabled = $targetObjects[i].buttonMode = $targetObjects[i].mouseEnabled = $targetObjects[i].mouseChildren = true;
			}
		}
		
		public static function disableMouse($targetObjects:Array):void
		{
			for (var i:uint = 0; i < $targetObjects.length; i++)
			{
				$targetObjects[i].tabEnabled = $targetObjects[i].buttonMode = $targetObjects[i].mouseEnabled = $targetObjects[i].mouseChildren = false;
			}
		}
	}

}