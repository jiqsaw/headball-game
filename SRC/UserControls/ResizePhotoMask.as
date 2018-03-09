package UserControls
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import HelperControls.ResizePhotoMaskPoint;
	import J.BASE.BaseButton;
	import J.UTIL.Colors;
	import J.UTIL.GraphicHelper;
	import J.UTIL.McUtil;
	
	import J.BASE.BaseMovieClip;
	
	/** @author Feyyaz */
	
	public class ResizePhotoMask extends BaseMovieClip
	{
		public static var DRAGGING:String = "DRAGGING";
		
		var s:Shape;
		
		var arrDots:Array;
		public var arrPoints:Array;
		public var arrCurves:Array;
		
		var DotsContainer:MovieClip;
		var PointsContainer:MovieClip;
		
		public function ResizePhotoMask() { }
		
		override protected function Prep():void 
		{
			arrDots = new Array();
			arrPoints = new Array();
			arrCurves = new Array();
			
			DotsContainer = new MovieClip();
			PointsContainer = new MovieClip();			
		}
		
		override protected function AddStage():void 
		{
			addChild(DotsContainer);
			addChild(PointsContainer);
		}
		
		override protected function Load():void 
		{
		}
		
		override protected function Start():void 
		{
			SetDots();
			
			GeneratePoints();
			GenerateMask();
		}
		
		private function SetDots():void
		{
			arrDots[0] = "48, -4, 63, 40";
			arrDots[1] = "70, 50, 65, 57";
			arrDots[2] = "80, 73, 78, 77";
			arrDots[3] = "76, 80, 71, 84";
			arrDots[4] = "72, 92, 72, 92";
			arrDots[5] = "65, 109, 68, 113";
			arrDots[6] = "69, 125, 42, 125";
			arrDots[7] = "34, 122, 19, 148";
			
			arrDots[8] = "-18, 165, -32, 115";	//Sabit arka
			arrDots[9] = "-60, 20, 0, 0"; 		//Sabit arka			
		}
		
		private function GenerateMask() {	
            var s:Shape = new Shape();
			//s.graphics.beginFill(Colors.White);
            s.graphics.lineStyle(2, 0xFFFFFF);
			
			for (var i:int = 0; i < arrDots.length; i++) 
				CurveTo(s, i);
			
            s.graphics.endFill();
			
			McUtil.McClear(DotsContainer);
			DotsContainer.addChild(s);
		}
		
		private function GeneratePoints() {
			for (var i:int = 0; i < arrDots.length; i++) {
				
				arrPoints[i] = new ResizePhotoMaskPoint(i, ResizePhotoMaskPoint.tPoint);
				arrCurves[i] = new ResizePhotoMaskPoint(i, ResizePhotoMaskPoint.tCurve);
				
				PointsContainer.addChild(arrPoints[i]);
				PointsContainer.addChild(arrCurves[i]);
				
				PointPositions(arrPoints[i], i);
				CurvePositions(arrCurves[i], i);
				
				(arrPoints[i] as ResizePhotoMaskPoint).addEventListener(ResizePhotoMaskPoint.DRAGGING, Dragging);
				(arrCurves[i] as ResizePhotoMaskPoint).addEventListener(ResizePhotoMaskPoint.DRAGGING, Dragging);				
			}
			
			arrPoints[7].visible = false;
			arrPoints[8].visible = false;
			arrPoints[9].visible = false;
			
			//arrPoints[2].visible = arrPoints[4].visible = arrPoints[7].visible = arrPoints[8].visible = arrPoints[9].visible = false;
			arrCurves[0].visible = arrCurves[1].visible = arrCurves[2].visible = arrCurves[3].visible = arrCurves[4].visible = false;
			arrCurves[5].visible = arrCurves[6].visible = arrCurves[7].visible = arrCurves[8].visible = arrCurves[9].visible = false;
		}		
		
		private function CurveTo(ControlShape:Shape, Index:Number) {
			var Curve:ResizePhotoMaskPoint = arrCurves[Index] as ResizePhotoMaskPoint;
			var Point:ResizePhotoMaskPoint = arrPoints[Index] as ResizePhotoMaskPoint;
			ControlShape.graphics.curveTo(Curve.x, Curve.y, Point.x + Point.width / 2, Point.y + Point.height / 2);
		}
		
		private function GetPos(Index:Number, PointNo:Number) {
			return (arrDots[Index].toString().split(",")[PointNo]);
		}
		
		private function PointPositions(Control:MovieClip, PointIndex:Number) {
			var X:Number = GetPos(PointIndex, 2) - (Control.width / 2);
			var Y:Number = GetPos(PointIndex, 3) - (Control.height / 2);
			this.XY(Control, X, Y);
		}
		
		private function CurvePositions(Control:MovieClip, PointIndex:Number) {
			var X:Number = GetPos(PointIndex, 0);
			var Y:Number = GetPos(PointIndex, 1);
			this.XY(Control, X, Y);
		}		
		
		private function Dragging(e:Event):void
		{
			if (e.target.x < 20) e.target.x = 20;
			if (e.target.x > 100) e.target.x = 100;
			if (e.target.y > 150) e.target.y = 150;
			if (e.target.y < -8) e.target.y = -8;
			
			GenerateMask();
			dispatchEvent(new Event(DRAGGING));
		}	
	} 
	
}