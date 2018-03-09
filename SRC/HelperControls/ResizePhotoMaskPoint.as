package HelperControls
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import J.BASE.BaseButton;
	import J.UTIL.Colors;
	import J.UTIL.GraphicHelper;
	
	/** @author Feyyaz */
	
	public class ResizePhotoMaskPoint extends BaseButton
	{
		public static var DRAGGING:String = "DRAGGING";
		
		var mPoint:Shape;
		var mCurve:Sprite;
		public var Index:Number;
		
		public static const tPoint = "Point";
		public static const tCurve = "Curve";
		
		public function ResizePhotoMaskPoint(Index:Number, ItemType:String)
		{
			this.Index = Index;
			this.ItemType = ItemType;
		}
		
		override protected function Start():void 
		{
			if (ItemType == tPoint) {
				mPoint = GraphicHelper.EllipseWithBorder(7, 7, Colors.Blue, 2, Colors.White);
				addChild(mPoint);
			}
			else {
				mCurve = GraphicHelper.drawRoundRectWithBorder(5, 5, 1, Colors.White, 1, Colors.Red);
				addChild(mCurve);
			}
			
			addEventListener(MouseEvent.MOUSE_DOWN, Drag);
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			if (ItemType == tPoint)
				mPoint.scaleX = mPoint.scaleY = 1.5;
			else
				mCurve.scaleX = mCurve.scaleY = 1.5;
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			if (ItemType == tPoint)
				mPoint.scaleX = mPoint.scaleY = 1;
			else
				mCurve.scaleX = mCurve.scaleY = 1;
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			//trace("PointClick");
		}		
		
		private function Drag(e:MouseEvent) {
			this.startDrag();			
			
			addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);			
		}
		
		private function Dragging(e:MouseEvent):void 
		{
			dispatchEvent(new Event(DRAGGING));
		}
		
		private function Drop(e:MouseEvent) {
			stopDrag();
			removeEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, Drop);
		}		
	}
	
}