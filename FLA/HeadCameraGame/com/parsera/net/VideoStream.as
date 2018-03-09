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
	public class VideoStream extends Sprite
	{
		
		public static var ON_META_DATA:String = "on_meta_data";
		
		private var video:Video;
		private var nc:NetConnection;
		private var ns:NetStream;
		private var st:SoundTransform;
		
		private var connectionURL:String;
		
		public var info:Object;
		
		public function VideoStream(connectionURL:String) 
		{
			
			this.connectionURL = connectionURL;
			trace("Conn: "+ connectionURL)
			video = new Video();
			addChild(video);
			
			nc = new NetConnection();
			nc.connect(connectionURL);
			
			nc.addEventListener(NetStatusEvent.NET_STATUS, onNsStatus);

			
		}
		
		public function setSize(width:int, height:int):void {
			video.width = width;
			video.height = height;
		}
		
		private function onNsStatus(e:NetStatusEvent):void {
			//trace("onNsStatus");
			var code:String = e.info.code;
			trace("Stream onNetStatus "+code);
		 
			switch( code ) {
				case "NetConnection.Connect.Success":
					doStreams();
					break;
			}
	
			
		}
		
		private function doStreams():void
		{
			
			ns = new NetStream(nc);
			ns.client = this;
			video.attachNetStream(ns);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
			
			st = new SoundTransform();
			ns.soundTransform = st;
			
		};
		
		private function onAsyncError(e:AsyncErrorEvent):void {
			//trace("onAsyncError");
		}
		
		public function onMetaData(info:Object):void {
			this.info = info;	
			dispatchEvent(new Event(ON_META_DATA, true));
		}
		
		public function play(file:String):void {
			trace("Video Stream play: " + connectionURL + " - " + file);
			ns.play(file);
		}
		
		public function stop():void {
			if(ns != null) {
				try {
					ns.close();
				} catch (err:Error) {
					
				}
			}
		}
		
		public function getTime():Number {
			return (ns != null) ? ns.time : 60;
		}
		
		public function setVolume(volume:Number):void {
			st.volume = volume;
			ns.soundTransform = st;
		}
		
	}
	
}