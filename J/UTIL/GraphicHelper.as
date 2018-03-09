package J.UTIL 
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Feyyaz
	$(CBI)*/
	public class GraphicHelper 
	{
		
		
		public function GraphicHelper() { }
		
		public static function draw(W:Number, H:Number, BackColor:uint = 0xFFFFFF, Alpha:Number = 1, X:Number = 0, Y:Number = 0):Sprite {
			var Obj:Sprite = new Sprite();
			Obj.graphics.beginFill(BackColor, Alpha);
			Obj.graphics.drawRect(X, Y, W, H);
			Obj.graphics.endFill();
			
			return Obj;
		}
		
		public static function drawRoundRect(W:Number, H:Number, RoundW:Number = 3, BackColor:uint = 0xFFFFFF, Alpha:Number = 1):Sprite {
			var Obj:Sprite = new Sprite();
			Obj.graphics.beginFill(BackColor, Alpha);
			Obj.graphics.drawRoundRect(0, 0, W, H, RoundW);
			Obj.graphics.endFill();			
			return Obj;
		}
		
		public static function drawRoundRectWithBorder(W:Number, H:Number, BorderSize:Number, BorderColor:uint, RoundW:Number = 3, BackColor:uint = 0xFFFFFF, Alpha:Number = 1):Sprite {
			var Obj:Sprite = new Sprite();			
			Obj.graphics.beginFill(BackColor, Alpha);
			Obj.graphics.lineStyle(BorderSize, BorderColor, Alpha);
			Obj.graphics.drawRoundRect(0, 0, W, H, RoundW);			
			Obj.graphics.endFill();			
			return Obj;
		}
		
		public static function drawGradient(W:Number, H:Number, Color1:uint, Color2:uint):Sprite {			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [Color1, Color2];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			
			var Obj:Sprite = new Sprite();
			Obj.graphics.beginGradientFill(fillType, colors, alphas, ratios);
			Obj.graphics.drawRect(0, 0, W, H);
			Obj.graphics.endFill();
			
			return Obj;
		}
		
        public static function Ellipse(W:Number, H:Number, BackColor:uint = 0xFFFFFF):Shape {
            var ellipse:Shape = new Shape();
            ellipse.graphics.beginFill(BackColor);
            ellipse.graphics.drawEllipse(0, 0, W, H);
            ellipse.graphics.endFill();
            
            return ellipse;           
        }
		
        public static function EllipseWithBorder(W:Number, H:Number, BackColor:uint, Thickness:Number, BorderColor:uint, BorderAlpha:Number = 1):Shape {
            var ellipse:Shape = new Shape();
            ellipse.graphics.beginFill(BackColor);
            ellipse.graphics.lineStyle(Thickness, BorderColor, BorderAlpha);
            ellipse.graphics.drawEllipse(0, 0, W, H);
            ellipse.graphics.endFill();
            
            return ellipse;           
        }			
	}
	
}