package Services
{	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	import App.Session;
	
	/** @author Feyyaz */
	
	public class SFSGlobal 
	{
		//public static const SERVER_IP:String = "127.0.0.1";
		public static const SERVER_IP:String = "212.154.37.45";
		//public static const SERVER_IP:String = "nashishere.dyndns.info";
		public static const SERVER_PORT:int = 9338;
		public static const SERVER_ZONE:String = "KafadaSektirme";
		public static const SERVER_DEFAULT_ROOM:String = "Lobi";
		
		public static var S:SFSClient;
		public static var GAME_ROOMID:Number = - 1;
		public static var GAME_ROOM:String = "";
		
		public static var IsNoBot:Boolean = false;
		public static var IsStartGame:Boolean;
		public static var GameStarted:Boolean;
		
		public static const BotIDName = "NPC";
		public static const BotFullName = "Engin Dingin";
		public static const BotCity = "İzmir";
		
		public static var OpponentFinded:Boolean;
		public static var IsBotOpponent:Boolean;		
		
		public static var LeftPlayerID:Number;
		public static var LeftPlayerName:String;
		public static var LeftPlayerCity:String;		
		public static var LeftPlayerData:Object;
		
		public static var RightPlayerID:Number;				
		public static var RightPlayerName:String;
		public static var RightPlayerCity:String;
		public static var RightPlayerData:Object;
		
		public static var OpponentHeadFileName:String;
		public static var OpponentHead:MovieClip;
		public static var OpponentAccessoryNo:Number;
		
		public static var sfsUserID:Number;
		public static var UserSide:int;
		public static var UserSideLeft:int = 1;
		public static var UserSideRight:int = 2;
		
		public static var BallX:Number;
		public static var BallY:Number;
		
		public static var LeftPlayerX:Number;
		public static var LeftPlayerY:Number;
		
		public static var RightPlayerX:Number;
		public static var RightPlayerY:Number;
		
		public static var LeftPlayerScore:Number = 0;
		public static var RightPlayerScore:Number = 0;
		
		public static var SetState:Number = -1;
		public static var SetStateFoul:Number = 0;
		public static var SetStateGoal:Number = 1;
		
		public static var SetWin:Number = -1;
		public static var SetWinLeft:Number = 0;
		public static var SetWinRight:Number = 1;
		
		public static var AskRovans:Boolean;
		public static var AskRovansCount:Number = 0;
		public static var AskRovansMaxCount:Number = 5;
		public static var RovansAnswer:Boolean;
		public static var RovansAnswered:Boolean;
		public static var RematchCanceled:Boolean;
		
		public static var OpponentSendMatchRequest:Boolean;
		
		public static var IsRovansGame:Boolean;
		
		public static var LeftGame:Number = -1;
		public static var LeftGameMe:Number = 0;
		public static var LeftGameOpponent:Number = 1;
		
		public static var MessageID:Number;
		public static var IsSendMessageMe:Boolean;
		
		public function SFSGlobal()
		{
			
		}
		
		
		public static function Reset():void
		{
			//GAME_ROOM = "";
			LeftPlayerCity = "";
			LeftPlayerData = null;
			LeftPlayerID = 0;
			LeftPlayerName = "";
			RightPlayerCity = "";
			RightPlayerData = null
			RightPlayerID = 0;
			RightPlayerName = "";
			UserSide = UserSideLeft;
			IsBotOpponent = false;
			OpponentFinded = false;
			AskRovans = false;
			AskRovansCount = 0;
			RovansAnswer = false;
			RovansAnswered = false;
			IsRovansGame = false;
			OpponentSendMatchRequest = false;
			LeftGame = -1;
			MessageID = 0;
		}		
	}
	
}