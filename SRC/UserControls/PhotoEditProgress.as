package UserControls
{	
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import fl.motion.MatrixTransformer;
	import J.UTIL.Tools;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	import J.UTIL.Align;	
	import J.BASE.BaseProgress;	
	import J.BASE.BaseButton;
	import J.BASE.BaseMovieClip;
	import J.UTIL.GraphicHelper;
	import J.UTIL.Colors;
	
	import App.Wording;
	import HelperControls.Text;
	import Screens.PhotoEdit;
	
	/** @author Feyyaz */
	
	public class PhotoEditProgress extends BaseProgress
	{
		private var LeftText:String;
		private var RightText:String;
		
		private var LeftLabel:Text;
		private var RighttLabel:Text;
		private var Photo:Bitmap;			
		
		public static var tMoveHorizontal:Number = 1;
		public static var tMoveVertical:Number = 2;
		public static var tRotate:Number = 3;
		public static var tZoom:Number = 4;	
		
		private var EditType:Number;
		
		private var BarW:Number = 160;		
		
		var kadrajX:Number// = 54;
		var kadrajY:Number// = 98;
		var kadrajW:Number// = 119;
		var kadrajH:Number// = 151;
		
		private var PhotoMc:MovieClip;
		
		//---------------------------------------------------------------------------//
		
		public function PhotoEditProgress(EditType:Number, PhotoMc:MovieClip, kadrajX:Number, kadrajY:Number, kadrajW:Number, kadrajH:Number) 
		{
			this.kadrajX = kadrajX;
			this.kadrajY = kadrajY;
			this.kadrajW = kadrajW;
			this.kadrajH = kadrajH;
			
			switch (EditType)
			{
				case tMoveHorizontal:							
					this.LeftText = Wording.photoeditprgrssLeft;
					this.RightText = Wording.photoeditprgrssRight;
				break;
				
				case tMoveVertical:							
					this.LeftText = Wording.photoeditprgrssDown;
					this.RightText = Wording.photoeditprgrssUp;
				break;				
				
				case tRotate:					
					this.LeftText = Wording.photoeditprgrssLeft;
					this.RightText = Wording.photoeditprgrssRight;
				break;
				
				case tZoom:
					this.LeftText = Wording.photoeditprgrssZoomOut;
					this.RightText = Wording.photoeditprgrssZoomIn;
				break;					
			}			
			
			this.Photo = Photo;
			this.PhotoMc = PhotoMc;
			this.EditType = EditType;
		}
		
		override protected function Prep():void 
		{
			LeftLabel = new Text(LeftText);
			RighttLabel = new Text(RightText);
			this.Bar = GraphicHelper.draw(BarW, 8);
			this.Track = new J.BASE.BaseButton();
		}
		
		override protected function AddStage():void 
		{
			addChild(LeftLabel);
			addChild(RighttLabel);
			addChild(this.Bar);
			this.Track.addChild(GraphicHelper.drawRoundRectWithBorder(10, 28, 3, Colors.White, 3, 0xe3091f));
			addChild(this.Track);			
		}
		
		override protected function Load():void 
		{		
			this.XY(LeftLabel, 0, 0);
			this.XY(RighttLabel, 235, 0);
			this.XY(this.Bar, 56, 9);
			
			this.XY(this.Track, Bar.x + (Bar.width / 2), 0);
			
			if ((EditType == tRotate) && (PhotoMc.rotation != 0))
				Track.x = (BarW / 2) + (Bar.x + (80 / (180 / PhotoMc.rotation)));			
		}
		
		var MinX:Number = 0;
		var MinY:Number = 0;
		var MaxX:Number = 0;		
		var MaxY:Number = 0;
		
		var MinW:Number = 0;
		var MaxW:Number = 0;
		
		var PhotoStartX:Number = 0;
		var PhotoStartY:Number = 0;
		var PhotoStartW:Number = 0;
		var PhotoStartH:Number = 0;
		
		override protected function Start():void { 					
			MinX = ((kadrajX + kadrajW) - PhotoMc.width) + PhotoMc.width / 2;
			MinY = ((kadrajY + kadrajH) - PhotoMc.height) + PhotoMc.height / 2;
			
			MaxX = kadrajX + PhotoMc.width / 2;
			MaxY = kadrajY + PhotoMc.height / 2;
			
			MinW = kadrajW;
			MaxW = PhotoMc.width * 2;
			
			PhotoStartX = this.PhotoMc.x;
			PhotoStartY = this.PhotoMc.y;
			PhotoStartW = this.PhotoMc.width;
			PhotoStartH = this.PhotoMc.height;
		}
		
		//---------------------------------------------------------------------------//		
		
		var TrackPos:Number;
		override protected function TrackDragging(e:Event):void 
		{			
			TrackPos = (Track.x - Bar.x);
			switch (EditType)
			{
				case tMoveHorizontal:
					MoveHorizontal();
				break;
				
				case tMoveVertical:
					MoveVertical();
				break;
				
				case tRotate:
					Rotate();
				break;
				
				case tZoom:
					Zoom();
				break;
			}
		}				
		
		private function MoveHorizontal() {
			PhotoMc.x = MaxX - ((MaxX - MinX) / (BarW / TrackPos));
		}
		
		private function MoveVertical() {
			PhotoMc.y = MinY + ((MaxY - MinY) / (BarW / TrackPos));
		}				
		
		private function Rotate() {
			TrackPos -= (BarW / 2);
			var rotateSize:Number = 360 / (BarW / TrackPos);
			PhotoMc.rotation = rotateSize;
		}
		
		var PhotoW:Number = 0;
		var PhotoH:Number = 0;
		private function Zoom() {
			PhotoW = PhotoMc.width;
			PhotoH = PhotoMc.height;
			
			var nW = MaxW - ((MaxW - MinW) / (BarW / TrackPos));
			Tools.ResizeConstrain(PhotoMc, nW);
		}		
	}
	
}