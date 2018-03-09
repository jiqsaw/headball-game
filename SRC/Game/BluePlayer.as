package Game
{
	import flash.display.MovieClip;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class BluePlayer extends MovieClip
	{
		public var playerName:String;
		public var playerCity:String;
		public var score:Number;
		
		private var oX:Number;
		private var oY:Number;
		
		private var dirs:Array = [0, 0, 0];
		private var count:Number = 0;
		private var jumpcount:Number = 0;
		public function BluePlayer() 
		{
			
		}
		
		public function update()
		{
			oX = x;
			oY = y;
			x = SFSGlobal.LeftPlayerX;
			y = SFSGlobal.LeftPlayerY;
			
			if (x > oX)
			{			
				dirs[2] = 1;
				dirs[0] = 0;
				count = 0;
				
			}else if (x < oX)
			{
				dirs[2] = 0;
				dirs[0] = 1;
				count = 0;
			}else
			{
				count ++;
				if (count > 10)
				{
					dirs[0] = 0;
					dirs[2] = 0;
				}
			}
			
			dirs[1] = (y < SwfGlobal.SEH-5) ? 1 : 0;
			
			if (dirs[1])
			{
				jumpcount++;
				if (dirs[0] && !dirs[2])
				{
					gotoAndStop("jumpb");
				}
				else if (!dirs[0] && dirs[2])
				{
					gotoAndStop("jumpf");
				}
				else
				{
					gotoAndStop("jump");
				}
			}else
			{
				jumpcount = 0;
				if (dirs[0] && !dirs[2])
				{
					gotoAndStop("walkb");
				}
				else if (!dirs[0] && dirs[2])
				{
					gotoAndStop("walkf");
				}
				else
				{
					gotoAndStop("def");
				}
			}
		}
		
	}

}