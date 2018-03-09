package HeadCameraSrc
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import J.BASE.BaseMovieClip;
	
	/** @author Feyyaz */
	
	public class SaveScoreFinish extends BaseMovieClip
	{
		var mBtnReturn:MovieClip;
		
		public function SaveScoreFinish() 
		{
			
		}
		
		override protected function Prep():void 
		{
			mBtnReturn = this["btnReturn"];
			mBtnReturn.buttonMode = true;
			mBtnReturn.mouseEnabled = true;
			mBtnReturn.mouseChildren = false;			
		}
		
		override protected function Events():void 
		{
			this.Click(mBtnReturn, ReturnClick);
		}
		
		private function ReturnClick(e:MouseEvent):void
		{
			var mSwfCom:SwfCom = new SwfCom();
			mSwfCom.RestartHeadCamGame();
		}
	}
	
}