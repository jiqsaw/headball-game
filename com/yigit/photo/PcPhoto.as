package com.yigit.photo 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import ygt.photo.PhotoEvent;
	import flash.events.EventDispatcher;

	/**
	$(CBI)* ...
	$(CBI)* 
	@author Yiğit KULA
	@siteurl www.yigitkula.com
	@contact yigitkula@gmail.com
	$(CBI)*/
	
	public class PcPhoto extends EventDispatcher
	{
		private var fR:FileReference;
		private var fF:FileFilter;
		public var content:Bitmap;
		
		public function PcPhoto(description:String, formats:String) 
		{
			trace("formats : " + formats);
			trace("description : " + description);
			init(description, formats);
		}
		
		private function init(desc:String, formats:String):void
		{
			fF = new FileFilter(desc, formats);
			fR = new FileReference();
			fR.browse([fF]);
			fR.addEventListener(Event.SELECT, fileSelected);
			fR.addEventListener(Event.CANCEL, fileCanceled);
		}
		
		private function fileSelected(e:Event):void 
		{
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_SELECTED));
			fR.load();
			fR.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void 
		{
			var loader:Loader = new Loader();
			loader.loadBytes(e.target.data);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, itemLoaded);
		}
		
		private function itemLoaded(e:Event):void 
		{
			content = e.currentTarget.loader.content;
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_READY));
		}
		
		private function fileCanceled(e:Event):void 
		{
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_CANCELED));
		}
	}
}