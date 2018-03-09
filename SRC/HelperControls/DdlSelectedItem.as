package HelperControls
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import J.BASE.BaseDropDownList;	
	import J.BASE.BaseButton;
	import J.UTIL.GraphicHelper;
	
	import App.Lib;	
	
	/** @author Feyyaz */
	
	public class DdlSelectedItem extends BaseButton
	{			
		public var Item:Text;
		
		private var mArrowDown:Sprite;
		private var mArrowUp:Sprite;
		
		public function DdlSelectedItem(InitialText:String) 
		{
			addChild(GraphicHelper.drawRoundRectWithBorder(232, 28, 2, 0x0c54ff));
			Item = new Text(InitialText, Text.ddlItem);
			Item.x = 4;
			Item.y = 2;
			
			addChild(Item);
			
			mArrowDown = new Lib(Lib.ArrowDown);
			mArrowUp = new Lib(Lib.ArrowUp);
			
			addChild(mArrowDown);
			addChild(mArrowUp);
			
			mArrowDown.x = mArrowUp.x = 205;
			mArrowUp.y = mArrowDown.y = 7;
			
			mArrowUp.visible = false;
		}
		
		public function SelectedText(Value:String) {
			Item.text = Value;
		}
		
		override protected function onMouseOver(e:MouseEvent):void { }
		override protected function onMouseOut(e:MouseEvent):void { }
		override protected function onClick(e:MouseEvent):void {
			mArrowDown.visible = !mArrowDown.visible;		
			mArrowUp.visible = !mArrowUp.visible;			
		}
	}
	
}