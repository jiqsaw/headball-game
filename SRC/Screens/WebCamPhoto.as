package Screens
{
	import fl.transitions.Photo;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import J.UTIL.Align;
	import J.UTIL.GraphicHelper;

	import com.greensock.layout.*;

	import J.BASE.BaseMovieClip;
	import J.UTIL.JsHelper;
	import J.UTIL.Colors;
	import J.UTIL.WebCam;
	
	import App.Bus;
	import App.Wording;
	import App.Global;
	import App.Lib;
	import HelperControls.Text;
	import HelperControls.CallButton;

	/** @author Feyyaz */
	
	public class WebCamPhoto extends BaseMovieClip
	{
		
		private var mTitle:Text;
		private var mCounterDesc:Text;
		private var mCounter:Text;
		
		private var mTake:CallButton;
		private var mClose:CallButton;
		
		private var mWebCamMask:MovieClip;
		private var mWebCamArea:Sprite;
		
		private var mCam:WebCam;
		
		public function WebCamPhoto() { JsHelper.GATracker("WebCam"); }
		
		override protected function Prep():void 
		{
			mWebCamArea = new Sprite();
			mWebCamMask = new Lib(Lib.WebCamMask);
			mTitle = new Text(Wording.webcamTitle, Text.TitleSmall);
			mCounterDesc = new Text(Wording.webcamPhotoTaking, Text.TitleSmall);
			mCounter = new Text("3", Text.Custom, Colors.Red, 120);
			mClose = new CallButton(CallButton.Close, false);
			mTake = new CallButton(CallButton.Take);
		}
		
		override protected function AddStage():void 
		{
			addChild(mWebCamArea);
			addChild(mWebCamMask);
			addChild(mTitle);
			addChild(mCounterDesc);
			addChild(mCounter);
			addChild(mTake);
			addChild(mClose);
		}
		
		override protected function Events():void 
		{
			this.Click(mTake, TakeClick);
			this.Click(mClose, CloseClick);
		}	
		
		override protected function Load():void 
		{
			this.XY(mWebCamMask, 195, 40);
			this.XY(mTitle, 55, 45);
			this.XY(mCounterDesc, 494, 118);
			this.XY(mCounter, 514, 138);
			this.XY(mTake, 370, 321);
			this.XY(mClose, 520, 321);
			
			mWebCamMask.alpha = .5;
			
			mCounterDesc.rotation = Global.DefaultRotation;
			mCounter.rotation = Global.DefaultRotation;
		}
		
		override protected function Start():void 
		{			
			OpenCam();
		}
		
		//---------------------------------------------------------------------------//		
		
		
		private function OpenCam():void
		{
			mCam = new WebCam(mWebCamArea, 625, 325);
			mCam.CreateCounter(3, mCounter, mCounterDesc);
			
			this.XY(mWebCamArea, 18, 28);
		}
		
		private function TakeClick(e:MouseEvent):void
		{
			mCam.StartCounter(GetPhoto);
		}
		
		private function GetPhoto(e:TimerEvent) {
			var ScreenPhoto:Bitmap = mCam.TakePhoto();
			ScreenPhoto.width = 327;
			ScreenPhoto.height = 170;
			Bus.GetSubPage(new PhotoEdit(ScreenPhoto), false);
			//Bus.GetSubPage(new WebCamPreview(ScreenPhoto));
		}
		
		private function CloseClick(e:MouseEvent):void
		{
			mCam.CloseCamera();
			Bus.CloseSubPage();
		}		
	}
	
}