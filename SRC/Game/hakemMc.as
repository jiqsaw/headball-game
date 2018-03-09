package Game
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class hakemMc extends MovieClip
	{
		
		public function hakemMc() 
		{
			GameGlobals.HK = this;
		}
		
		public function animFinish()
		{
			var targetFrame:Number = 32 + Math.floor(Math.random() * 30);
			TweenLite.delayedCall(2, GoToAnimFinish, [targetFrame]);
		}
		
		private function GoToAnimFinish(GoFrameNumber:Number):void
		{
			gotoAndStop(GoFrameNumber);
		}
		
		public function watchControl()
		{
			gotoAndPlay("saatebak");
		}
		
		public function scoreUpdate(side:String)
		{
			// paþam burasý tetiklenecek left ya da right diyerekten. 
			// hakem gerekeni yapacak sonra elini beline koyup duracak.
			if (side == "left")
			{
				gotoAndPlay("sayisag");
			}
			else if (side == "right")
			{
				gotoAndPlay("sayisol");
			}
		}
		public function update()
		{
			if (GameGlobals.parallaxEnabled)
			{
				var tx:Number = SFSGlobal.BallX - 483;
				var num:Number = tx / 13;
				koraycan.x +=  (num - koraycan.x) * .4;
				num = tx / 9;
				emrak.x +=  (num - emrak.x) * .4;
				num = tx / 7;
				kizan.x +=  (num - kizan.x) * .4;
			}
		}
	}

}