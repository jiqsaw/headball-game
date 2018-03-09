package
{
	import App.Session;
	import caurina.transitions.Tweener;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import Game.Ball;
	import Game.Container;
	import Game.GameGlobals;
	import Game.KeyboardEvents;
	import Game.ScoreBoard;
	import J.UTIL.JsHelper;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class GameMain extends Sprite
	{		
		var mContainer:Container;
		
		public function GameMain() 
		{
			
			SwfCom.G = this;					
			
			Events();
			
			mContainer = new Container();
			addChild(mContainer);
			
			//Oyun yüklendiðinde rakip zaten var bulunmuþsa 
			if (SFSGlobal.OpponentFinded)
				OpponentFinded(null);
		}
		
		private function Events():void
		{
			addEventListener(SwfGlobal.GAME_OPPONENTFINDED, OpponentFinded);	//Rakip Bulundu
			addEventListener(SwfGlobal.GAME_START, GameStart);	//Oyun Baþladý
			addEventListener(SwfGlobal.GAME_READYTOSET, ReadyToSet);	//Set baþladý
			addEventListener(SwfGlobal.GAME_POSUPDATE, PosUpdate);	//Top, oyuncular pozisyonlarý update
			addEventListener(SwfGlobal.GAME_SETFINISH, SetFinish);	//Set Bitti
			addEventListener(SwfGlobal.GAME_MESSAGE, GameMessages);	//Oyun içinde numaralar ile gönderilen mesaj
			addEventListener(SwfGlobal.GAME_ROVANS, GameRovans);	//Rövanþ baþladý
		}				
		
		private function OpponentFinded(e:Event):void
		{
			mContainer.StartGameBtnCtrl();			
		}
		
		private function GameStart(e:Event):void 
		{
			ExternalInterface.call("FlashFocus");
			mContainer.StartGame();
		}		
		
		private function SetFinish(e:Event):void
		{
			GameGlobals.gBall.visible  = false;
			
			switch (SFSGlobal.SetState) 
			{
				case SFSGlobal.SetStateFoul:
					ShowSetResult(new Foul());
				break;
				
				case SFSGlobal.SetStateGoal:
					ShowSetResult(new Goal());
				break;
			}
			
			switch (SFSGlobal.SetWin) 
			{
				case SFSGlobal.SetWinLeft:
					mContainer.HakemScoreUpdate("left");
				break;
				
				case SFSGlobal.SetWinRight:
					mContainer.HakemScoreUpdate("right");
				break;
			}
			
			var mScoreBoard:ScoreBoard = GameGlobals.SCORE_BOARD;
			mScoreBoard.scoreUpdate();
		}
		
		private function ReadyToSet(e:Event):void 
		{
			GameGlobals.gBall.visible = true;
		}
		
		private function ShowSetResult(ShowMc:MovieClip) {
			
			addChild(ShowMc);
			
			ShowMc.scaleX = ShowMc.scaleY = ShowMc.alpha = 0;
			Tweener.addTween(ShowMc, { scaleX:1, scaleY:1, alpha:1, time:1 , transition:"easeOutExpo" } );
			
			ShowMc.x = GameGlobals.sW / 2;
			ShowMc.y = GameGlobals.sH / 2 - 125;
			
			TweenLite.delayedCall(3, HideSetResult, [ShowMc]);
		}
		
		private function HideSetResult(HideMc:MovieClip) {
			removeChild(HideMc);
		}
		
		private function PosUpdate(e:Event):void 
		{
			mContainer.PosUpdate();
		}
		
		private function GameMessages(e:Event):void 
		{
			var MsgSide:String = "";
			if (SFSGlobal.IsSendMessageMe)
				MsgSide = (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) ? "left" : "right";
			else
				MsgSide = (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) ? "right" : "left";
			
			mContainer.ShowMessage(SFSGlobal.MessageID, MsgSide);
		}
		
		private function GameRovans(e:Event):void {
			var mScoreBoard:ScoreBoard = GameGlobals.SCORE_BOARD;
			mScoreBoard.Reset();
		}
	}
}