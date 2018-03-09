package App
{
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;	
	
	import J.UTIL.NumberUtil;
	import J.UTIL.GraphicHelper;
	import J.UTIL.Colors;
	import J.UTIL.Align;	
	import J.UTIL.McUtil;
	import J.UTIL.JsHelper;
	
	import Services.SFS;
	import Services.SFSClient;
	import Services.SFSCommands;
	import Services.SFSGlobal;	
	import Screens.Entry;
	import Screens.MatchResult;
	import Screens.Profile;
	import UserControls.Frame;
	import UserControls.Logo;
	import Containers.SubContainer;
	import Containers.Master;

	/** @author Feyyaz */
	
	public class Bus 
	{
		public static const START_HOTCAMERA:String = "START_HOTCAMERA";
		
		public function Bus() { }
			
		public static function GetPage(LoadMc:MovieClip) {
			McUtil.McClear(Global.gContainer);
			Global.gContainer.addChild(LoadMc);
		}	
		
		public static function GetSubPage(LoadMc:MovieClip, IsAddSketchs:Boolean = true) {
			
			if (Global.gSubContainer != null)
				McUtil.McClear(Global.gSubContainer);
			else
				ShowOverlay();
			
			Global.gSubContainer = new SubContainer(LoadMc, IsAddSketchs, (Global.gSubContainer == null));
			Global.M.addChild(Global.gSubContainer);
		}		
		
		public static function CloseSubPage():void {
			Global.gSubContainer.alpha = 1;
			TweenLite.to(Global.gSubContainer, .4, { alpha: 0, onComplete:RemoveSubPage } );
			HideOverlay();
		}
		
		static private function RemoveSubPage():void
		{
			Global.M.removeChild(Global.gSubContainer);
			Global.gSubContainer = null;
		}
		
		private static function ShowOverlay():void
		{
			Global.gOverlay = GraphicHelper.draw(Global.M.StageW, Global.M.StageH, Colors.Black, 0.9);
			Global.gOverlay.alpha = 0;
			Global.M.addChild(Global.gOverlay);
			TweenLite.to(Global.gOverlay, .5, { alpha: 1 } );
		}
		
		private static function HideOverlay():void
		{
			TweenLite.to(Global.gOverlay, 1, { alpha: 0, onComplete:RemoveOverlay } );			
		}
		
		static private function RemoveOverlay():void
		{
			Global.M.removeChild(Global.gOverlay);
		}	
		
		public static function StartGame(GameSwfName:String):void {
			
			SwfGlobal.GameType = GameSwfName;
			
			(GameSwfName == Lib.GameClientSwf) ? JsHelper.GATracker("GameClient") : JsHelper.GATracker("Game");
			
			ExternalInterface.call("FlashFocus");
			
			TweenLite.to(Global.gMaster, .4, { alpha: .4, y: -650, ease:Strong.easeOut, onComplete:GamePreRender } );
			
			//if (!Session.sIsSFSLogin) {				
				//JsHelper.Console("SFS | re-connecting...");
				//SFS.Connect();
			//}
		}
		
		public static function GamePreRender() {
			Global.M.removeChild(Global.gMaster);
			Global.gMaster = null;
			
			var mMainSound:SoundControl = SwfGlobal.gSounds;
			mMainSound.Stop();					
			
			GameLoad();			
		}	
		
		static private function GameLoad():void
		{
			//Rakip aramaya başla
			SFSGlobal.IsStartGame = true;
			SFS.FindOpponent();
			
			var GameSwfPath = SwfGlobal.GameType;
			
			//Cache
			SwfCom.swfGame = new Loader();
			SwfCom.swfGame.contentLoaderInfo.addEventListener(Event.COMPLETE, GameLoaded);
			SwfCom.swfGame.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, GameLoadProgress);
			SwfCom.swfGame.load(new URLRequest(GameSwfPath));
			
			
			//NoCache			
			//var URLVar:URLVariables = new URLVariables();
			//var URLReq:URLRequest = new URLRequest(GameSwfPath);
			//URLVar.SwfName = Math.random();						
			//URLReq.data = URLVar;
			//URLReq.method = URLRequestMethod.POST;			
			//SwfCom.swfGame = new Loader();
			//SwfCom.swfGame.contentLoaderInfo.addEventListener(Event.COMPLETE, GameLoaded);
			//SwfCom.swfGame.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, GameLoadProgress);
			//SwfCom.swfGame.load(URLReq);
			
			
			Global.gIndicator = new Indicator();
			Global.gIndicator.alpha = 0;			
			Global.M.addChild(Global.gIndicator);
			TweenLite.to(Global.gIndicator, 1, { alpha: 1 } );
			
		}		
		
		static private function GameLoadProgress(e:ProgressEvent):void 
		{
			if (Global.gIndicator != null) {
				Global.gIndicator.x = Global.M.stage.mouseX;
				Global.gIndicator.y = Global.M.stage.mouseY;
			}
		}
		
		static private function GameLoaded(e:Event):void 
		{
			if (Global.gIndicator != null) {
				Global.M.removeChild(Global.gIndicator);
				Global.gIndicator = null;
			}			
			
			var GameMask:Sprite = GraphicHelper.draw(Global.GameStageW, Global.GameStageH, 0x00ff00);
			
			
			var GameLogo:MovieClip;
			//*************
			if (SwfGlobal.GameType == Lib.GameClientSwf)
			{
				GameLogo = new LibButton(Lib.LogoSmall);
				GameLogo.addEventListener(MouseEvent.CLICK, GameLogoClick);
			}
			else
			{
				GameLogo = new Lib(Lib.LogoSmall);
			}
			//*************			
			 
			
			
			Global.gFrame.mouseChildren = Global.gFrame.mouseEnabled = false;
			GameLogo.mouseChildren = GameLogo.mouseEnabled = false;			
			
			Global.GameContainer = new Sprite();
			Global.GameContainer.addChild(GameMask);
			Global.GameContainer.addChild(SwfCom.swfGame);			
			Global.GameContainer.addChild(Global.gFrame);
			Global.GameContainer.addChild(GameLogo);
			GameLogo.x = 20;
			GameLogo.y = 20;			
			
			Global.M.addChild(Global.GameContainer);
			
			GameMask.x = SwfCom.swfGame.x = 42;
			GameMask.y = SwfCom.swfGame.y = 58;			
			SwfCom.swfGame.mask = GameMask;
			
			Global.M.ResizeHandler(null);
			var GameContainerY:Number = Global.GameContainer.y;
			Global.GameContainer.y = -Global.GameContainer.height;
			TweenLite.to(Global.GameContainer, 1, { y:GameContainerY, ease:Bounce.easeOut } );			
		}
		
		static private function GameLogoClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://www.ruffles.com.tr/enkafadar/"), "_self");
		}
		
		public static function GoToDefault() {
			(Session.sIsLogin) ? Bus.GetPage(new Profile()) : Bus.GetPage(new Entry());
			Global.gMaster.MenuDefault();
		}		
		
		public static function FrameEffect() {
			Global.gFrame.gotoAndPlay(2);
		}
		
		public static function ReturnProfile() {
			Bus.CloseSubPage();
			Bus.GetPage(new Profile());			
		}
		
		public static function ExitGame() {
			CloseSubPage();
			
			Global.M.removeChild(Global.GameContainer);
			Global.GameContainer = null;
			
			Global.gMaster = new Master();
			Global.M.addChild(Global.gMaster);
			Global.M.ResizeHandler(null);
		}
	}
	
}