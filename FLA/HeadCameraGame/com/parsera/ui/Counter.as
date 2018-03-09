package com.parsera.ui
{
	import flash.display.Sprite;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Counter extends Sprite
	{
		private var score:Number = 0;
		private var c:counterMc;
		public function Counter() 
		{
			Global.counter = this;
			c = new counterMc();
			addChild(c);
			
			PointVisible(false);
		}
		
		public function PointVisible(Visible:Boolean) {
			c.tf.visible = Visible;
		}
		
		public function update(uCase:String)
		{			
			
			if (uCase == "reset")
			{
				Global.M.ScoreUpdate(score);
				
				score = 0;
			}
			else
			{
				score ++;
			}
			c.tf.text = String(score);
		}
		
	}

}