package J.UTIL
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/** @author Feyyaz */
	
	public class Align 
	{
		
		public function Align()  { }
		
		public static function CustomCenter (W:Number, H:Number, obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				
				var X:Number = W / 2 - obj.width / 2;
				var Y:Number = H / 2 - obj.height / 2;
				
				if (IsTween)
					TweenLite.to(obj, .5, { x: X, y: Y } );
				else {
					obj.x = X;
					obj.y = Y;
				}
			}
		}
		
		public static function toCenterOfSize (obj:DisplayObject, W:Number, H:Number, IsTween:Boolean = false):void
		{
			if (obj != null) {
				
				var X:Number = obj.stage.stageWidth / 2 - W / 2;
				var Y:Number = obj.stage.stageHeight / 2 - H / 2;
				
				if (IsTween)
					TweenLite.to(obj, .5, { x: X, y: Y } );
				else {
					obj.x = X;
					obj.y = Y;
				}
			}
		}		
		
		public static function toCenter (obj:DisplayObject, IsTween:Boolean = false):void
		{
			try 
			{
				if (obj != null) {
					if (IsTween) {
						
					}
					else {
						obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
						obj.y = obj.stage.stageHeight / 2 - obj.height / 2;
					}
				}				
			}
			catch (e:Error) { }
		}
		
		public static function toTopLeft(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {				
					obj.x = obj.stage.x;
					obj.y = obj.stage.y;
				}
			}
		}
		
		public static function toTopCenter(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {				
					obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
					obj.y = obj.stage.y;
				}
			}
		}
		
		public static function toTopRight(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {
					obj.x = obj.stage.stageWidth - obj.width;
					obj.y = obj.stage.y;
				}
			}
		}
		
		public static function toBottomRight(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {				
					obj.x = obj.stage.stageWidth - obj.width;
					obj.y = obj.stage.stageHeight - obj.height;
				}
			}
		}
		
		public static function toBottomCenter(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {				
					obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
					obj.y = obj.stage.stageHeight - obj.height;
				}
			}
		}
		
		public static function toBottomLeft(obj:DisplayObject, IsTween:Boolean = false):void
		{
			if (obj != null) {
				if (IsTween) {
					
				}
				else {				
					obj.x = obj.stage.x;
					obj.y = obj.stage.stageHeight - obj.height;
				}
			}
		}		
		
		public static function FullStage(Obj:Object, W:Number, H:Number) {
			
			if (Obj != null) {
				Obj.width = W;
				Obj.height = H;
			}
		}
	}
	
}