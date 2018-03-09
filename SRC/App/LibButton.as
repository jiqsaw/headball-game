package App
{
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;
	
	/** @author Feyyaz */
	
	public class LibButton extends BaseButton
	{			
		public function LibButton(ItemType:String)
		{
			this.ItemType = ItemType;	
		}
		
		override protected function Start():void {
			addChild(new Lib(this.ItemType));
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