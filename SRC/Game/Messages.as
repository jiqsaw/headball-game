package Game
{
	import flash.display.Sprite;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Messages extends Sprite
	{
		private var msgTexts:Array = ["Beceriksiz!", "Bravo", "Aslansın", "Kaplansın", "Koçum benim", "Yürü be, kim tutar seni", "Bu ne biçim vuruş!", "Bırak bu işleri!", "Verdin yine traşı!", "O da atış mı?"];
		public function Messages() 
		{
			
		}
		
		public function showMessage(msgId:Number, side:String)
		{
			var xPos:Number;
			var yPos:Number;
			switch(side)
			{
				case "left":
					xPos = 45;
					yPos = 480;
					break;
					
				case "right":
					xPos = 685;
					yPos = 480;
					break;
			}
			var msg:String = msgTexts[msgId];
			var m:MesajMc = new MesajMc(msg, xPos, yPos);
		}
		
	}

}