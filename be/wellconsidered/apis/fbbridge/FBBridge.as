package be.wellconsidered.apis.fbbridge
{
	import be.wellconsidered.apis.fbbridge.data.*;
	import be.wellconsidered.apis.fbbridge.events.FBBridgeEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.setTimeout;

	public class FBBridge extends EventDispatcher
	{
		private var _fbSession:FBBridgeSession = null;
		private var _fbUser:FBBridgeUser;
		
		public function FBBridge()
		{
			addExternalInterfaces();
			
			setTimeout(onFlashReady, 250); // DELAY
		}
		
		private function onFlashReady():void
		{
			ExternalInterface.call("FBFlashBridgeFlashLoaded");
		}
		
		/**
		 * EVENT LISTENERS
		 */
		 
		private function addExternalInterfaces():void
		{
			ExternalInterface.addCallback("onLoggedIn", onLoggedIn);
			ExternalInterface.addCallback("onLoggedOut", onLoggedOut);
			
			ExternalInterface.addCallback("onStatusSet", onStatusSet);
			
			ExternalInterface.addCallback("onFriendsList", onFriendsList);
			
			ExternalInterface.addCallback("onUsersInfo", onUsersInfo);
			ExternalInterface.addCallback("onUserInfo", onUserInfo);
			
			ExternalInterface.addCallback("onAppUsers", onAppUsers);
			// Alper Haþim Kenet
			ExternalInterface.addCallback("fbPermResp", fbPermResp);
			ExternalInterface.addCallback("HasAppPerm", HasAppPerm);
			
			ExternalInterface.addCallback("onAlbumsGet", onAlbumsGet);
			ExternalInterface.addCallback("onPhotosOfAlbumGet", onPhotosOfAlbumGet);
			
		}
		
		private function onAppUsers(usersResult:Array):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.APP_USERS, false, false, usersResult));
		}
		// Alper Haþim Kenet
		private function fbPermResp(result:String):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.FB_PERRESP, false, false, result));
		}
		private function HasAppPerm(result:int):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.HAS_APP_PERM, false, false, result));
		}
		//********************
		private function onUserInfo(userInfo:Object):void
		{
			_fbUser = new FBBridgeUser(userInfo);
			
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.USER_INFO, false, false));
		}
		
		private function onUsersInfo(usersResult:Array):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.USERS_INFO, false, false, usersResult));
		}
		
		private function onFriendsList(friendResult:Array):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.FRIENDS_LIST, false,false, friendResult));
		}
		
		private function onStatusSet():void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.STATUS_SET));
		}
		
		private function onLoggedOut():void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.LOGGED_OUT));
		}
		
		private function onLoggedIn(sessionObj:Object):void
		{
			_fbSession = new FBBridgeSession(sessionObj);
				
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.LOGGED_IN));
		}
		private function onNotificationSent(usersResult:Array):void {
			//dispatchEvent(new FBBridgeEvent(FBBridgeEvent.NOTIFICATION_SENT));
		}
		/**
		 * PUBLIC
		 */
		
		/**
		 * login
		 */
		public function login():void
		{
			ExternalInterface.call("FBFlashBridgeLogIn");
		}
		
		/**
		 * logout
		 */
		public function logout():void
		{
			_fbSession = null;
			
			ExternalInterface.call("FBFlashBridgeLogOut");
		}
		
		/**
		 * get User Info. If no user id is given the user id of the logged in user will be used.
		 */
		public function getUserInfo(userId:Number = 0):void
		{
			userId = userId == 0 ? _fbSession.uid : userId;
			
			ExternalInterface.call("FBFlashBridgeUserInfo", userId, new FBBridgeUser().getFields() as Array);
		}
		
		/**
		 * setStatus
		 */
		public function setStatus(status:String):void
		{
			ExternalInterface.call("FBFlashBridgeSetStatus", status);
		}
		
		/**
		 * getFriendsList
		 */
		public function getFriendsList():void
		{
			ExternalInterface.call("FBFlashBridgeGetFriendsList");
		}
		
		/**
		 * getUsersInfo
		 * 
		 * http://wiki.developers.facebook.com/index.php/Users.getInfo
		 */
		public function getUsersInfo(usersArr:Array, profileData:Array):void
		{
			ExternalInterface.call("FBFlashBridgeGetUsersInfo", usersArr, profileData);
		}
		
		public function getUserAlbums(uid:Number)
		{
			ExternalInterface.call("FBFlashBridgeGetAlbums", uid);
		}
		
		public function getAlbumPhotos(aid:String)
		{
			ExternalInterface.call("FBFlashBridgeGetPhotos",aid)
		}
		
		private function onAlbumsGet(albumsResult:Array):void
		{
			
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.ALBUMS_GET, false,false, albumsResult));
		}
		
		//onPhotosOfAlbumGet
		
		private function onPhotosOfAlbumGet(photosResul:Array):void
		{
			dispatchEvent(new FBBridgeEvent(FBBridgeEvent.PHOTOS_ALBUM_GET, false,false, photosResul));
		}
		/**
		 * getAppUsers
		 */
		public function getAppUsers():void
		{
			ExternalInterface.call("FBFlashBridgeGetAppUsers");
		}
		
		/**
		 * promptPermission
		 */
		public function promptPermission(permission:String):void
		{
			ExternalInterface.call("FBFlashBridgePromptPermission", permission);
		}
		
		/**
		 * inviteFriends
		 */
		public function inviteFriends():void
		{
			ExternalInterface.call("FBFlashBridgeInviteFriends");
		}
		
		/**
		 * publishFeedStory
		 */
		public function publishFeedStory(templateBundleId:String, templateData:Object):void
		{
			ExternalInterface.call("FBFlashBridgePublishFeedStory", templateBundleId, templateData);
		}

		/**
		 * sendNotification
		 * Alper Haþim Kenet
		 */
		public function sendNotification (users:Array,notification:String):void {
				ExternalInterface.call("FBFlashBridgeSendNotification",users, notification);
		}
		/**
		 * Has App Permission
		 * Alper Haþim Kenet
		 */
		public function hasAppPermission (permission:String):void {
				ExternalInterface.call("FBFlashBridgeHasAppPermission",permission);
		}
		/**
		 * showShare
		 */
		public function showShare(sharedLink:String):void
		{
			ExternalInterface.call("FBFlashBridgeShowShare", sharedLink);
		}
		
		/**
		 * Getters / Setters
		 */
		public function get session():FBBridgeSession
		{
			return _fbSession;
		}
		
		public function get user():FBBridgeUser
		{
			return _fbUser;
		}
	}
}