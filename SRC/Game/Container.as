package Game
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Services.SFS;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Container extends Sprite
	{
		private var mSearchOpponent:SearchOpponent = null;
		var mOk:MovieClip;
		
		public function Container() 
		{
			GameGlobals.Con = this;
			mSearchOpponent = new SearchOpponent();
			addChild(mSearchOpponent);
		}
		
		public function StartGameBtnCtrl() {
			if (mSearchOpponent != null)
				mSearchOpponent.opponentFound();
		}
		
		var mScoreBoard:ScoreBoard;
		var mBluePlayer:BluePlayer;
		var mRedPlayer:RedPlayer;
		var mAudience:Audience;
		var mMessages:Messages;		
		var mhakemMc:hakemMc;
		var mLeftGame:MovieClip;
		var mBall:Ball;
		var keyEvents:KeyboardEvents;
		
		public function StartGame() {
			if (mSearchOpponent != null) {
				removeChild(mSearchOpponent);
				mSearchOpponent = null;
			}					
			
			initAudience();
			initArrows();			
			initScoreBoard();
			initRedPlayer();
			initBluePlayer();
			initHakem();			
			initLeftGame();
			initBall();					
			
			InitKeyboardEvents();
		}
		
		private function initArrows():void
		{
			mOk = new oklarmc();
			addChild(mOk);
			mOk.y = 100;			
			ShowArrows("left");
		}
		
		
		private function InitKeyboardEvents():void
		{
			keyEvents = new KeyboardEvents();
			if (SwfCom.M != null) {
				keyEvents.enableEvents(SwfCom.M.stage);
				
				SwfCom.M.addEventListener(Event.REMOVED_FROM_STAGE, RemoveGame);
			}
		}
		
		private function RemoveGame(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, RemoveGame);
			keyEvents.disableEvents(SwfCom.M.stage);
		}
		
		private function initScoreBoard() {
			mScoreBoard = new ScoreBoard();
			addChild(mScoreBoard);	
			
			mScoreBoard.x = 190;
		}
		
		private function initRedPlayer() {
			mRedPlayer = new RedPlayer();
			addChild(mRedPlayer);
			
			mRedPlayer.x = 750;
			mRedPlayer.y = GameGlobals.sH - 20;
			mRedPlayer.scaleX = -1;
		}
		
		private function initBluePlayer() {
			mBluePlayer = new BluePlayer();
			addChild(mBluePlayer);
			
			mBluePlayer.x = 120;
			mBluePlayer.y = GameGlobals.sH - 20;			
		}
		
		private function initAudience() {
			mAudience = new Audience();
			addChild(mAudience);
			
			mAudience.x = 621;
			mAudience.y = 31;
		}		
		
		private function initHakem() {
			mhakemMc = new hakemMc();
			addChild(mhakemMc);
			
			mhakemMc.x = GameGlobals.sW / 2 - 25;
			mhakemMc.y = GameGlobals.sH - 15;
		}
		
		private function initBall():void
		{
			mBall = new Ball();
			addChild(mBall);
		}
		
		private function initLeftGame():void
		{
			mLeftGame = new LeftGame();
			addChild(mLeftGame);
			mLeftGame.x = (GameGlobals.sW / 2) - 25;
			mLeftGame.y = GameGlobals.sH - 15;
			mLeftGame.buttonMode = true;
			mLeftGame.mouseEnabled = true;
			mLeftGame.addEventListener(MouseEvent.CLICK, LeftGameClick);
		}
		
		
		public function PosUpdate() {
			mBall.update();
			mBluePlayer.update();
			mRedPlayer.update();
			//mhakemMc.update();
		}
		
		public function ShowMessage(MsgID:Number, Side:String) {
			mMessages = new Messages();
			addChild(mMessages);
			mMessages.showMessage(MsgID, Side);
		}
		
		private function LeftGameClick(e:MouseEvent):void
		{
			SFSGlobal.LeftGame = SFSGlobal.LeftGameMe;
			SFS.LeftGame();
			TweenLite.delayedCall(2, function () { mScoreBoard.End() } );
		}
		
		public function HakemScoreUpdate(side:String) {	
			mhakemMc.scoreUpdate(side);
			var okSide:String = (side == "left") ? "right" : "left";
			TweenLite.delayedCall(2, ShowArrows, [okSide]);
		}
		
		private function ShowArrows(side:String) {
			var okX:Number = 0;
			switch (side) 
			{
				case "left":
					okX = 250;
				break;
				
				case "right":
					okX = 700;
				break;
			}
			mOk.x = okX;
			
			mOk.visible = true;
			TweenLite.delayedCall(2, HideArrows);		
		}
		
		private function HideArrows():void
		{
			mOk.visible = false;
		}
	}

}