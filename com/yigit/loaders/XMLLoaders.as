package com.yigit.loaders 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class XMLLoaders extends EventDispatcher
	{
		public var content:XML;
		public var msg:String;
		public var contentPath:String;
		private var xmlLoader:URLLoader;
		
		public function loadXML(path:String)
		{
			contentPath = path;
			xmlLoader = new URLLoader();
			xmlLoader.load(new URLRequest(path));
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		private function xmlLoaded(e:Event):void 
		{
			content = new XML(e.currentTarget.data);
			dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_COMPLETE));
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			msg = "Error loading " + contentPath;
			dispatchEvent(new Loader(LoaderEvent.LOAD_ERROR));
		}
	}

}