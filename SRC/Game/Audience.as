package Game
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Audience extends MovieClip
	{
		
		public function Audience() 
		{
			burakCaller();
			merveCaller();
		}
		
		private function burakCaller():void
		{
			var num:Number = Math.random() * 10 + 2;
			TweenLite.delayedCall(num, eat, [burakMc]);
		}
		
		private function merveCaller():void
		{
			var num:Number = Math.random() * 10 + 2;
			TweenLite.delayedCall(num, eat, [merveMc]);
		}
		
		private function eat(src:*)
		{
			src.gotoAndPlay(2);
			if (src.name == "merveMc")
			{
				burakCaller();
				
			}else
			{
				merveCaller();
			}
		}
	}
}