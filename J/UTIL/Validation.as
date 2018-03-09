package J.UTIL
{
	
	/** @author Feyyaz */
	
	public class Validation 
	{		
		public function Validation() { }
		
		public static function IsEmail(Input:String):Boolean {
			var Pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			return Input.match(Pattern) != null;
		}
		
		public static function FullName(Input:String):Boolean {
			return 	Input.length >= 5 && 
					(Input.indexOf(" ") != -1) &&
					Input.split(" ")[0].length > 1 &&
					Input.split(" ")[1].length > 1;
		}
		
		public static function Password(Input:String):Boolean {
			return Input.length >= 5;
		}
		
		public static function PasswordEasy(Input:String):Boolean {
			return Input.length > 0;
		}
		
		public static function PasswordHard(Input:String):Boolean {
			return Input.length >= 8;
		}
		
		public static function GSM(Input:String):Boolean {
			return Input.length >= 10;
		}		
		
	}
	
}