package UserControls 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import J.BASE.BaseButton;	
	import J.BASE.BaseMovieClip;
	
	import App.Bus;
	import App.Lib;
	
	/** @author Feyyaz */

	public class Logo extends BaseButton
	{
		public function Logo() {			
		}
		
		override protected function Start():void {
			play();
			this.x = -30;
			this.y = -20;
		}
		
		override protected function onMouseOver(e:MouseEvent):void { }
		override protected function onMouseOut(e:MouseEvent):void { }
		override protected function onClick(e:MouseEvent):void { 
			Bus.GoToDefault();
		}
	}
	
}