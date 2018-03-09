package UserControls
{
	import App.Bus;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	
	import J.BASE.BaseButton;
	
	import App.Lib;
	import HelperControls.Text;
	import Screens.Login;
	import Screens.SignUp;
	
	/** @author Feyyaz */
	
	public class JoinButton extends BaseButton
	{
		public static const tLogin:String = "Login";
		public static const tSign:String = "Sign";
		
		private var mBack:MovieClip;
		private var mText:Text;
		
		public function JoinButton(ItemType:String, ItemText:String) { 
			this.ItemType = ItemType;
			this.ItemText = ItemText;
		}
		
		override protected function Start():void 
		{
			var LibFrame:String = (ItemType == tLogin) ? Lib.JoinLoginBack : Lib.JoinSignBack;
			mBack = new Lib(LibFrame);
			mText = new Text(ItemText, Text.JoinButton);
			
			addChild(mBack);
			addChild(mText);
			
			mText.x = 15;
			mText.y = 24;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			switch (ItemType) 
			{
				case tLogin:					
					Bus.GetSubPage(new Login());
				break;
				
				case tSign:
					Bus.GetSubPage(new SignUp());
				break;
			}
		}
	}
	
}