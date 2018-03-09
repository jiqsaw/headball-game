package Screens
{
	import App.Bus;
	import App.Global;
	import App.Lib;
	import App.LibButton;
	import App.Session;
	import App.Wording;
	import com.dynamicflash.util.Base64;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import HelperControls.CallButton;
	import HelperControls.RovansButton;
	import HelperControls.Text;
	import J.BASE.BaseButton;
	import J.UTIL.Colors;
	import J.UTIL.Filter;
	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;
	import Services.PhpData;
	import Services.SFS;
	import Services.SFSGlobal;
	
	import J.BASE.BaseMovieClip;
	
	/** @author Feyyaz */
	
	public class MatchResult extends BaseMovieClip
	{
		private var MacSonucuTitle:Text;
		private var Puan:Text;
		private var Rovans:Text;
		private var RovansDesc:Text;
		private var RovansTimer:Text;
		
		private var mHr1:Sprite;
		private var mHr2:Sprite;
		
		private var IconWin:Lib;
		private var IconLose:Lib;
		private var IconDrawHome:Lib;
		private var IconDrawAway:Lib;
		
		private var Close:CallButton;
		
		private var FacebookShare:LibButton;
		
		private var RovansButtonYES:RovansButton = null;
		private var RovansButtonNO:RovansButton = null;
		
		var HomeIconX:Number = 74;
		var AwayIconX:Number = 546;
		
		var HomeFullName:Text;
		var AwayFullName:Text;
		
		var elapsedTime:Number = Global.RovansWaitTime;
		
		public function MatchResult() {
			
			MacSonucuTitle = new Text(Wording.matchresultTitle, Text.Title);
			
			LeftGameCtrl();		
			
			this.Puan = new Text(SFSGlobal.LeftPlayerScore + "-" + SFSGlobal.RightPlayerScore, Text.Custom, Colors.White, 80, 210, TextFormatAlign.CENTER);
			this.HomeFullName = new Text(SFSGlobal.LeftPlayerName, Text.FormLabel);
			this.AwayFullName = new Text(SFSGlobal.RightPlayerName, Text.FormLabel);
		}
		
		override protected function Prep():void 
		{								
			mHr1 = GraphicHelper.draw(54, 3);
			mHr2 = GraphicHelper.draw(54, 3);
			
			IconWin = new Lib(Lib.IconWin);
			IconLose = new Lib(Lib.IconLose);
			IconDrawHome = new Lib(Lib.IconDraw);
			IconDrawAway = new Lib(Lib.IconDraw);
			
			Close = new CallButton(CallButton.Close, false);
			
			FacebookShare = new LibButton(Lib.FacebookShare);
			
			Rovans = new Text(Wording.matchresultRovans, Text.BlueLabel);
			RovansDesc = new Text(Wording.matchresultRovansDesc);			
			RovansTimer = new Text("(" + elapsedTime.toString() + ")");			
			RovansButtonYES = new RovansButton(RovansButton.tYes, Wording.YES);
			RovansButtonNO = new RovansButton(RovansButton.tNo, Wording.NO);
			
			this.XY(RovansButtonYES, 215, 228);
			this.XY(RovansButtonNO, 330, 228);
			
			RovansBus();			
		}
		
		override protected function AddStage():void 
		{
			addChild(MacSonucuTitle);
			addChild(Puan);
			addChild(HomeFullName);
			addChild(AwayFullName);
			addChild(mHr1);
			addChild(mHr2);
			addChild(IconWin);
			addChild(IconLose);
			addChild(IconDrawHome);
			addChild(IconDrawAway);
			addChild(Close);
			addChild(FacebookShare);
			
			addChild(Rovans);
			addChild(RovansDesc);
			addChild(RovansButtonYES);
			addChild(RovansButtonNO);
			addChild(RovansTimer);
		}
		
		override protected function Events():void 
		{
			this.Click(Close, CloseClick);
			this.Click(FacebookShare, FacebookShareClick);
			
			this.Click(RovansButtonYES, RovansButtonYESClick);
			this.Click(RovansButtonNO, RovansButtonNOClick);
		}		
		
		private function FacebookShareClick(e:MouseEvent):void
		{
			var ShareData:String = PhpData.GenScoreShareData(HomeFullName.text, AwayFullName.text, SFSGlobal.LeftPlayerScore, SFSGlobal.RightPlayerScore);
			var ShareURL:String = PhpData.PhpFacebookShareURL + Base64.encode(ShareData);
			JsHelper.ShareDynamic(ShareURL, "facebook");
		}
		
		var timer:Timer;
		override protected function Load():void 
		{
			this.XY(MacSonucuTitle, 220, 60);
			this.XY(Puan, 257, 112);
			this.XY(HomeFullName, 40, 105);
			this.XY(AwayFullName, 507, HomeFullName.y);
			this.XY(Rovans, 245, 200);
			this.XY(RovansDesc, 200, 270);
			this.XY(mHr1, 208, 207);
			this.XY(mHr2, 376, 207);
			this.XY(IconWin, 0, 180);
			this.XY(IconLose, 0, 180);
			this.XY(IconDrawHome, HomeIconX, 170);
			this.XY(IconDrawAway, AwayIconX, 170);
			this.XY(Close, 500, 321);
			this.XY(FacebookShare, 250, 310);
			
			this.XY(RovansTimer, 160, 270),
			
			IconWin.filters = new Array(Filter.Stroke());
			IconLose.filters = new Array(Filter.Stroke());
			IconDrawHome.filters = new Array(Filter.Stroke());
			IconDrawAway.filters = new Array(Filter.Stroke());
			
			IconDrawHome.visible = IconDrawAway.visible = false;			
			
			trace("SFSGlobal.RightPlayerScore : " + SFSGlobal.RightPlayerScore);
			trace("SFSGlobal.LeftPlayerScore : " + SFSGlobal.LeftPlayerScore);
				
			if (SFSGlobal.LeftPlayerScore > SFSGlobal.RightPlayerScore)
			{
				IconWin.x = HomeIconX;
				IconLose.x = AwayIconX;
			}
			else if (SFSGlobal.LeftPlayerScore < SFSGlobal.RightPlayerScore)
			{
				IconWin.x = AwayIconX;
				IconLose.x = HomeIconX;			
			}
			else {
				IconWin.visible = IconLose.visible = false;
				IconDrawHome.visible = IconDrawAway.visible = true;				
			}					
		}
		
		
		private function onCountdowncomplete(e:TimerEvent):void
		{
			RovansTimer.visible = false;
			RovansAnswered(false);
		}
		
		private function countDown(e:TimerEvent):void
		{
			elapsedTime--;
			RovansTimer.text = "(" + elapsedTime.toString() + ")";
		}		
		
		private function RovansBus() {
			if (!SFSGlobal.AskRovans) {								
				mHr1.visible = mHr2.visible = false;
				Rovans.visible = false;
				RovansDesc.visible = false;
				RovansTimer.visible = false;
				RovansButtonYES.visible = false;
				RovansButtonNO.visible = false;
			}
			else {
				timer = new Timer(1000, Global.RovansWaitTime);
				timer.addEventListener(TimerEvent.TIMER, countDown);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onCountdowncomplete);
				timer.start();			
			}
		}
		
		private function CloseClick(e:MouseEvent):void
		{
			//Eğer daha önce evet e basılmış, rakipten gelen cevap hayır ise sonrasında close a basmışsa
			//ya da zaten rövanş sorulmuyorsa ya da uzun süre birşeye basmayıp oda  düşmüşse
			if ((((SFSGlobal.RovansAnswer) || (!SFSGlobal.AskRovans)) || (SFSGlobal.RematchCanceled)) || (SFSGlobal.GAME_ROOMID < 1))
				SwfCom.ExitGame();
				
			//İlk önce close a basmışsa
			else
				RovansAnswered(false);
			
		}
		
		private function RovansButtonYESClick(e:MouseEvent):void
		{
			if (Session.sIsLogin)
				JsHelper.GATracker("RovansIstiyorum/" + Session.sUserID.toString() + "/" + Session.sName + "_" + Session.sSurname);		
			else
				JsHelper.GATracker("RovansIstemiyorum/Guest");
			
			RovansDesc.text = Wording.matchresultRovansWaitAnswer;
			
			RovansAnswered(true);
		}
		
		private function RovansButtonNOClick(e:MouseEvent):void
		{					
			if (Session.sIsLogin)
				JsHelper.GATracker("RovansIstemiyorum/" + Session.sUserID.toString() + "/" + Session.sName + "_" + Session.sSurname);				
			else
				JsHelper.GATracker("RovansIstemiyorum/Guest");
				
			RovansAnswered(false);
		}
		
		private function HideRovansButtons() {
			RovansButtonYES.visible = RovansButtonNO.visible = RovansTimer.visible = false;
			timer.stop();
		}
		
		private function RovansAnswered(IsAccept:Boolean) {
			HideRovansButtons();
			SFSGlobal.RovansAnswered = true;
			SFS.RovansAnswer(IsAccept);
		}
		
		public function SetRovansStatus(RovansStatusMessage:String) {
			RovansDesc.textColor = Colors.Red;
			RovansDesc.filters = new Array(Filter.Stroke(Colors.White));
			RovansDesc.text = RovansStatusMessage;
			HideRovansButtons();
		}
		
		private function LeftGameCtrl() {
			switch (SFSGlobal.LeftGame) 
			{
				case SFSGlobal.LeftGameMe:
					MacSonucuTitle.text = Wording.matchresultEscapeSelf;
				break;
				
				case SFSGlobal.LeftGameOpponent:
					MacSonucuTitle.text = Wording.matchresultEscapeOponent;
				break;
			}		
		}
	}	
	
}