package Game 
{
	import flash.display.MovieClip;
	import caurina.transitions.*;
	import flash.display.Sprite;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author Yiğit
	$(CBI)*/
	public class Ball extends MovieClip
	{
		private var oX:Number;
		private var oY:Number;
		
		private var vX:Number;
		private var vY:Number;
		
		private var dX:Number = 0;
		private var dY:Number = 0;
		
		private var odX:Number = 0;
		private var odY:Number = 0;
		
		private var dirX:Number = 0;
		private var dirY:Number = 0;
		
		private var startX:Number;
		private var startY:Number;
		
		private var _onTop:Boolean;
		
		public function Ball() 
		{
			GameGlobals.gBall = this;
			
			mc.mouseEnabled = false;
			mc.mouseChildren = false;
			mouseEnabled = false;
			mouseChildren = false;
			
			mc.cacheAsBitmap = true;
			t00.cacheAsBitmap = true;
			t01.cacheAsBitmap = true;
			t02.cacheAsBitmap = true;		
		
		}
		
		//Başlangıç
		// Burda da parabolün tepe noktasıymış gibi hesabı yapıyorum.
		// X yönü değiştiğinde aldığım x ve y değerlerinin şimdiki x ve y değerlerine göre farkını alıp ekliyorum abi.
		public function set onTop(value:Boolean):void
		{
			if (value == true && _onTop == false)
			{
				var sonX:Number = x + (x - startX);
				var sonY:Number = y - (y - startY);
				
				//Global.M.addTarget(sonX, sonY);
			}
			_onTop = value;
		}
		//Bitiş
		public function update()
		{
			oX = x;
			oY = y;
			x = SFSGlobal.BallX;			
			y = SFSGlobal.BallY;
			
			//Başlangıç
			// Burda y pozisyonuna bakıyorum. Topun şimdiki y pozisyonu bir öncekinden yüksek olduğu an topun tepe noktasıymış gibi davranıyorum.
			if (y > oY)
			{
				onTop = true;
			}
			else if (y < oY)
			{
				onTop = false;
			}
			//Bitiş
			if (x - oX != 0)
			{
				dX = x - oX;
			}	
			if (y - oY != 0)
			{
				dY = y - oY;
			}
				
			if (Math.abs(dX)> 50)
			{
				dX = 0;
			}
			
			//Başlangıç
			// Burdan x yönünü seçiyorum abi. X yönü değişince o anki x ve y pozisyonunu alıyorum.
			odX = dirX;
			
			if (x > oX)
			{
				dirX = 1;
			}
			else if (x < oX)
			{
				dirX = -1;
			}
			else
			{
				dirX = dirX;
			}
			
			if (odX != dirX)
			{
				startX = x;
				startY = y;
			}
			//Bitiş
			//trace("dX : " + dX);
			//trace("dY : " + dY);
			
			t00.x = -dX;
			t01.x = -dX*2;
			t02.x = -dX * 3;
			
			t00.y = -dY;
			t01.y = -dY*2;
			t02.y = -dY *3;
			
			vX = dX / .6;
			
			var t:Number = (dX / 2);
			t = dX % 30;
			mc.rotation += t;
		}
		
	}

}