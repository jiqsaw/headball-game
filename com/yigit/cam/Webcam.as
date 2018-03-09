package com.yigit.cam 
{
	import flash.display.Sprite;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	import flash.media.Video;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Webcam
	{
		public var mainCon:Sprite;
		
		private var vW:Number;
		private var vH:Number;
		
		private var cam:Camera;
		private var vid:Video;
		private var mirrorCon:Sprite;
		
		
		public function Webcam(VideoContainer:Sprite, videoWidth:Number, videoHeight:Number) 
		{
			mainCon = VideoContainer;
			vW = videoWidth;
			vH = videoHeight;
			attachCam();
		}	
		
		private function attachCam():void
		{
			cam = Camera.getCamera();
			cam.setMode(vW, vH, 30);
			cam.setQuality(0, 100);
			//cam.addEventListener(StatusEvent.STATUS, camStatus);
			vid = new Video(vW, vH);
			vid.attachCamera(cam);
			vid.smoothing = true;
			mirrorCon = new Sprite();
			mirrorCon.addChild(vid);
			mirrorCon.scaleX = -1;
			mirrorCon.x = vW;
			mainCon.addChild(mirrorCon);
		}
	}
}