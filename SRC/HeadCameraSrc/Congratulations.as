package HeadCameraSrc
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import J.BASE.BaseMovieClip;
	
	/** @author Feyyaz */
	
	public class Congratulations extends BaseMovieClip
	{
		public var Score:Number;
		
		public static const SAVESCORE_CLICK:String = "SAVESCORE_CLICK";
		
		public function Congratulations(Score:Number) 
		{
			this.Score = Score;
		}
		
		override protected function Prep():void 
		{
			this["txtScore"].text = Score.toString();
		}
		
		override protected function Events():void 
		{
			this["btnSaveScore"].addEventListener(MouseEvent.CLICK, SaveScoreClick);
			this["btnSaveScore"].buttonMode = true;
		}
		
		private function SaveScoreClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(SAVESCORE_CLICK));
		}
		
	}
	
}