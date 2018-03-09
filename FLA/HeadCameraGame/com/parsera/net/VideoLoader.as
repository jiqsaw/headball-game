package com.parsera.net 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Parsera
	$(CBI)*/
	public class VideoLoader extends Sprite
	{
		
		public static var ON_META_DATA:String = "on_meta_data";
		public static var ON_STREAM:String = "on_stream";
		
		private var video:Video;
		private var nc:NetConnection;
		private var ns:NetStream;
		private var st:SoundTransform;
		
		public var info:Object;
		
		public function VideoLoader() 
		{
			video = new Video();
			addChild(video);
			
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			video.attachNetStream(ns);
			
			st = new SoundTransform();
			ns.soundTransform = st;
			
			ns.addEventListener(NetStatusEvent.NET_STATUS, onNsStatus);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			ns.client = this;
		}
		
		public function setSize(width:int, height:int):void {
			video.width = width;
			video.height = height;
		}
		
		private function onNsStatus(e:NetStatusEvent):void {
			//trace("VideoLoader onNsStatus " + e.info.code);
			var code:String = e.info.code;
		 
			switch( code ) {
				case "NetStream.Play.Start":
					dispatchEvent(new Event(ON_STREAM, true));
					break;
			}
		}
		
		private function onAsyncError(e:AsyncErrorEvent):void {
			//trace("onAsyncError");
		}
		
		public function onMetaData(info:Object):void {
			this.info = info;	
			dispatchEvent(new Event(ON_META_DATA, true));
		}
		
		public function play(file:String):void {
			ns.play(file);
		}
		
		public function stop():void {
			ns.close();
			nc.close();
		}
		
		public function getTime():Number {
			return ns.time;
		}
		
		public function setVolume(volume:Number):void {
			st.volume = volume;
			ns.soundTransform = st;
		}
		
	}
	
}