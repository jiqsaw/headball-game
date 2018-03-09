package Screens
{
	import com.greensock.layout.AlignMode;
	import com.greensock.layout.AutoFitArea;
	import com.greensock.layout.ScaleMode;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import J.BASE.BaseMovieClip;
	import J.UTIL.JsHelper;
	import J.UTIL.Filter;
	import J.UTIL.Colors;
	
	import App.Lib;
	import App.Bus;
	import App.Global;
	import App.Wording;
	import HelperControls.Text;
	import HelperControls.CallButton;
	
	/** @author Feyyaz */
	
	public class WebCamPreview extends BaseMovieClip
	{
		
		private var mChange:CallButton;
		private var mOk:CallButton;
		
		private var mWebCamMask:MovieClip;
		
		private var mTitle:Text;
		private var mDesc:Text;
		
		private var Photo:Bitmap;
		
		public function WebCamPreview(Photo:Bitmap) { 
			JsHelper.GATracker("WebCamOnizleme"); 
			this.Photo = Photo;
		}
		
		override protected function Prep():void 
		{
			mWebCamMask = new Lib(Lib.PreviewMask);
			mTitle = new Text(Wording.webcamTitle, Text.TitleSmall);
			mDesc = new Text(Wording.webcamPreviewDesc);
			mOk = new CallButton(CallButton.Ok);
			mChange = new CallButton(CallButton.Change);
		}
		
		override protected function AddStage():void 
		{
			addChild(Photo);
			addChild(mWebCamMask);
			addChild(mTitle);
			addChild(mDesc);
			addChild(mChange);
			addChild(mOk);			
		}
		
		override protected function Events():void 
		{
			this.Click(mChange, ChangeClick);
			this.Click(mOk, OkClick);
		}
		
		override protected function Load():void 
		{
			//this.XY(Photo, 20, 85);
			this.XY(mWebCamMask, 135, 90);
			this.XY(mTitle, 55, 45);
			this.XY(mDesc, 300, 165);
			this.XY(mChange, 350, 321);
			this.XY(mOk, 520, 321);			
		}
		
		override protected function Start():void 
		{			
			//Photo.mask = mWebCamMask;
			
			var area:AutoFitArea = new AutoFitArea(this, mWebCamMask.x, mWebCamMask.x, mWebCamMask.width, mWebCamMask.height);
			area.attach(Photo, ScaleMode.NONE, AlignMode.CENTER, AlignMode.CENTER, false);			
		}
		
		private function ChangeClick(e:MouseEvent):void
		{
			Bus.GetSubPage(new WebCamPhoto());
		}
		
		private function OkClick(e:MouseEvent):void
		{
			Bus.GetSubPage(new PhotoEdit(Photo));
		}		
	}
	
}