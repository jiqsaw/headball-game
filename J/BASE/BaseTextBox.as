package J.BASE
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import J.UTIL.Validation;
	
	/** @author Feyyaz */
	
	public class BaseTextBox extends Sprite
	{
		public static var FullName = "FullName";
		public static var Email = "Email";
		public static var Password = "Password";
		public static var PasswordEasy = "PasswordEasy";
		public static var PasswordHard = "PasswordHard";
		public static var GSM = "GSM";
		
		protected var ItemType:String = "";	
		protected var mInputText:TextField = null;
		
		public function get Value():String { return mInputText.text; }
		public function set Value(value:String):void { mInputText.text = value; }
		
		public function get Length():Number { return mInputText.length; }
		
		public function BaseTextBox() { 
			addEventListener(Event.ADDED_TO_STAGE, Init);
			super();
		}
		
		private function Init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			Prep();
			Config();
			Start();
		}
		
		private function Config():void
		{
			if (ItemType != "" && mInputText != null) {
				switch (ItemType) 
				{
					case FullName:
						mInputText.multiline = false;
						mInputText.maxChars = 64;						
						mInputText.restrict = "a-züğışçö ";
					break;
					
					case Email:
						mInputText.multiline = false;
						mInputText.maxChars = 40;						
						mInputText.restrict = "a-z_.@0-9";
					break;
					
					case Password:
					case PasswordEasy:
					case PasswordHard:
						mInputText.multiline = false;
						mInputText.maxChars = 20;
						mInputText.text = "";						
						mInputText.displayAsPassword = true;
					break;
					
					case GSM:
						mInputText.multiline = false;
						mInputText.maxChars = 12;
						mInputText.restrict = "0-9";
					break;					
				}
			}
		}
		
		public function IsValid():Boolean {
			
			if ((ItemType == "") || (mInputText == null) || (mInputText.length == 0))
				return false;
				
			var Value:String = mInputText.text;
			
			switch (ItemType) 
			{
				case FullName:
					return Validation.FullName(Value);
				break;
				
				case Email:
					return Validation.IsEmail(Value);
				break;
					
				case Password:
					return Validation.Password(Value);
				break;
					
				case PasswordEasy:
					return Validation.PasswordEasy(Value);
				break;
				
				case PasswordHard:
					return Validation.PasswordHard(Value);
				break;
				
				case GSM:
					return Validation.GSM(Value);
				break;				
			}
			
			return false;
		}
		
		protected function Prep():void { }
		protected function Start():void { }
		
	}
	
}