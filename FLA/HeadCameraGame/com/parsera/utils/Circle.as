package  com.parsera.utils
{
	import flash.geom.Point;
	/**
	$(CBI)* ...
	$(CBI)* @author ...
	$(CBI)*/
	public class Circle
	{
		public var  p:Point;
		public var r:int;
		public function Circle(_p:Point,_r:int) 
		{
			p = _p;
			r = _r;
		}
		public function hitTest(c:Circle):Point {
			
			if (c == null) {
				return null;
			}
			
			//this.print();
			//c.print();
			var d:Number = Math.sqrt(Math.pow(p.x - c.p.x, 2) +  Math.pow(p.y - c.p.y, 2));
			
			if (this.r + c.r > d) {
					var alpha:Number = Math.acos( Math.abs(this.p.x - c.p.x) / d);
					var hitX:Number;
					if (c.p.x > this.p.x) {
							hitX = Math.cos(alpha)*this.r + this.p.x;
					}else {
							hitX =  this.p.x  -  Math.cos(alpha)*this.r ;
					}
					var hitY:Number = Math.sin(alpha)*this.r + this.p.y;
					return new Point(hitX, hitY);
			}
			return null;
		}
		
		public function hitVector(c:Circle,speedY:Number):Point {
			
			if (c == null) {
				return null;
			}
			
			//this.print();
			//c.print();
			var d:Number = Math.sqrt(Math.pow(p.x - c.p.x, 2) +  Math.pow(p.y - c.p.y, 2));
			
			if (this.r + c.r > d) {
					var alpha:Number = Math.acos( Math.abs(this.p.x - c.p.x) / d);
					var hitX:Number;
					if (c.p.x > this.p.x) {
							hitX = Math.cos(alpha) * this.r;
							hitX = -speedY * Math.cos(alpha);
					}else {
							hitX =  -  Math.cos(alpha) * this.r ;
							hitX = speedY * Math.cos(alpha);
							
					}
					var hitY:Number = -speedY * Math.sin(alpha);
					//trace("hit vector x " + hitX + " y " + hitY );
					return new Point(hitX, hitY);
			}
			return null;
		}
		
		public function print() {
			trace(" x " + this.p.x + " y " + this.p.y + " r " + this.r );
		}
	}
	

}