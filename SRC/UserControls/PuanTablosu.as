package UserControls 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;	
	import J.UTIL.Colors;
	
	import J.BASE.BaseButton;
	import J.UTIL.JsHelper;

	import App.Global;
	import App.Wording;
	import App.Lib;
	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class PuanTablosu extends BaseButton
	{
		private var mMenuItemBack:Lib;
		private var mText:Text;
		
		//---------------------------------------------------------------------------//
		
		public function PuanTablosu() { }
		
		override protected function Start():void {			
			mMenuItemBack = new Lib(Lib.PuanTablosuButtonBack);
			mText = new Text(Wording.profileBtnPuanTablosu, Text.Custom, Colors.Black, 20);
			
			addChild(mMenuItemBack);
			addChild(mText);
			
			mText.x = 15;
			mText.y = 17;
			this.rotation = 15;
		}
		override protected function onMouseOver(e:MouseEvent):void {
			mText.textColor = Global.gOverColor;
		}		
		override protected function onMouseOut(e:MouseEvent):void { 
			mText.textColor = 0xE3091F;
		}
		override protected function onClick(e:MouseEvent):void { 
			JsHelper.GATracker(mText.text); 
		}	
		
		//---------------------------------------------------------------------------//
		
	}
	
}