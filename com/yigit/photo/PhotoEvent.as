package com.yigit.photo 
{
	import flash.events.Event;
	/**
	$(CBI)* ...
	$(CBI)* 
	@author Yiğit KULA
	@siteurl www.yigitkula.com
	@contact yigitkula@gmail.com
	$(CBI)*/
	
	public class PhotoEvent extends Event
	{
		public static var PHOTO_SELECTED:String = "PHOTO_SELECTED";
		public static var PHOTO_CANCELED:String = "PHOTO_CANCELED";
		public static var PHOTO_READY:String = "PHOTO_READY";
		public function PhotoEvent(type:String) 
		{
			super(type);
		}
		
	}

}