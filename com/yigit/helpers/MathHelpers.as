package com.yigit.helpers 
{
	
	/**
	 * 
	 * Math Helpers Class
	 * @author		Emin Yiğit KULA
	 * @mail		yigitkula@gmail.com
	 * @website		http://www.yigitkula.com
	 * 
	 * This class includes simple display object processes.
	 * @method		getRandomInt		returns an integer between min and max values
	 * @method		getRandomNum		returns a number between min and max values
	 * @method		degreesToRadians	converts degrees to radians
	 * @method		radiansToDegrees	converts radians to degrees
	 * 
	 */
	
	public class MathHelpers
	{
		public static function getRandomInt($min_value:Number, $max_value:Number):int
		{
			$min_value = Math.ceil($min_value);
			$max_value = Math.floor($max_value);
			return $min_value + Math.floor(Math.random() * ($max_value +1 - $min_value));
		}
		
		public static function getRandomNum($min_value:Number, $max_value:Number):Number
		{
			return $min_value + (Math.random() * ($max_value - $min_value));
		}
		
		public static function degreesToRadians($degrees:Number):Number
		{
			return $degrees*(Math.PI/180);
		}
		
		public static function radiansToDegrees($radians:Number):Number
		{
			return $radians*(180/Math.PI);
		}
	}

}