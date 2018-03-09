package  
{	
	import com.greensock.TweenLite;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import HeadCameraSrc.Congratulations;
	import HeadCameraSrc.SaveScore;
	import HeadCameraSrc.SaveScoreFinish;
	
	
	import App.DataManagement;
	import HeadCameraSrc.Splash;
	import Services.PhpData;
	
	import J.UTIL.Align;
	import J.UTIL.McUtil;
	import J.UTIL.Colors;
	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;
	import J.UTIL.WebCam;
	
	import J.BASE.BaseMain;
	
	/** @author Feyyaz */
	
	public class HeadCamera extends BaseMain
	{
		
		private var swfHeadCameraApp:Loader;	
		
		public var TopScore:Number;
		public var GameScore:Number;
		
		public function HeadCamera() 
		{
			trace("Loaded HeadCamera");
		}
		
		override protected function Arrange():void
		{
			SwfCom.H = this;
			StartHeadCamera();			
		}
		
		public function GetStage():Stage {
			return this.stage;
		}
		
		override protected function Events():void
		{
			stage.addEventListener(Event.RESIZE, ResizeHandler);
			stage.dispatchEvent(new Event(Event.RESIZE));
		}		
		
		private function StartHeadCamera() {
			if (!WebCam.HasCamera()) {
				JsHelper.GATracker("KafaKamerasi_KameraYok");
				HeadCameraLoaded(null);
			}
			else {
				JsHelper.GATracker("KafaKamerasi");
				swfHeadCameraApp = new Loader();
				swfHeadCameraApp.contentLoaderInfo.addEventListener(Event.COMPLETE, HeadCameraLoaded);
				swfHeadCameraApp.load(new URLRequest(SwfCom.HeadCameraAppSwf));
			}
		}
		
		var mHeadCamAppFrame:HeadCamAppFrame;		
		var HeadCameraContainer:MovieClip;
		var mBtnStartGame:MovieClip;
		
		var mSplash:Splash;
		var mWebCamSplash:MovieClip;
		
		private function HeadCameraLoaded(e:Event):void
		{		
			mHeadCamAppFrame = new HeadCamAppFrame();
			
			HeadCameraContainer = new MovieClip();
			HeadCameraContainer.mouseEnabled = false;
			
			HeadCameraContainer.addChild(mHeadCamAppFrame);
			
			if (WebCam.HasCamera()) {
				mSplash = new Splash();
				mSplash.addEventListener(Splash.KAFALA_CLICK, KafalaClicked);
				HeadCameraContainer.addChild(mSplash);
			}
			else {
				var mNoCam:MovieClip = new NoCam();
				HeadCameraContainer.addChild(mNoCam);
				mNoCam.x = 170;
				mNoCam.y = 220;
				
				TweenLite.to(mNoCam, .8, { alpha: 1 } );
			}					
			
			addChild(HeadCameraContainer);
			
			mBtnStartGame = new btnStartGame();
			HeadCameraContainer.addChild(mBtnStartGame);
			mBtnStartGame.x = 486;
			mBtnStartGame.y = 470;
			mBtnStartGame.buttonMode = true;
			
			mBtnStartGame.addEventListener(MouseEvent.CLICK, ExitGame);
			
			ResizeHandler(null);
			
			GetTopScore();
		}
		
		private function KafalaClicked(e:Event):void
		{
			McUtil.McClear(HeadCameraContainer);
			
			var HeadCameraGameBack:Sprite = GraphicHelper.draw(600, 450, Colors.Black);
			
			mWebCamSplash = new WebCamSplash();
			mHeadCamAppFrame = new HeadCamAppFrame();
			
			HeadCameraGameBack.x = swfHeadCameraApp.x = 60;
			HeadCameraGameBack.y = swfHeadCameraApp.y = 40;
			
			HeadCameraContainer.addChild(HeadCameraGameBack);
			HeadCameraContainer.addChild(swfHeadCameraApp);
			
			if (!SwfGlobal.IsHeadCamOpen)
				HeadCameraContainer.addChild(mWebCamSplash);
			else
				swfHeadCameraApp.dispatchEvent(new Event(SwfGlobal.HEADCAMERA_OPENEDCAM));
				
			HeadCameraContainer.addChild(mHeadCamAppFrame);
			
			swfHeadCameraApp.mask = HeadCameraGameBack;				
			
			HeadCameraContainer.addChild(mBtnStartGame);		
			
			swfHeadCameraApp.addEventListener(SwfGlobal.HEADCAMERA_ALLOW, HeadCameraAllow);
			swfHeadCameraApp.addEventListener(SwfGlobal.HEADCAMERA_DENY, HeadCameraDeny);
			swfHeadCameraApp.addEventListener(SwfGlobal.HEADCAMERA_HIGHSCORE, HeadCameraHighScore);
			
			ResizeHandler(null);
		}		
		
		private function GetTopScore():void
		{
			//var php:PhpData = new PhpData(TopScoreLoaded);
			//php.GetTopScore();
			TopScoreLoaded(null);
		}
		
		private function TopScoreLoaded(e:Event):void
		{
			//TopScore = Number(DataManagement.ResultData());
			
			TopScore = SwfGlobal.HeadCamTopScore;
		}
		
		public function HeadCameraAllow(e:Event):void 
		{
			SwfGlobal.IsHeadCamOpen = true;
			try
			{
				HeadCameraContainer.removeChild(mWebCamSplash);
			}
			catch (e:Error) { }
		}
		
		private function HeadCameraDeny(e:Event):void 
		{
			SwfGlobal.IsHeadCamOpen = false;
			ExitGame(null);
		}
		
		//REKOR KIRILDI
		var mCongratulations:Congratulations;		
		private function HeadCameraHighScore(e:Event):void
		{
			try 
			{
				HeadCameraContainer.removeChild(swfHeadCameraApp);	
			}
			catch (e:Error) { }
			
			TopScore = GameScore;
			mCongratulations = new Congratulations(TopScore);
			HeadCameraContainer.addChild(mCongratulations);
			
			mCongratulations.addEventListener(Congratulations.SAVESCORE_CLICK, GetSaveScore);
		}
		
		var mSaveScore:SaveScore;
		private function GetSaveScore(e:Event):void
		{
			HeadCameraContainer.removeChild(mCongratulations);
			mSaveScore = new SaveScore(TopScore);
			HeadCameraContainer.addChild(mSaveScore);
			
			mSaveScore.addEventListener(SaveScore.SAVESCORE_FINISH, SavedScore);
		}
		
		var mSaveScoreFinish:SaveScoreFinish;
		private function SavedScore(e:Event):void
		{
			HeadCameraContainer.removeChild(mSaveScore);
			mSaveScoreFinish = new SaveScoreFinish();
			HeadCameraContainer.addChild(mSaveScoreFinish);
		}
		
		private function ExitGame(e:MouseEvent):void
		{	
			if (swfHeadCameraApp != null)
				swfHeadCameraApp.dispatchEvent(new Event(SwfGlobal.HEADCAMERA_REMOVE));
				
			var mSwfCom:SwfCom = new SwfCom();
			mSwfCom.CloseHeadCamera();
			SwfCom.swfHeadCamera = null;
			
			SwfGlobal.htmlVarsKafaKamerasi = "0";
			
			SwfCom.L.dispatchEvent(new Event(SwfGlobal.HEADCAMERA_REMOVE));
		}
		
		public function ResizeHandler(e:Event) {				
			Align.CustomCenter(stage.stageWidth, stage.stageHeight, HeadCameraContainer);
		}
	}
	
}