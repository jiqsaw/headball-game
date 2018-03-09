package 
{
	import App.Lib;
	import App.SoundControl;
	import com.greensock.TweenLite;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.URLRequest;
	import J.BASE.BaseMain;
	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;
	import J.UTIL.WebCam;
	
	/** @author Feyyaz */
	
	public class SwfCom extends Sprite
	{
		public static const MainSwf = "Main.swf";
		public static const HeadCameraSwf = "HeadCamera.swf";
		public static const HeadCameraAppSwf = "HeadCameraApp.swf";
		
		public static const MainSound = "Sounds/Main.mp3";
		
		public static var L:BaseMain;			//Loader
		public static var M:BaseMain;			//Main
		public static var H:BaseMain;			//HeadCamera
		public static var G:Sprite;				//Game Main
		public static var swfMain:Loader;
		public static var swfGame:Loader;		
		public static var swfHeadCamera:Loader;
		
		private static var HeadCamBeforeSound:Boolean;
		
		public function SwfCom() { }
		
		public function StartHeadCamera() {
			swfHeadCamera = new Loader();
			swfHeadCamera.contentLoaderInfo.addEventListener(Event.COMPLETE, HeadCameraLoaded);
			swfHeadCamera.load(new URLRequest(HeadCameraSwf));
		}
		
		private function HeadCameraLoaded(e:Event):void 
		{
			(swfMain != null) ? CloseMain(AddHeadCamera) : AddHeadCamera();
		}
		
		public function AddHeadCamera() {
			if (swfMain != null) 
				L.removeChild(swfMain);
				
			L.dispatchEvent(new Event(SwfGlobal.HEADCAMERA_START));
				
			swfHeadCamera.alpha = 0;
			L.addChild(swfHeadCamera);
			TweenLite.to(swfHeadCamera, 1, { alpha: 1 } );
		}
		
		public function CloseHeadCamera():void
		{
			TweenLite.to(SwfCom.swfHeadCamera, 1, { alpha: 0, onComplete: 
						function () { L.removeChild(SwfCom.swfHeadCamera) } 
						} );
		}
		
		
		
		
		public function StartMain() {
			SwfCom.swfMain.alpha = 0;
			L.addChild(SwfCom.swfMain);
			TweenLite.to(SwfCom.swfMain, .8, { alpha: 1 } );
			
			if (HeadCamBeforeSound) {
				var mMainSound:SoundControl = SwfGlobal.gSounds;
				mMainSound.Play();
			}
		}
		
		public function CloseMain(MainRemovedListener:Function):void
		{
			if (SwfCom.swfMain != null) {
				
				HeadCamBeforeSound = SwfGlobal.SoundOpen;
				var mMainSound:SoundControl = SwfGlobal.gSounds;
				mMainSound.Stop();				
				
				TweenLite.to(SwfCom.swfMain, 1, { alpha: 0, onComplete:MainRemovedListener } );				
			}
		}
		
		public function RestartHeadCamGame() {
			L.removeChild(SwfCom.swfHeadCamera)
			StartHeadCamera();
		}
		
		
		//GAME FUNCTIONS
		public static function SearchOpponentStartBtn() {
			if (G != null)
				G.dispatchEvent(new Event(SwfGlobal.GAME_OPPONENTFINDED));
		}
		
		public static function GameStart() {
			G.dispatchEvent(new Event(SwfGlobal.GAME_START));
		}		
		
		public static function SetFinish() {
			G.dispatchEvent(new Event(SwfGlobal.GAME_SETFINISH));
		}
		
		public static function ReadyToSet() {
			G.dispatchEvent(new Event(SwfGlobal.GAME_READYTOSET));
		}
		
		public static function PosUpdate() {
			G.dispatchEvent(new Event(SwfGlobal.GAME_POSUPDATE));
		}
		
		public static function ShowMessage() {
			G.dispatchEvent(new Event(SwfGlobal.GAME_MESSAGE));
		}
		
		
		public static function GameFinished() {
			M.dispatchEvent(new Event(SwfGlobal.GAME_FINISHED));
		}
		
		public static function RovansGame() {
			//Maç Sonucunu kapat,			
			G.dispatchEvent(new Event(SwfGlobal.GAME_ROVANS));
			M.dispatchEvent(new Event(SwfGlobal.GAME_CLOSE_SUBPAGE));
			
		}
		
		public static function ExitGame() {
			M.dispatchEvent(new Event(SwfGlobal.GAME_EXIT));
		}
		
		public static function RovansOpponentDecline() {  //Rakipin rövanşı kabul etmediğini bildir
			M.dispatchEvent(new Event(SwfGlobal.GAME_ROVANSOPPONENTDECLINE));
		}		
	}
	
}