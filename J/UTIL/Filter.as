package J.UTIL 
{
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import J.UTIL.NumberUtil;
	
	import J.UTIL.Colors;
	
	/** @author Feyyaz */
	
	public class Filter 
	{		
		public function Filter() { }
		
		public static function Stroke(Color:uint = 0x000000):DropShadowFilter {
			var DropShadow:DropShadowFilter = new DropShadowFilter();
			DropShadow.blurX = DropShadow.blurY = 2;
			DropShadow.strength = 10;
			DropShadow.distance = 0;
			DropShadow.angle = 0;
			DropShadow.color = Color;
			DropShadow.knockout = false;
			DropShadow.inner = false;
			DropShadow.quality = 3;
			
			return DropShadow;
		}
		
		public static function DropShadow(Color:uint = 0x2b2a2d, Blur:Number = 1, Strength:Number = 100, Distance:Number = 3, Angle:Number = 45):DropShadowFilter {
			var DropShadow:DropShadowFilter = new DropShadowFilter();
			DropShadow.blurX = DropShadow.blurY = Blur;
			DropShadow.strength = Strength;
			DropShadow.distance = Distance;
			DropShadow.angle = Angle;
			DropShadow.color = Color;
			DropShadow.knockout = false;
			DropShadow.inner = false;
			DropShadow.quality = 3;
			
			return DropShadow;
		}
		
		public static function Hue() {
			var matrix:Array = new Array();
			matrix = matrix.concat([0,1,0,0,0]);// red
			matrix = matrix.concat([0,0,1,0,0]);// green
			matrix = matrix.concat([1,0,0,0,0]);// blue
			matrix = matrix.concat([0,0,0,1,0]);// alpha
			var my_filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return my_filter;
		}
		
		public static function HueRandom() {
			var matrix:Array = new Array();
			matrix = matrix.concat([NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt()]);// red
			matrix = matrix.concat([NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt()]);// red
			matrix = matrix.concat([NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt()]);// red
			matrix = matrix.concat([NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt(), NumberUtil.RandomInt()]);// red
			var my_filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return my_filter;
		}		
	}
	
}