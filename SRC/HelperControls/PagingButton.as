package HelperControls
{
	
	import App.Lib;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;
	
	/** @author Feyyaz */
	
	public class PagingButton extends BaseButton
	{		
		public static const tPrev:String = Lib.ArrowLeft;
		public static const tNext:String = Lib.ArrowRight;
		
		private var mImg:Sprite;
		
		public function PagingButton(ItemType:String) 
		{
			this.ItemType = ItemType;
		}
		
		override protected function Start():void 
		{
			mImg = new Lib(ItemType);
			addChild(mImg);		
		}
		
		override protected function onMouseOver(e:MouseEvent):void { }
		override protected function onMouseOut(e:MouseEvent):void { }
		override protected function onClick(e:MouseEvent):void { }
	}
	
}