package HelperControls
{
	import App.Global;
	import App.SoundControl;
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;	
	
	import App.Bus;		
	import App.Lib;	
	
	import J.UTIL.JsHelper;
	import J.UTIL.Tools;
	import J.BASE.BaseButton;
	
	/** @author Feyyaz */
	
	public class HeadCameraBtn extends BaseButton
	{
		public function HeadCameraBtn() 
		{
			
		}
		
		override protected function Start():void 
		{
			
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			gotoAndStop(2);
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			gotoAndStop(1);
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			GoToHeadCamera();
		}
		
		public function GoToHeadCamera() {
			var mSwfCom:SwfCom = new SwfCom();
			mSwfCom.StartHeadCamera();
		}
	}
	
} 