package HelperControls 
{	
	import flash.events.MouseEvent;
	import J.BASE.BaseText;
		
	import J.BASE.BaseLink;
	import J.UTIL.JsHelper;
	import J.UTIL.Colors;
	
	import App.Global;
	
	/** @author Feyyaz */

	public class Link extends BaseLink
	{	
		private var Color:uint;
		public var CommandValue:String;
		public function Link(ItemText:String, Size:Number = 20, TextType:String = Text.Links, CommandValue:String = "")
		{
			this.TxtItem = new Text(ItemText, TextType, Colors.White, Size);
			this.ItemText = ItemText;
			this.Color = this.TxtItem.textColor;
			this.CommandValue = CommandValue;
			addChild(this.TxtItem);
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			this.TxtItem.textColor = Global.gOverColor;
		}
		
		override protected function onMouseOut(e:MouseEvent):void
		{			
			this.TxtItem.textColor = Color;
		}
		
		override protected function onClick(e:MouseEvent):void
		{			
			
		}	
	}
	
}