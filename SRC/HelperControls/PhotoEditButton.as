package HelperControls
{
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;

	import App.Lib;
	
	/** @author Feyyaz */
	
	public class PhotoEditButton extends BaseButton
	{
		public static var tMove = Lib.PhotoEditMove;
		public static var tRotate = Lib.PhotoEditRotate;
		public static var tZoom = Lib.PhotoEditZoom;		
		
		private var mIcon:Lib;
		public var mActive:Lib;
		
		public function PhotoEditButton(ItemType:String) 
		{
			this.ItemType = ItemType;
		}
		
		override protected function Start():void 
		{
			mActive = new Lib(Lib.PhotoEditBtnFrame);
			addChild(mActive);
			mActive.visible = false;
			
			mIcon = new Lib(this.ItemType);
			addChild(mIcon);
			mIcon.x = 5;
			mIcon.y = 5;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			//mActive.visible = true;
		}
		
		override protected function onMouseOut(e:MouseEvent):void
		{
			//mActive.visible = false;
		}
		
		override protected function onClick(e:MouseEvent):void
		{ 
			
		}
	}
	
}