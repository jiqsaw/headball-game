package J.UTIL 
{
	
	/** @author Feyyaz */
	
	public class NumberUtil 
	{
		
		public function NumberUtil() 
		{
			
		}
		
		function randomNumber(Low:Number, High:Number):Number
		{
			return Math.round(Math.random() * (High - Low)) + Low;
		}

		public static function RandomInt():Number {
			return Math.round(Math.random());
		}
		
		public static function Random(Low:Number, High:Number):Number
		{
			return Math.round(Math.random() * (High - Low)) + Low;
		}		
		
	}
	
}