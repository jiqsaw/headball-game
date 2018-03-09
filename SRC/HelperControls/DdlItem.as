package HelperControls
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import J.UTIL.Colors;	
	import J.UTIL.GraphicHelper;
	import J.BASE.BaseButton;
	
	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class DdlItem extends BaseButton
	{
		var Back:Sprite;
		var Item:Text;
		
		public var Value:String;
		
		public function DdlItem(ItemText:String)
		{
			this.ItemText = ItemText;
		}
		
		override protected function Start():void 
		{
			Back = GraphicHelper.drawRoundRect(197, 24, 3, 0x000000);
			Item = new Text(ItemText, Text.ddlItem);
			
			addChild(Back);
			addChild(Item);
			
			Back.alpha = 0;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			Back.alpha = 1;
			Item.textColor = Colors.White;
			Item.x += 5;
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			Back.alpha = 0;
			Item.textColor = Colors.Black;
			Item.x -= 5;
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			//trace(this.name);
		}
	}
	
}