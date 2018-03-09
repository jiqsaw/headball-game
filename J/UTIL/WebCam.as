package J.UTIL 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;	
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Sound;
	import flash.media.Video;
	import flash.text.TextField;
	import flash.utils.Timer;

	/** @author Feyyaz */
	
	public class WebCam
	{
	
		private var W:Number;
		private var H:Number;
		
		private var Cam:Camera;
		private var Vid:Video;	
		
		private var mWebCamArea:Sprite;
		
		private var mTimer:Timer;		
		private var Counter:Number;
		private var CountDisplay:TextField;
		private var CountDisplayDesc:TextField;
		
		public function WebCam(WebCamArea:Sprite, W:Number = 320, H:Number = 240)
		{
			this.W = W;
			this.H = H;
			this.mWebCamArea = WebCamArea;
			Cam = Camera.getCamera();
			Cam.setMode(W, H, 30);
			Cam.setQuality(0, 100);
			if (Cam != null) {
				Vid = new Video(W, H);			
				Vid.attachCamera(Cam);
				Vid.smoothing = true;
				this.mWebCamArea.addChild(Vid);
				Vid.scaleX = -1;
				Vid.x = W;
			}
		}		
		
		public function CreateCounter(Counter:Number = 5, CountDisplay:TextField = null, CountDisplayDesc = null) {
			
			this.Counter = Counter;					
			
			this.CountDisplay = CountDisplay;
			this.CountDisplayDesc = CountDisplayDesc;
			
			this.CountDisplay.visible = false;
			if (CountDisplayDesc != null) this.CountDisplayDesc.visible = false;
			
			mTimer = new Timer(1000, Counter + 1);
			mTimer.addEventListener(TimerEvent.TIMER, CountDown);			
		}
		
		private function CountDown(e:TimerEvent) {
			CountDisplay.text = Counter.toString();
			Counter--;
		}
		
		public function StartCounter(GetPhotoListener:Function) {
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, GetPhotoListener);
			mTimer.start();
			this.CountDisplay.visible = true;
			if (CountDisplayDesc != null) this.CountDisplayDesc.visible = true;
		}
		
		public function TakePhoto():Bitmap {
			CloseCamera();
			var bmpPhoto:BitmapData = new BitmapData(mWebCamArea.width, mWebCamArea.height);
			bmpPhoto.draw(this.mWebCamArea);
			return new Bitmap(bmpPhoto);
		}
		
		public static function HasCamera():Boolean {
			return Camera.names.length > 0;
		}
		
		public function CloseCamera() {
			Vid.attachCamera(null);
			Vid.clear()
		}
	}
	
}