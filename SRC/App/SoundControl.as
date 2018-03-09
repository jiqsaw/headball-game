package App
{
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;	
	import flash.net.URLRequest;
	
	/** @author Feyyaz */
	
	public class SoundControl 
	{
		private var Channel:SoundChannel;
		private var Transform:SoundTransform;
		
		private var mSound:Sound;
		
		public function SoundControl() 
		{
			SwfGlobal.gSounds = this;
			Channel = new SoundChannel();
			
			Transform = new SoundTransform((SwfGlobal.SoundOpen) ? .6 : 0);
			
			mSound = new Sound();
			mSound.addEventListener(Event.COMPLETE, SoundLoad);
			mSound.addEventListener(IOErrorEvent.IO_ERROR, SoundLoadError);
			mSound.addEventListener(ProgressEvent.PROGRESS, SoundProgress);
			mSound.load(new URLRequest(SwfCom.MainSound));
			
			
		}
		
		private function SoundLoadError(e:IOErrorEvent):void
		{
			trace("Müzik Yüklenemedi");
		}
		
		private function SoundProgress(e:ProgressEvent):void 
		{
			//trace("Müzik Yükleniyor...");
		}
		
		private function SoundLoad(e:Event):void 
		{
			Channel = mSound.play(0, int.MAX_VALUE, Transform);
		}
		
		public function Play() {
			TweenLite.to(Transform, .5, { volume: .6, onUpdate:function() { Channel.soundTransform = Transform; } } );			
			SwfGlobal.SoundOpen = true;
		}
		
		public function Stop() {			
			TweenLite.to(Transform, .2, { volume: 0, onUpdate:function() { Channel.soundTransform = Transform; } } );			
			SwfGlobal.SoundOpen = false;
		}
		
		public function PlayStop() {
			(Transform.volume > 0) ? Stop() : Play();
		}
	}
	
}