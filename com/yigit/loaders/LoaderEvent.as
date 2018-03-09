package com.yigit.loaders 
{
	import flash.events.Event;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class LoaderEvent extends Event
	{
		public static var LOAD_COMPLETE:String = "LOAD_COMPLETE";
		public static var LOAD_ERROR:String = "LOAD_ERROR";
		public function LoaderEvent(type:String) 
		{
			super(type);
		}
	}
}