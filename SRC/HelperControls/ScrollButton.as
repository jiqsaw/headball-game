package HelperControls
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import J.BASE.BaseButton;
	
	import App.Lib;
	
	/** @author Feyyaz */
	
	public class ScrollButton extends BaseButton
	{
		public static const tScrollTop:String = Lib.ScrollTop;
		public static const tScrollBottom:String = Lib.ScrollBottom;
		public static const tScrollBall:String = Lib.ScrollBall;
		
		private var mImg:Sprite;
		
		public var ClickedItem:String;
		
		public function ScrollButton(ItemType:String) 
		{
			this.ItemType = ItemType;
			ClickedItem = ItemType;
		}
		
		override protected function Start():void 
		{
			mImg = new Lib(ItemType);
			addChild(mImg);			
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