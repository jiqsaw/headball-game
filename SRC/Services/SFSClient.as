package Services
{
	import App.DataManagement;
	import App.Session;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import it.gotoandplay.smartfoxserver.data.Room;
	import it.gotoandplay.smartfoxserver.data.User;
	import J.UTIL.JsHelper;
	import J.UTIL.NumberUtil;
	import J.UTIL.Tools;
		
	/** @author Feyyaz */
	
	public class SFSClient extends SmartFoxClient
	{
		public static var OPPONENT_FINDED;
		
		public function SFSClient()
		{
			JsHelper.Console("SFS | Connecting... " + SFSGlobal.SERVER_IP);
			
			connect(SFSGlobal.SERVER_IP, SFSGlobal.SERVER_PORT);
			
			smartConnect = true;
			httpPollSpeed = 50;			
			
			EventListeners();					
		}
		
		private function EventListeners():void
		{
			addEventListener(SFSEvent.onConnection, onConnectionHandler);
			addEventListener(SFSEvent.onLogin, onLoginHandler);
			addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdateHandler);
			addEventListener(SFSEvent.onRoomVariablesUpdate, onRoomVariablesUpdateHandler);
			addEventListener(SFSEvent.onUserCountChange, onUserCountChangeHandler);
			addEventListener(SFSEvent.onJoinRoom, onJoinRoomHandler);
			addEventListener(SFSEvent.onJoinRoomError, onJoinRoomErrorHandler);
			addEventListener(SFSEvent.onRoomAdded, onRoomAddedHandler);
			addEventListener(SFSEvent.onRoomDeleted, onRoomDeletedHandler);
			addEventListener(SFSEvent.onCreateRoomError, onCreateRoomErrorHandler);
			addEventListener(SFSEvent.onPublicMessage, onPublicMessageHandler);
			addEventListener(SFSEvent.onPrivateMessage, onPrivateMessageHandler);
			addEventListener(SFSEvent.onUserEnterRoom, onUserEnterRoomHandler);
			addEventListener(SFSEvent.onUserLeaveRoom, onUserLeaveRoomHandler);
			addEventListener(SFSEvent.onConnectionLost, onConnectionLostHandler);
			addEventListener(SFSEvent.onExtensionResponse, onExtensionResponseHandler);				
		}
		
		private function onLoginHandler(event:SFSEvent):void { }
		private function onRoomVariablesUpdateHandler(event:SFSEvent):void { }		
		private function onUserCountChangeHandler(event:SFSEvent):void { }		
		private function onJoinRoomErrorHandler(event:SFSEvent):void { trace("err") }		
		private function onRoomAddedHandler(event:SFSEvent):void { }		
		private function onCreateRoomErrorHandler(event:SFSEvent):void { }
		private function onPublicMessageHandler(event:SFSEvent):void { }
		
		private function onPrivateMessageHandler(event:SFSEvent):void { }		
		private function onUserEnterRoomHandler(event:SFSEvent):void { }		
		private function onUserLeaveRoomHandler(event:SFSEvent):void { }		
		
		
		
		//HANDLERS
		private function onConnectionHandler(event:SFSEvent):void {
			
			var isOk:Boolean = event.params.success;
			
			JsHelper.Console("SFS | Connected: " + isOk.toString());
			
			if (isOk) {
				keepAlive();
				
				JsHelper.Console("SFS | is Login...");
				login(SFSGlobal.SERVER_ZONE, Session.sEmail, Session.sPass);
			}
		}
		
		private function onConnectionLostHandler(event:SFSEvent):void { 			
			JsHelper.Console("ConnectionLost");
			Session.sIsSFSLogin = false;
		}				
			
		private function keepAlive() {
			var timer:Timer = new Timer(10000);
			timer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent):void 
				{
					if (isConnected)
						sendXtMessage("Main", "keepAlive", "", SmartFoxClient.XTMSG_TYPE_STR);
				});
			timer.start();		
		}
		
		private function onRoomListUpdateHandler(event:SFSEvent):void {
			
			JsHelper.Console("SFS | Room List Update");
			
			if (activeRoomId == -1) 
				autoJoin();					
		}					
		
		private function onJoinRoomHandler(event:SFSEvent):void { 
			
			JsHelper.Console("SFS | Joined Room");
			
			if (SFSGlobal.IsStartGame)
				SFS.FindOpponent();
		}		
		
		private function onRoomDeletedHandler(event:SFSEvent):void {
			//JsHelper.Console("SFS | Room Deleted");
			var room:Room = event.params.room as Room;
			if (room.getId() == SFSGlobal.GAME_ROOMID) {
				SFSGlobal.GAME_ROOM = "";
				SFSGlobal.GAME_ROOMID = -1;
			}
		}
		
		private function onExtensionResponseHandler(event:SFSEvent):void {
			
			if (event.params.dataObj[0] == "P") 
			{
				Positions(event);
				
				return;
			}
			
			var command:String = String(event.params.dataObj._cmd);
			
			if (command != "undefined")
			{				
				JsHelper.Console("SFS | [command]   " + command);				
				
				switch (command) 
				{
					case SFSCommands.loginSuccess:
						Logged(event, true);
					break;
					
					case SFSCommands.loginError:
						Logged(event, false);
					break;
					
					case SFSCommands.opponentFinded:
						opponentFinded(event);
					break;
					
					case SFSCommands.gameStarted:
						gameStarted();
					break;
					
					case SFSCommands.scoreUpdate:
						scoreUpdate(event);
					break;
					
					case SFSCommands.gameFinished:
						gameFinished();
					break;
					
					case SFSCommands.beginToMatch:
						beginToMatch();						
					break;
					
					case SFSCommands.rematchRequest:
						rematchRequest();
					break;
					
					case SFSCommands.rematchCancel:
						rematchCancel();
					break;
					
					case SFSCommands.opponentLost:
						opponentLost();
					break;
					
					case SFSCommands.message:
						message(event);
					break;					
				}
			}
		}		
		
		
		
		//REQUESTS
		
		public function Send(Cmd:String, IsGame:Boolean = true, Type:String = SmartFoxClient.XTMSG_TYPE_XML) {			
			if (Cmd.length > 3)
				JsHelper.Console("SFS | [sendXtMessage]   " + Cmd);
			
			SwfGlobal.ErrorCommand = Cmd;
				
			if (!IsGame)
				sendXtMessage("Main", Cmd, new Object(), Type);
			else
				sendXtMessage("Game", Cmd, new Object(), Type, SFSGlobal.GAME_ROOMID);
		}		
		
		public function SendReadySet() {
			Send(SFSCommands.readyToSet);
			SFS.ReadyToSet();
		}
		
		
		public function SendMessage(MsgID:Number) {			
			JsHelper.Console("SFS | [sendXtMessage] MessageID:  " + SFSGlobal.MessageID.toString());
			sendXtMessage("Game", "message", { message: String(MsgID)}, SmartFoxClient.XTMSG_TYPE_XML, SFSGlobal.GAME_ROOMID);	
		}
		
		
		public function SendUserIP(IP:String) {
			JsHelper.Console("SFS | [sendXtMessage] setUserIP:  " + IP);
			sendXtMessage("Main", SFSCommands.setUserIP, { ipAddress: IP }, SmartFoxClient.XTMSG_TYPE_XML);
		}
		
		public function ExitGame() {
			JsHelper.Console("SFS | [sendXtMessage] exitGame");
			SwfGlobal.ErrorCommand = SFSCommands.exitGame;
			sendXtMessage("Game", SFSCommands.exitGame, { room: SFSGlobal.GAME_ROOMID }, SmartFoxClient.XTMSG_TYPE_XML, SFSGlobal.GAME_ROOMID);
		}
		
		
		
		//RESPONSES
		public function Logged(event:SFSEvent, IsLogin:Boolean):void
		{
			Session.sIsSFSLogin = IsLogin;
			if (IsLogin) {
				myUserId = Number(event.params.dataObj.id);
				myUserName = String(event.params.dataObj.name);
				
				SendUserIP(Session.IP);
			}
		}
		
		public function gameStarted() {
			
			SFSGlobal.GameStarted = true;
			
			//Eğer ilk oyun ise ? Rovanş ise
			(!SFSGlobal.IsRovansGame) ? SFS.GameStart() : SwfCom.RovansGame();
			
			if (SFSGlobal.IsRovansGame) {
				SFSGlobal.LeftPlayerScore = 0;
				SFSGlobal.RightPlayerScore = 0;
			}
			
			TweenLite.delayedCall(2, SendReadySet);
		}
		
		public function Positions(event:SFSEvent):void
		{			
			//default x:495 y:600
			SFSGlobal.BallX = Number(event.params.dataObj[2]) + 475;				
			SFSGlobal.BallY = ( -1 * Number(event.params.dataObj[3])) + SwfGlobal.SEH + 10;
			
			SFSGlobal.LeftPlayerX = Number(event.params.dataObj[4]) + 475;				
			SFSGlobal.LeftPlayerY = ( -1 * Number(event.params.dataObj[5])) + SwfGlobal.SEH + 10;
			
			SFSGlobal.RightPlayerX = Number(event.params.dataObj[6]) + 475;
			SFSGlobal.RightPlayerY = ( -1 * Number(event.params.dataObj[7])) + SwfGlobal.SEH + 10;
			
			SFS.PosUpdate();
		}
		
		public function opponentFinded(event:SFSEvent):void
		{				
			SFSGlobal.GAME_ROOMID = Number(event.params.dataObj.gameRoomID);			
			SFSGlobal.GAME_ROOM = String(event.params.dataObj.gameRoom);
			
			JsHelper.Console("GAME_ROOM : " + SFSGlobal.GAME_ROOM);
			JsHelper.Console("GAME_ROOMID : " + SFSGlobal.GAME_ROOMID.toString());
			
			SFSGlobal.LeftPlayerData = JSON.decode(String(event.params.dataObj.leftPlayerData));
			SFSGlobal.RightPlayerData = JSON.decode(String(event.params.dataObj.rightPlayerData));
			
			//Rakip Bot mu ?
			SFSGlobal.IsBotOpponent = (getActiveRoom().getUser(Number(String(event.params.dataObj.rightPlayer))).getName() == SFSGlobal.BotIDName);
			
			(SFSGlobal.IsBotOpponent) ? JsHelper.Console("IBT") : JsHelper.Console("IBF");
			
			SFSGlobal.LeftPlayerID = Number(SFSGlobal.LeftPlayerData.id);								
			
			if (!SFSGlobal.IsBotOpponent)
				SFSGlobal.RightPlayerID = Number(SFSGlobal.RightPlayerData.id);
			else
			{
				SFSGlobal.RightPlayerName = SFSGlobal.BotFullName;
				SFSGlobal.RightPlayerCity = SFSGlobal.BotCity;				
			}
			
			var rnd:Number = NumberUtil.Random(1, 3);
			if ((SFSGlobal.IsBotOpponent) && (rnd > 1))
			{
				var php:PhpData = new PhpData(BotNameLoaded);
				php.GetRandomBotName();
			}
			else
			{
				SFSGlobal.OpponentFinded = true;
				SFS.OpponentFinded();
			}
		}
		
		private function BotNameLoaded(e:Event) {
			var objBotName:Object = DataManagement.ResultData();
			
			try 
			{
				SFSGlobal.RightPlayerName = objBotName[Naming.RANDOMBOTNAME];				
				SFSGlobal.RightPlayerCity = objBotName[Naming.RANDOMBOTCITY];
			}
			catch (e:Error)
			{
				trace("Error: " + e);
			}
			
			SFSGlobal.OpponentFinded = true;			
			SFS.OpponentFinded();
		}		
		
		public function scoreUpdate(event:SFSEvent) {
			
			SFSGlobal.SetState = (String(event.params.dataObj.isFoul) == "true") ? SFSGlobal.SetStateFoul : SFSGlobal.SetStateGoal;
			
			var SFSLeftScore:Number = Number(event.params.dataObj.leftPlayer);
			var SFSRightScore:Number = Number(event.params.dataObj.rightPlayer);
			
			if (SFSGlobal.LeftPlayerScore != SFSLeftScore)
				SFSGlobal.SetWin = SFSGlobal.SetWinLeft;
			else
				SFSGlobal.SetWin = SFSGlobal.SetWinRight;					
			
			SFSGlobal.LeftPlayerScore = SFSLeftScore;
			SFSGlobal.RightPlayerScore = SFSRightScore;
			
			SFS.ScoreUpdate();
			
			TweenLite.delayedCall(2.5, SendReadySet);
		}
		
		public function gameFinished() {
			SFSGlobal.AskRovansCount++;
			
			SFSGlobal.AskRovans = (SFSGlobal.AskRovansCount < SFSGlobal.AskRovansMaxCount);
			
			//Oyundan çık a basılmışsa
			if (SFSGlobal.LeftGame > -1)
				SFSGlobal.AskRovans = false;
			
			SFS.GameFinished();
		}
		
		private function beginToMatch():void
		{		
			SFSGlobal.IsRovansGame = true;
			SFS.ReadyToPlay();
		}
		
		//Rakip daha önce rövanş isteği göndermişse
		private function rematchRequest():void
		{
			JsHelper.Console("SFSGlobal.OpponentSendMatchRequest : " + SFSGlobal.OpponentSendMatchRequest.toString());
			SFSGlobal.OpponentSendMatchRequest = true;	
		}
		
		//Taraflardan biri rövanş a "hayır" a basmışsa
		private function rematchCancel():void
		{
			SFSGlobal.RematchCanceled = true;
			if ((SFSGlobal.RovansAnswer) || (!SFSGlobal.RovansAnswered))  //rakip hayır a basmış (ben evet e bastıktan önce veya sonra)
				SwfCom.RovansOpponentDecline();
				
			else			//Eğer rövanş ı kendisi kabul etmemişse
				SwfCom.ExitGame();
		}
		
		private function opponentLost():void		//Rakip kaçmışsa
		{
			SFSGlobal.LeftGame = SFSGlobal.LeftGameOpponent;
			SFS.LeftGame();
		}
		
		public function message(event:SFSEvent) {
			SFSGlobal.MessageID = Number(event.params.dataObj.message) - 1;			
			var SendMessageBySfsID:Number = Number(event.params.dataObj.sender);
			
			SFSGlobal.IsSendMessageMe = (SFSGlobal.sfsUserID == SendMessageBySfsID);									
			SwfCom.ShowMessage();
		}
	}
	
}