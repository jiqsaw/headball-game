package HelperControls
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.xml.XMLNode;
	
	import J.BASE.BaseButton;	
	import J.UTIL.JsHelper;
	import J.BASE.BaseDropDownList;
	import J.UTIL.GraphicHelper;
	
	import HelperControls.Text;
	import HelperControls.DdlItem;
	import HelperControls.DdlSelectedItem;
	import App.Wording;
	
	/** @author Feyyaz */
	
	public class DropDownList extends BaseDropDownList
	{	
		private var mSelectedItem:DdlSelectedItem;
		private var InitialText:String;
		
		private var mListArea:MovieClip;		
		
		private var mScroll:DdlScroll;
		
		public static const onChange:String = "onChange";		
		
		
		public function DropDownList(InitialText:String, DataList:Array, ItemValue:String, ItemText:String) 
		{
			this.InitialText = InitialText;
			Bind(DataList, ItemValue, ItemText);
		}
		
		override protected function Prep():void 
		{
			mSelectedItem = new DdlSelectedItem(InitialText);
			
			mListArea = new MovieClip();						
			mListArea.addChild(GraphicHelper.drawRoundRectWithBorder(232, 110, 2, 0x0c54ff));
			
			this.SelectedItem = mSelectedItem;
			this.ListArea = mListArea;
		}
		
		override protected function Events():void 
		{
			this.Click(mSelectedItem, SelectedItemClick);
		}
		
		private function SelectedItemClick(e:MouseEvent):void
		{
			this.ShowHide();
		}		
		
		private function Bind(DataList:Array, ItemValue:String, ItemText:String) {
			var mDdlItem:DdlItem;
			var i:Number = 0;
			
			for each(var Item:Object in DataList) {
				mDdlItem = new DdlItem(Item[ItemText]);				
				mDdlItem.Value = Item[ItemValue];				
				
				this.mList.addChild(mDdlItem);
				this.XY(mDdlItem, 4, i * 25);				
				this.Click(mDdlItem, ItemClick);
				
				i ++;
            }
		}
		
		private function ItemClick(e:MouseEvent):void
		{
			var Item:DdlItem = e.currentTarget as DdlItem;
			Select(Item);
			mSelectedItem.dispatchEvent(e);
		}
		
		public function SelectValue(Value:String) {
			var dItem:DdlItem;
			for (var i:int = 0; i < this.mList.numChildren; i++) 
			{
				if (this.mList.getChildAt(i) as DdlItem) {
					dItem = this.mList.getChildAt(i) as DdlItem;
					if (dItem.Value == Value) {
						Select(dItem);
						break;
					}
				}
			}
		}
		
		
		public function Select(SelectedItem:DdlItem) {
			try 
			{
				this.SelectedValue = SelectedItem.Value;
				dispatchEvent(new Event(onChange));
				mSelectedItem.SelectedText(SelectedItem.ItemText);
			}
			catch (e:Error)
			{ 
				JsHelper.Console(e.toString());
			}
		}		
		
		public function SelectFirstItem() {
			var dItem:DdlItem;
			for (var i:int = 0; i < this.mList.numChildren; i++) 
			{
				if (this.mList.getChildAt(i) as DdlItem) {									
					dItem = this.mList.getChildAt(i) as DdlItem;
					Select(dItem);
					break;
				}
			}
		}			
		
		override protected function Load():void 
		{
			this.XY(this.mList, 0, 5);
			this.XY(this.ListArea, 0, 25);
		}
		
		override protected function Start():void 
		{
			mScroll = new DdlScroll(this, mList, 204, 99, 0, 30);
			this.ListArea.addChild(mScroll);
			this.XY(mScroll, 215, 2);
		}
	}
	
}