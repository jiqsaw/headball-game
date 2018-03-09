package Game
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Countdown extends EventDispatcher
	{
		public var elapsedTime:Number = 90;
		private var timerAdded:Boolean = false;
		private var timer:Timer;
		
		public static const TIMER_UPDATE:String = "TIMER_UPDATE";
		
		public function Countdown()
		{
			GameGlobals.COUNT_DOWN = this;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, timerUpdateHandler);
		}
		
		public function starter()
		{
			timer.start();
		}
		
		public function stoper()
		{
			timer.stop();
			elapsedTime = 90;
		}
		
		private function timerUpdateHandler(e:TimerEvent):void
		{
			elapsedTime --;
			
			if (elapsedTime < 0)
				stoper();
			else
				dispatchEvent(new Event(TIMER_UPDATE));
		}
		
	}

}