package Game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class ScoreBoard extends MovieClip
	{
		var mCountDown:Countdown;
		public function ScoreBoard()
		{
			GameGlobals.SCORE_BOARD = this;
			
			leftName.text = SFSGlobal.LeftPlayerName;
			leftCity.text = SFSGlobal.LeftPlayerCity;
			
			rightName.text = SFSGlobal.RightPlayerName;
			rightCity.text = SFSGlobal.RightPlayerCity;
			
			Reset();
		}
		
		public function Reset() {
			timerMc.gotoAndStop(1);
			timer.text = "90";
			leftScore.text = "0";
			rightScore.text = "0";
			
			mCountDown = new Countdown();
			mCountDown.starter();
			mCountDown.addEventListener(Countdown.TIMER_UPDATE, TimerUpdate);			
		}
		
		public function update(elapsedTime:Number)
		{
			var etString:String = String(elapsedTime);
			if (etString.length < 2)	
				etString = "0" + etString;
			timer.text = etString;
			
			if (elapsedTime == 10)
			{
				timerMc.gotoAndPlay(2);
			}
		}
		
		public function scoreUpdate()
		{
			leftScore.text = String(SFSGlobal.LeftPlayerScore);
			rightScore.text = String(SFSGlobal.RightPlayerScore);
		}
		
		private function TimerUpdate(e:Event):void
		{
			update(mCountDown.elapsedTime);
		}
		
		public function End() {
			leftScore.text = SFSGlobal.LeftPlayerScore.toString();
			rightScore.text = SFSGlobal.RightPlayerScore.toString();
			mCountDown.stoper();
			timer.text = "00";
		}
	}
}