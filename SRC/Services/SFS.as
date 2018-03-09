package Services
{
	import App.DataManagement;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import Game.Accessories;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import J.UTIL.NumberUtil;
	import J.UTIL.Tools;
	
	import App.Session;	
	import Services.SFSClient;
	
	import J.UTIL.JsHelper;
	
	/** @author Feyyaz */
	
	public class SFS
	{			
		public function SFS() 
		{
			
		}			
		
		public static function Connect() {
			SFSGlobal.S = new SFSClient();
		}
		
		//Eğer login tamamlanmadan oyuna başlaya tıklanmışsa rakip aramayacak joinroomhandle da buraya düşecek rakip arama başlayacak
		public static function FindOpponent() {		
			if (Session.sIsSFSLogin) {
				//Geliştirme aşamasında boşa düşmeyip mutlaka multiplayer a bağlanılmak isteniyorsa
				if (SFSGlobal.IsNoBot)
					SFSGlobal.S.Send(SFSCommands.noBot, false);
					
				SFSGlobal.S.Send(SFSCommands.findOpponent, false);
			}
		}
		
		public static function OpponentFinded() {		
			
			if (SFSGlobal.IsBotOpponent) {
				
				SFSGlobal.sfsUserID = SFSGlobal.LeftPlayerData.sfsUserID;
				
				SFSGlobal.LeftPlayerName = Session.sFullName();
				SFSGlobal.LeftPlayerCity = Session.sCity;				
				
				SFSGlobal.UserSide = SFSGlobal.UserSideLeft;
				
				SwfCom.SearchOpponentStartBtn();
			}
			else {
				
				SFSGlobal.LeftPlayerName = SFSGlobal.LeftPlayerData.ufullname;
				SFSGlobal.LeftPlayerCity = SFSGlobal.LeftPlayerData.city;				
				
				SFSGlobal.RightPlayerName = SFSGlobal.RightPlayerData.ufullname;
				SFSGlobal.RightPlayerCity = SFSGlobal.RightPlayerData.city;				
				
				SFSGlobal.UserSide = (Session.sUserID == SFSGlobal.LeftPlayerID) ? SFSGlobal.UserSideLeft : SFSGlobal.UserSideRight;				
				
				if (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) {
					SFSGlobal.OpponentHeadFileName = SFSGlobal.RightPlayerData.uavatar;
					SFSGlobal.OpponentAccessoryNo = SFSGlobal.RightPlayerData.uaccessory
					
					SFSGlobal.sfsUserID = SFSGlobal.LeftPlayerData.sfsUserID;
				}
				
				else if (SFSGlobal.UserSide == SFSGlobal.UserSideRight) {
					SFSGlobal.OpponentHeadFileName = SFSGlobal.LeftPlayerData.uavatar;
					SFSGlobal.OpponentAccessoryNo = SFSGlobal.LeftPlayerData.uaccessory;
					
					SFSGlobal.sfsUserID = SFSGlobal.RightPlayerData.sfsUserID;
				}
				
				if ((SFSGlobal.OpponentHeadFileName != SwfGlobal.DefaultHead1) && (SFSGlobal.OpponentHeadFileName != SwfGlobal.DefaultHead2)) {
					
					var objLoad:Loader = new Loader();
					objLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, OpponentAvatarLoaded);
					
					var OpponentHeadURL:String = SwfGlobal.AvatarPath + "/" + SFSGlobal.OpponentHeadFileName;
					
					objLoad.load(new URLRequest(OpponentHeadURL));
				} 
				else
					SwfCom.SearchOpponentStartBtn();
				
			}
		}
		
		static private function OpponentAvatarLoaded(e:Event):void 
		{		
			var bmpAvatarHead:Bitmap = e.currentTarget.content;
			bmpAvatarHead.smoothing = true;			
			
			var mOpponentHead:MovieClip = new MovieClip();
			mOpponentHead.addChild(bmpAvatarHead);					
			
			//Aksesuar ile birlikte global e al***
			var mAccessory:MovieClip = new Accessories(SFSGlobal.OpponentAccessoryNo);
			mAccessory.x = 44;
			mOpponentHead.addChild(mAccessory);
			
			mOpponentHead.scaleX = mOpponentHead.scaleY = .5;
			SFSGlobal.OpponentHead = mOpponentHead;			
			
			SwfCom.SearchOpponentStartBtn();
		}
		
		
		
		public static function ReadyToPlay() {
			SFSGlobal.S.Send(SFSCommands.readyToPlay);
		}
		
		public static function GameStart() {
			SwfCom.GameStart();
		}
		
		public static function ScoreUpdate() {			
			SwfCom.SetFinish();
		}
		
		public static function ReadyToSet() {
			SwfCom.ReadyToSet();
		}
		
		public static function PosUpdate() {
			SwfCom.PosUpdate();
		}
		
		public static function KeyCommands(keyCommand:String, IsNumPad:Boolean) {			
			if (!IsNumPad)
				SFSGlobal.S.Send(keyCommand, true, SmartFoxClient.XTMSG_TYPE_STR);
			else
				SFSGlobal.S.SendMessage(Number(keyCommand));
		}
		
		public static function GameFinished() {
			SwfCom.GameFinished();
		}
		
		public static function RovansAnswer(IsAccept:Boolean) {			
			SFSGlobal.RovansAnswer = IsAccept;
			
			(IsAccept) ? SFSGlobal.S.Send(SFSCommands.rematchAccepted) : SFSGlobal.S.Send(SFSCommands.rematchDeclined);			
		}
		
		public static function LeftGame() {
			LeftGameScore();
			SFSGlobal.AskRovans = false;
			
			if (SFSGlobal.LeftGame == SFSGlobal.LeftGameMe)
			{
				SFSGlobal.S.ExitGame();
				GameFinished();
			}
		}
		
		public static function LeftGameScore() {			
			if (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) {
				SFSGlobal.LeftPlayerScore = (SFSGlobal.LeftGame == SFSGlobal.LeftGameMe) ? 0 : 3;
				SFSGlobal.RightPlayerScore = (SFSGlobal.LeftGame == SFSGlobal.LeftGameMe) ? 3 : 0;
			}
			else {
				SFSGlobal.LeftPlayerScore = (SFSGlobal.LeftGame == SFSGlobal.LeftGameMe) ? 3 : 0;
				SFSGlobal.RightPlayerScore = (SFSGlobal.LeftGame == SFSGlobal.LeftGameMe) ? 0 : 3;
			}
		}
	}
}