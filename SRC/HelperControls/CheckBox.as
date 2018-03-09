package HelperControls 
{
	import App.Lib;
	import flash.display.MovieClip;
	import J.BASE.BaseCheckBox;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import J.UTIL.Align;
	
	import J.BASE.BaseButton;	
	
	/** @author Feyyaz */
	
	public class CheckBox extends BaseCheckBox
	{
		public function get Checked():Boolean { return this.IsChecked; }
		
		private var mOver:MovieClip;			
		
		//---------------------------------------------------------------------------//
		
		public function CheckBox() {			
			this.BorderColor = 0x0851FF;
			OverBus();
		}
		
		private function OverBus():void
		{
			mOver = new Lib(Lib.Check);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			if (!this.IsChecked) {
				addChild(this.mOver);
				Align.CustomCenter(this.width, this.height, mOver); 
				this.mOver.x = 3;
				this.mOver.y = 2;
				this.IsChecked = true;
			}
			else {
				removeChild(mOver);
				this.IsChecked = false;
			}
		}
		
		//---------------------------------------------------------------------------//
		
		public function Check() {
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
		}
		
	}
	
}