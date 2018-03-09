package J.UTIL 
{
	
	/** @author Feyyaz */
	
	public class StringUtil
	{
		
		public function StringUtil() { }
		
		public static function getExtension(Input:String):String
		{
			return Input.substring(Input.lastIndexOf(".") + 1, Input.length);
		}	
	}
	
}