package HeadCameraSrc
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.BASE.BaseMovieClip;
	
	/** @author Feyyaz */
	
	public class Splash extends BaseMovieClip
	{
		public static const KAFALA_CLICK:String = "KAFALA_CLICK";
		
		var mbtnKafala:MovieClip;
		
		public function Splash() 
		{
			
		}
		
		override protected function Prep():void 
		{
			mbtnKafala = this["btnKafala"];
			
			mbtnKafala.buttonMode = true;
			mbtnKafala.mouseEnabled = true;
			mbtnKafala.mouseChildren = false;
		}
		
		override protected function Events():void 
		{
			this.Click(mbtnKafala, KafalaClick);
		}		
		
		private function KafalaClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(Splash.KAFALA_CLICK));
		}
	}
	
}