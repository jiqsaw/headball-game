package Game
{
	import flash.events.KeyboardEvent;
	import Services.SFS;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class KeyboardEvents
	{	
		public function KeyboardEvents() { }
		
		public function enableEvents(target:*)
		{
			target.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			target.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		public function disableEvents(target:*)
		{
			target.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			target.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		private function keyPressed(e:KeyboardEvent):void 
		{
			var keyId:Number = e.keyCode;
			var keyboardCommand:String;
			
			
			var msgId:Number;
			switch(keyId)
			{
				case 65:
				case 37:
					keyboardCommand = "LP";//left pressed
					break;
					
				case 87:
				case 38:
					keyboardCommand = "UP";//up pressed
					break;
				case 68:
				case 39:
					keyboardCommand = "RP";//right pressed
					break;
			}
			
			if (keyId > 47 && keyId < 58)
			{
				keyboardCommand = String(keyId - 48);
				sendKeyboardEvent(keyboardCommand, true);
			} 
			else
				sendKeyboardEvent(keyboardCommand);				
		}
		
		private function keyReleased(e:KeyboardEvent):void 
		{
			var keyId:Number = e.keyCode;
			var keyboardCommand:String = "";
			switch(keyId)
			{
				case 65:
				case 37:
					keyboardCommand = "LR";//left release
					break;
					
				case 87:
				case 38:
					keyboardCommand = "UR";//up release
					break;
					
				case 68:
				case 39:
					keyboardCommand = "RR";//right release
					break;
			}
			
			if (keyboardCommand != "")
				sendKeyboardEvent(keyboardCommand);
		}
		
		private function sendKeyboardEvent(keyCommand:String, IsNumPad:Boolean = false)
		{
			SFS.KeyCommands(keyCommand, IsNumPad);
		}				
	}

}