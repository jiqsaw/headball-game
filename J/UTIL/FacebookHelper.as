package J.UTIL 
{
	import be.wellconsidered.apis.fbbridge.data.FBBridgeUser;
	import be.wellconsidered.apis.fbbridge.events.FBBridgeEvent;
	import be.wellconsidered.apis.fbbridge.FBBridge;
	import flash.display.Sprite;
	import flash.events.Event;
	import J.UTIL.JsHelper;
	
	/** @author Feyyaz */
	
	public class FacebookHelper extends Sprite
	{
		
		public var IsLogin:Boolean;
		
		public static var fbSession:FBBridge;
		public static var fbUser:FBBridgeUser;
		
		public var arrUserFriends:Array;
		public var arrAlbums:Array;
		
		public function FacebookHelper() { 
			JsHelper.FacebookInit();
		}
		
		public function Connect(LoggedListener:Function) {
			fbSession = new FBBridge();
			fbSession.addEventListener(FBBridgeEvent.LOGGED_IN, LoggedListener);
			fbSession.addEventListener(FBBridgeEvent.LOGGED_OUT, UserLoggedOut);
			fbSession.login();
		}
		
		private function UserLoggedOut(e:FBBridgeEvent):void
		{
			IsLogin = false;
			fbSession.logout();
		}
		
		public function GetUserFriends() {
			fbSession.addEventListener(FBBridgeEvent.USER_INFO, UserLoaded);
			fbSession.getUserInfo();
		}
		
		
		private function UserLoaded(e:FBBridgeEvent):void
		{
			fbSession.removeEventListener(FBBridgeEvent.USER_INFO, UserLoaded);
			fbUser = fbSession.user;
			getLoggedUserFriends();
		}
		
		private function getLoggedUserFriends()
		{
			fbSession.addEventListener(FBBridgeEvent.FRIENDS_LIST, loggedUsersFriendsLoaded);
			fbSession.getFriendsList();
		}
		
		private function loggedUsersFriendsLoaded(e:FBBridgeEvent)
		{
			var arr:Array = e.data;
			getLoggedUsersFriendsData(arr);
		}
		
		private function getLoggedUsersFriendsData(arr:Array)
		{
			fbSession.addEventListener(FBBridgeEvent.USERS_INFO, loggedUsersFriendsDataLoaded);
			fbSession.getUsersInfo(arr, ["name"]);
		}
		
		private function loggedUsersFriendsDataLoaded(e:FBBridgeEvent)
		{
			var arr:Array = e.data;
			arr.sortOn("name");
			arr.unshift( { name:fbUser.name, uid:fbUser.uid } );
			this.arrUserFriends = arr;
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.USER_FRIENDS));
		}
	}
	
}