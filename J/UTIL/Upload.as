package J.UTIL
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.display.Sprite;
	import J.UTIL.StringUtil;
	
	/** @author Feyyaz */
	
	public class Upload extends Sprite
	{
		public static const JPG_GIF_PNG = "*.jpg;*.gif;*.png;";
		public var mFileReference:FileReference;
		
		private var mFileFilter:FileFilter;		
		private var Extension:String;
		private var ExtDescription:String;		
		private var LoadedListener:Function;
		
		public var IsValid:Boolean = false;
		
		public function Upload(Extension:String, ExtDescription:String)
		{			
			this.Extension = Extension;
			this.ExtDescription = ExtDescription;
			Init();
		}
		
		private function Init() {
			mFileFilter = new FileFilter(this.ExtDescription, this.Extension);
			mFileReference = new FileReference();
			mFileReference.browse([mFileFilter]);
			mFileReference.addEventListener(Event.SELECT, FileSelected);
		}
		
		private function FileSelected(e:Event):void { 
			mFileReference.load();
			//mFileReference.addEventListener(Event.CANCEL, FileCanceled);			
			//mFileReference.addEventListener(ProgressEvent.PROGRESS, Loading);
		}			
		
		public function Load(LoadedListener:Function) {
			this.LoadedListener = LoadedListener;
			mFileReference.addEventListener(Event.COMPLETE, Complete);
		}
		
		private function Complete(e:Event):void
		{
			var ObjLoad:Loader = new Loader();
			ObjLoad.loadBytes(e.target.data);
			IsValid = ExtensionCtrl(e.target.name);
			ObjLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, this.LoadedListener);
		}
		
		public function GetBitmap(e:Event):Bitmap {
			return e.currentTarget.loader.content as Bitmap;
		}
		
		private function ExtensionCtrl(FileName:String) {
			return (Extension.indexOf("." + StringUtil.getExtension(FileName) + ";") != -1);
		}
	}
	
}