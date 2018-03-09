package Screens
{	
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	import J.UTIL.Align;
	import J.UTIL.GraphicHelper;
	import J.UTIL.McUtil;
	import J.UTIL.Tools;
	
	import App.Bus;
	import App.Session;	
	import HelperControls.Paging;
	import HelperControls.PhotoEditButton;
	import HelperControls.ResizePhotoMaskPoint;
	import Services.PhpData;
	import UserControls.Accessories;
	import UserControls.ResizePhotoMask;
	
	import J.UTIL.JsHelper;
	import J.BASE.BaseMovieClip;
	import J.UTIL.Filter;
	import J.UTIL.Colors;

	import App.Wording;
	import App.Global;	
	import App.Lib;
	import HelperControls.Text;
	import HelperControls.CallButton;
	import UserControls.PhotoEditProgress;
	
	/** @author Feyyaz */
	
	public class PhotoEdit extends BaseMovieClip
	{
		private var mTitle:Text;		
		private var mAccessory:Text;
		
		private var mSave:CallButton;
		private var mClose:CallButton;
		
		private var mMask:ResizePhotoMask;
		private var mPhoto:Bitmap;
		
		private var mMove:PhotoEditButton;
		private var mRotate:PhotoEditButton;
		private var mZoom:PhotoEditButton;
		
		private var mTypeHead:MovieClip;
		
		public static var tMove:Number = 1;
		public static var tRotate:Number = 2;
		public static var tZoom:Number = 3;
		
		private var EditType:Number;
		
		private var tHeadTitle:Text;
		private var mProgress:PhotoEditProgress;
		private var mProgress2:PhotoEditProgress;
		
		private var PhotoContainer:MovieClip;
		
		private var PhotoMc:MovieClip;
		
		//---------------------------------------------------------------------------//
		
		public function PhotoEdit(Photo:Bitmap) { 
			JsHelper.GATracker("FotoDuzenleme"); 
			this.mPhoto = Photo;
			
			if (this.mPhoto.height > Global.gPhotoMaxH)
				Tools.ResizeConstrain(this.mPhoto, Global.gPhotoMaxH, false);			
		}
		
		override protected function Prep():void 
		{
			PhotoContainer = new MovieClip();
			mTitle = new Text(Wording.photoeditTitle, Text.TitleSmall);
			mAccessory = new Text(Wording.photoeditAcaccessory, Text.List);
			mSave = new CallButton(CallButton.Save);
			mClose = new CallButton(CallButton.Close);
			
			mMove = new PhotoEditButton(PhotoEditButton.tMove);
			mRotate = new PhotoEditButton(PhotoEditButton.tRotate);
			mZoom = new PhotoEditButton(PhotoEditButton.tZoom);
			
			mMask = new ResizePhotoMask();
			
			PhotoMc = new MovieClip();
			PhotoMc.addChild(this.mPhoto);
			mPhoto.x -= mPhoto.width/2;
			mPhoto.y -= mPhoto.height/2;			
			
			CreateTypeHead();
		}
		
		override protected function AddStage():void 
		{
			PhotoContainer.addChild(PhotoMc);
			PhotoContainer.addChild(mMask);
			addChild(PhotoContainer);
			
			addChild(mTitle);
			addChild(mSave);
			addChild(mClose);
			
			addChild(mMove);
			addChild(mRotate);
			addChild(mZoom);
			
			addChild(mTypeHead);					
		}
		
		override protected function Events():void 
		{
			this.Click(mMove, MoveClick);
			this.Click(mRotate, RotateClick);
			this.Click(mZoom, ZoomClick);
			this.Click(mSave, SaveClick);
			
			PhotoMc.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
		}			
		
		private function Drag(e:MouseEvent ):void
		{
			//var X:Number = kadrajX - ((PhotoMc.x + PhotoMc.width) - (kadrajX + kadrajW));
			//var Y:Number = -kadrajH;//kadrajY - ((PhotoDragContainer.y + PhotoDragContainer.height) + (kadrajY + kadrajH));
			//var W:Number = (PhotoMc.width) - (kadrajW / 2);
			//var H:Number = (PhotoMc.height / 2);
			
			//PhotoMc.startDrag(false, new Rectangle(X, Y, W, H));
			PhotoMc.startDrag();
			PhotoMc.addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
		}
		private function Drop(e:MouseEvent):void 
		{
			PhotoMc.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, Drop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			PhotoMc.removeEventListener(MouseEvent.MOUSE_MOVE, Dragging);			
		}
		
		protected function Dragging(e:Event):void {
			//if (PhotoMc.x > mMask.x) PhotoMc.x = mMask.x;
			//if (PhotoMc.y > mMask.y) PhotoMc.y = mMask.y;
			//
			//if ((PhotoMc.x + PhotoMc.width) < (kadrajX )) {
				//PhotoMc.x = (kadrajX + kadrajW) - PhotoMc.width;
			//}
			//
			//if (PhotoMc.y + PhotoMc.width > mMask.y + mMask.width) 
				//PhotoMc.y = mMask.y + mMask.width;
		}
		
		override protected function Load():void 
		{						
			this.XY(mMask, 120, 98);							
			
			this.XY(mTitle, 46, 58);			
			this.XY(mSave, 365, 321);
			this.XY(mClose, 520, 321);
			
			this.XY(mMove, 210, 110);
			this.XY(mRotate, 252, 182);
			this.XY(mZoom, 215, 242);
			
			this.XY(mTypeHead, 315, 85);
			
			PhotoContainer.y = 30;
		}
		
		var kadrajX:Number = 54;
		var kadrajY:Number = 98;
		var kadrajW:Number = 119;
		var kadrajH:Number = 151;		
		override protected function Start():void 
		{
			mPhoto.mask = mMask;
			
			mMove.filters = new Array(Filter.DropShadow());
			mRotate.filters = new Array(Filter.DropShadow());
			mZoom.filters = new Array(Filter.DropShadow());
			
			mMask.addEventListener(ResizePhotoMask.DRAGGING, GenerateMask);
			
			AddMaskTemp();
			GenerateMask(null);
			AddAccessories();
			
			this.PhotoMc.x = kadrajX + kadrajW / 2;
			this.PhotoMc.y = kadrajY + kadrajH / 2;			
			
			mMove.dispatchEvent(new MouseEvent(MouseEvent.CLICK));			
		}		
		
		// NOKTALI MASK İŞLEMLERİ
		var s:Shape = new Shape();
		private function GenerateMask(e:Event) {
			s.graphics.clear();
			s.graphics.beginFill(Colors.White);
            s.graphics.lineStyle(2, 0xFF0000);
			
			for (var i:int = 0; i < mMask.arrPoints.length; i++) 
				CurveTo(s, i);
			
            s.graphics.endFill();
		}
		
		private function AddMaskTemp() {						
			PhotoContainer.addChild(s);
			this.XY(s, mMask.x, mMask.y);
			mPhoto.mask = s;
		}
		
		private function CurveTo(ControlShape:Shape, Index:Number) {
			var Curve:ResizePhotoMaskPoint = mMask.arrCurves[Index] as ResizePhotoMaskPoint;
			var Point:ResizePhotoMaskPoint = mMask.arrPoints[Index] as ResizePhotoMaskPoint;
			ControlShape.graphics.curveTo(Curve.x, Curve.y, Point.x + Point.width / 2, Point.y + Point.height / 2);
		}
		
		//---------------------------------------------------------------------------//
		
		private function MoveClick(e:MouseEvent):void
		{
			tHeadTitle.text = Wording.photoedittypeMove;
			TypeAction(tMove);
		}
		
		private function RotateClick(e:MouseEvent):void
		{
			tHeadTitle.text = Wording.photoedittypeRotate;
			TypeAction(tRotate);
		}
		
		private function ZoomClick(e:MouseEvent):void
		{
			tHeadTitle.text = Wording.photoedittypeZoom;
			TypeAction(tZoom);
		}
		
		private function CreateTypeHead():void
		{
			mTypeHead = new MovieClip();
			
			var Bar:Sprite = GraphicHelper.drawRoundRect(295, 4, 1, 0xd58b00);
			var HeadBack:Sprite = GraphicHelper.drawRoundRect(150, 32, 5);
			tHeadTitle = new Text("", Text.Custom, Colors.Black, 21);
			
			mTypeHead.addChild(Bar);
			mTypeHead.addChild(HeadBack);
			mTypeHead.addChild(tHeadTitle);
			
			this.XY(Bar, 0, HeadBack.height / 2);
			this.XY(HeadBack, 75, 0);
			this.XY(tHeadTitle, 80, 3);
			
			mTypeHead.rotation = Global.DefaultRotation
		}
		
		private function TypeAction(SelectedEditType:Number):void
		{
			try
			{								
				removeChild(mProgress);
				removeChild(mProgress2);
			}
			catch (e:Error) { }
			
			switch (SelectedEditType)
			{
				case tMove:
					mMove.mouseEnabled = false;
					mRotate.mouseEnabled = true;
					mZoom.mouseEnabled = true;
					
					mMove.mActive.visible = true;
					mRotate.mActive.visible = false;
					mZoom.mActive.visible = false;
					
					mProgress = new PhotoEditProgress(PhotoEditProgress.tMoveHorizontal, PhotoMc, kadrajX, kadrajY, kadrajW, kadrajH);
					
					mProgress2 = new PhotoEditProgress(PhotoEditProgress.tMoveVertical, PhotoMc, kadrajX, kadrajY, kadrajW, kadrajH);
					addChild(mProgress2);
					this.XY(mProgress2, 327, 190);
				break;
				
				case tRotate:
					mRotate.mouseEnabled = false;
					mMove.mouseEnabled = true;
					mZoom.mouseEnabled = true;				
					
					mRotate.mActive.visible = true;
					mMove.mActive.visible = false;
					mZoom.mActive.visible = false;
					
					mProgress = new PhotoEditProgress(PhotoEditProgress.tRotate, PhotoMc, kadrajX, kadrajY, kadrajW, kadrajH);
				break;
				
				case tZoom:
					mZoom.mouseEnabled = false;
					mRotate.mouseEnabled = true;
					mMove.mouseEnabled = true;
					
					mZoom.mActive.visible = true;
					mRotate.mActive.visible = false;
					mMove.mActive.visible = false;
					
					mProgress = new PhotoEditProgress(PhotoEditProgress.tZoom, PhotoMc, kadrajX, kadrajY, kadrajW, kadrajH);				
				break;
			}
			
			addChild(mProgress);
			this.XY(mProgress, 327, 140);
		}
		
		var mPaging:Paging;
		
		private function AddAccessories():void
		{
			mPaging = new Paging(mAccessory);
			addChild(mPaging);
			this.XY(mPaging, 70, 295);
			
			mPaging.addEventListener(mPaging.REPEATING, onRepeating);
			
			var List:MovieClip = new MovieClip();			
			addChild(List);
			this.XY(List, mMask.x, mMask.y + 30);
			List.mouseChildren = false;
			List.mouseEnabled = false;
			mPaging.Generate(List, 5, 1, 0, 0, 0);
			
			mPaging.GoToPage(Session.sAccessoryNo);
		}
		
		private function onRepeating(e:Event):void
		{
			mPaging.Item = new Accessories(mPaging.ShowIndex + 1);
			mPaging.Item.mouseEnabled = false;
		}		
		
		private function SaveClick(e:MouseEvent):void
		{
			mMask.visible = false;
			GenerateAvatar();		//Avatarı oluştur, oyun için global de sakla			
		}
			
		private function GenerateAvatar() {
			var AvatarData:BitmapData = new BitmapData(119, 152, true, 0);
			AvatarData.draw(PhotoContainer, new Matrix(1, 0, 0, 1, -79, -mMask.y));
			Session.sAvatarHot = new Bitmap(AvatarData, "auto", true);
			
			//Avatarı server a kaydet
			var php:PhpData = new PhpData(SaveAvatarResult);
			php.SaveAvatar(AvatarData, mPaging.PageNo);
			Session.sAccessoryNo = mPaging.PageNo;
		}
		
		private function SaveAvatarResult(e:Event):void
		{
			Bus.CloseSubPage();
			Bus.GetPage(new Profile());
		}
	}
	
}