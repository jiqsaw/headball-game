package J.BASE
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/** @author Feyyaz **/

	public class BaseMovieClip extends MovieClip
	{
		
		public function BaseMovieClip() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
			super();
		}
		
		protected function Init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			Prep();			//Objeleri Oluştur
			AddStage();		//Sahneye ekle
			Events();		//Eventlerin tanımlanması
			Load();			//Açılış Animasyonu
			Start();		//İşlemlere Başla
		}
			
		protected function Prep():void { }
		protected function AddStage():void { }	
		protected function Events():void { }
		protected function Load():void { }		
		protected function Start():void { }
		
		protected function MouseOver(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.MOUSE_OVER, Listener);
		}
		
		protected function MouseOut(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.MOUSE_OUT, Listener);
		}
		
		protected function MouseDown(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.MOUSE_DOWN, Listener);
		}

		protected function MouseMove(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.MOUSE_MOVE, Listener);
		}
		
		protected function MouseUp(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.MOUSE_UP, Listener);
		}
		
		protected function Click(Obj:MovieClip, Listener:Function) {
			Obj.addEventListener(MouseEvent.CLICK, Listener);
		}
		
		protected function LoadFile(Listener:Function, Src:String) {
			var objFile:URLLoader = new URLLoader();
			objFile.addEventListener(Event.COMPLETE, Listener);
			objFile.load(new URLRequest(Src));
		}	
		
		protected function LoadObj(Listener:Function, Src:String, ProgressListener:Function = null) {
			var objLoad:Loader = new Loader();
			objLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, Listener);
			
			if (ProgressListener != null)
				objLoad.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, ProgressListener);
				
			objLoad.load(new URLRequest(Src));			
		}
		
		protected function XY(Obj:Object, X:Number, Y:Number) {
			Obj.x = X;
			Obj.y = Y;
		}
		
	}	
}