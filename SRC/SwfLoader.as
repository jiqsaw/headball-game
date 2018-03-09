package  
{	
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import J.UTIL.Colors;
	import J.UTIL.GraphicHelper;
	import J.UTIL.Tools;
	import J.UTIL.WebCam;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.utils.setTimeout;
	
	import J.BASE.BaseMain;
	import J.UTIL.Align;
	import J.UTIL.JsHelper;
	
	/** @author Feyyaz */
	
	public class SwfLoader extends BaseMain
	{
		private var mBack:MovieClip;
		private var mLoading:MovieClip = null;
		private var mSwfCom:SwfCom;
		private var mWanda:MovieClip;
		
		public function SwfLoader() { }
		
		public function GetStage():Stage {
			return this.stage;
		}
		
		override protected function Arrange():void
		{
			SwfCom.L = this;
			mBack = new LoaderBack();
			mLoading = new LoaderLoading();
			this.Config(false, StageScaleMode.NO_SCALE, StageAlign.TOP_LEFT, false);
			
			mSwfCom = new SwfCom();
			mWanda = new Wanda();
		}
		
		override protected function AddStage():void 
		{
			addChild(mBack);
			addChild(mLoading);			
			
			MainLoad();
		}
		
		override protected function Events():void
		{
			stage.addEventListener(Event.RESIZE, ResizeHandler);
			stage.dispatchEvent(new Event(Event.RESIZE));
			
			addEventListener(SwfGlobal.HEADCAMERA_REMOVE, HeadCameraRemoved);
			addEventListener(SwfGlobal.HEADCAMERA_START, HeadCameraStarted);
		}
		
		private function HeadCameraStarted(e:Event):void 
		{
			if (mLoading != null)
			{
				removeChild(mLoading);
				mLoading = null;
			}
		}
		
		private function HeadCameraRemoved(e:Event):void 
		{
			if (SwfCom.swfMain == null)
				MainLoad();
			else
			{
				var mSwfCom:SwfCom = new SwfCom();
				mSwfCom.StartMain();
			}
		}
		
		protected function ResizeHandler(e:Event) {
			if (mBack != null)
				Align.CustomCenter(stage.stageWidth, stage.stageHeight, mBack);
			
			if (mLoading != null)			
				Align.CustomCenter(stage.stageWidth, stage.stageHeight, mLoading, true);
				
			if (mWanda != null) {
				mWanda.x = stage.stageWidth - mWanda.width - 10;
				mWanda.y = stage.stageHeight - mWanda.height - 10;
			}
		}
		
		private function MainLoad():void
		{
			var IsKafaKamerasiURL:String = Tools.GetHtmlVars(SwfCom.L, SwfGlobal.htmlVarsKafaKamerasi);
			if (IsKafaKamerasiURL == "1") {
				var mSwfCom:SwfCom = new SwfCom();
				mSwfCom.StartHeadCamera();
				if (mLoading != null) {
					removeChild(mLoading);
					mLoading = null;
				}
			}
			else {
				SwfCom.swfMain = new Loader();
				SwfCom.swfMain.contentLoaderInfo.addEventListener(Event.COMPLETE, MainLoaded);
				SwfCom.swfMain.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, MainLoadProgress);
				SwfCom.swfMain.load(new URLRequest(SwfCom.MainSwf));
			}
			
		}	
		
		private function MainLoadProgress(e:ProgressEvent):void 
		{
			//JsHelper.Console("MainLoad: + " + int((e.bytesLoaded * 100) / e.bytesTotal).toString());
		}
		
		private function MainLoaded(e:Event):void 
		{
			
			//TweenLite.to(mBack, 1, { alpha: 0 } );
			//removeChild(mBack);
			mSwfCom.StartMain();
			
			AddWanda();
		}			
		
		private function AddWanda():void
		{
			addChild(mWanda);
			mWanda.mouseEnabled = true;
			mWanda.buttonMode = true;
			mWanda.mouseChildren = true;
			
			WandaOut(null);
			
			mWanda.addEventListener(MouseEvent.CLICK, WandaClick);
			mWanda.addEventListener(MouseEvent.MOUSE_OVER, WandaOver);
			mWanda.addEventListener(MouseEvent.MOUSE_OUT, WandaOut);
		}
		
		private function WandaOut(e:MouseEvent):void 
		{
			mWanda.alpha = .4;
		}
		
		private function WandaOver(e:MouseEvent):void 
		{
			mWanda.alpha = 1;
		}
		
		private function WandaClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(SwfGlobal.WandaURL), "_blank");
		}
	}
	
}