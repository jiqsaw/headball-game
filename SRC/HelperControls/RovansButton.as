package HelperControls
{
	import App.Bus;
	import App.Session;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	import J.UTIL.Colors;
	import J.UTIL.JsHelper;
	
	import J.BASE.BaseButton;
	
	import App.Lib;
	import HelperControls.Text;
	import Screens.Login;
	import Screens.SignUp;
	
	/** @author Feyyaz */
	
	public class RovansButton extends BaseButton
	{
		public static const tYes:String = "YES";
		public static const tNo:String = "NO";
		
		private var mBack:MovieClip;
		private var mText:Text;
		
		public function RovansButton(ItemType:String, ItemText:String) { 
			this.ItemType = ItemType;
			this.ItemText = ItemText;
		}
		
		override protected function Start():void 
		{
			mBack = new Lib(Lib.RovansBack);
			mText = new Text(ItemText, Text.Custom, (ItemType == tYes) ? Colors.Green : Colors.Red, 27);
			
			addChild(mBack);
			addChild(mText);
			
			mText.x = 15;
			mText.y = 9;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			
		}
		
		override protected function onClick(e:MouseEvent):void
		{ 
			
		}
	}
	
}