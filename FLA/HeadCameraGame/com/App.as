package com
{
	

	import com.parsera.ui.Scene;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class App extends Sprite
	{
		public static var instance:App;
		public static var appStage:Stage;
			
		public var scene:Scene;
		public static var appWidth:Number = 600;
		public static var appHeight:Number = 450;
		
		public function App(st:Stage)
		{
			appStage = st;
			instance = this;
			
			init();
			
		}
		
		private function onKick(e:Event):void
		{
			trace("ok");
		}
		
		private function init():void {
			trace("App init");
			scene = new Scene();
			addChild(scene);
		}
		
		
	}
}