package be.wellconsidered.apis.fbbridge.events
{
	import flash.events.Event;

	public class FBBridgeEvent extends Event
	{
		public static var LOGGED_IN:String = "LOGGED_IN"; 
		public static var LOGGED_OUT:String = "LOGGED_OUT"; 
		public static var STATUS_SET:String = "STATUS_SET"; 
		public static var FRIENDS_LIST:String = "FRIENDS_LIST";
		public static var USERS_INFO:String = "USERS_INFO";
		public static var USER_INFO:String = "USER_INFO";
		public static var APP_USERS:String = "APP_USERS";
		public static var ALBUMS_GET:String = "ALBUMS_GET";
		public static var PHOTOS_ALBUM_GET:String = "PHOTOS_ALBUM_GET";
		
		public static var FB_PERRESP:String = "FB_PERRESP";
		public static var HAS_APP_PERM:String = "HAS_APP_PERM";
		//public static var NOTIFICATION_SENT:String = "NOTIFICATION_SENT";
		
		
		public static var USER_FRIENDS:String = "USER_FRIENDS";
		
		private var _data:* = null;
		
		public function FBBridgeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:*=null)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}