package HelperControls
{
	import flash.events.MouseEvent;
	
	import App.Global;
	import App.SoundControl;
	
	import J.BASE.BaseButton;
	
	/** @author Feyyaz */
	
	public class SoundButton extends BaseButton
	{
		
		public function SoundButton() 
		{
			
		}
		
		override protected function Start():void { 
			(SwfGlobal.SoundOpen) ? gotoAndStop(1) : gotoAndStop(2);
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			play();
			var mMainSound:SoundControl = SwfGlobal.gSounds;
			mMainSound.PlayStop();
		}
	}
	
}