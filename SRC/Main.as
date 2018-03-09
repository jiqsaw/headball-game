package 
{					
	import App.Bus;
	import App.Lib;
	import App.Session;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.display.Sprite;	
	import flash.text.TextField;
	import J.UTIL.JsHelper;
	import Screens.MatchResult;
	import Services.SFSGlobal;
	
	import App.SoundControl;
	import HelperControls.Text;
	import UserControls.ResizePhotoMask;
	
	import J.BASE.BaseText;	
	import J.BASE.BaseMain;
	import J.UTIL.Align;	

	import App.Wording;
	import App.Global;
	import Containers.Master;

	/** @author Feyyaz */
		
	public class Main extends BaseMain
	{
		//---------------------------------------------------------------------------//
		
		public function Main() { }
		
		override protected function Arrange():void
		{
			SwfCom.M = this;
			Global.M = this;			
			Global.Back = new Lib(Lib.BackImg);			
			this.Config(false, StageScaleMode.NO_SCALE, StageAlign.TOP_LEFT, false);
			
			addChild(Global.Back);
		}
		
		override protected function AddStage():void
		{
			Global.gMaster = new Master();
			addChild(Global.gMaster);
		}
		
		override protected function Events():void
		{
			stage.addEventListener(Event.RESIZE, ResizeHandler);
			stage.dispatchEvent(new Event(Event.RESIZE));
			
			
			//GAME EVENTS
			addEventListener(SwfGlobal.GAME_FINISHED, GameFinished);
			addEventListener(SwfGlobal.GAME_CLOSE_SUBPAGE, CloseSubPageforGame);	//Sonuç Sayfasını kapat						
			addEventListener(SwfGlobal.GAME_EXIT, GameExit);	//Rövanşa hayır dedim, oyunu kapat
			addEventListener(SwfGlobal.GAME_ROVANSOPPONENTDECLINE, OpponentRovansDecline);	//Rakip rövanş ret cevabını bildir 
		}
		
		//---------------------------------------------------------------------------//
		
		public function ResizeHandler(e:Event) {
			if (stage != null) {
				Align.CustomCenter(stage.stageWidth, stage.stageHeight, Global.Back);			
				Align.toCenter(Global.gMaster);			
				Align.FullStage(Global.gOverlay, stage.stageWidth, stage.stageHeight);
				
				if (Global.GameContainer != null) {
					Global.GameContainer.x = (stage.stageWidth / 2) - (Global.gFrame.width / 2);
					Global.GameContainer.y = (stage.stageHeight / 2) - (Global.gFrame.height / 2) - 28;
				}
			}
		}
		
		//GAME COMMUNICATION
		private var mMacthResult:MatchResult = null;
		private function GameFinished(e:Event):void
		{
			if (SFSGlobal.GameStarted) {
				mMacthResult = new MatchResult();
				Bus.GetSubPage(mMacthResult, false);
			}
		}
		
		private function CloseSubPageforGame(e:Event) {
			if (SwfCom.swfGame != null) {
				SwfCom.swfGame.tabEnabled = true;
				SwfCom.swfGame.tabIndex = 0;
			}
			Bus.CloseSubPage();
		}
		
		private function GameExit(e:Event) {
			Bus.ExitGame();
			SFSGlobal.Reset();
		}
		
		private function OpponentRovansDecline(e:Event) {
			mMacthResult.SetRovansStatus(Wording.matchresultRovansDecline);
		}		
	}
}