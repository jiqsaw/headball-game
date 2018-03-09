package HelperControls 
{
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;	
	
	import J.BASE.BaseButton;
	import J.UTIL.JsHelper;
	
	import App.Lib;
	
	/** @author Feyyaz */
	
	public class ShareIconItem extends BaseButton
	{
		public static const facebook:String = "facebook";
		public static const twitter:String = "twitter";
		public static const friendfeed:String = "friendfeed";
		
		private var mShareItem:Lib;		
		
		//---------------------------------------------------------------------------//
		
		public function ShareIconItem(ItemType:String) 		
		{
			this.ItemType = ItemType;
		}
		
		override protected function Start():void
		{
			mShareItem = new Lib(this.ItemType);
			addChild(mShareItem);
			mShareItem.gotoAndStop(ItemType);
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			mShareItem.y -= 3;
		}
		
		override protected function onMouseOut(e:MouseEvent):void
		{
			mShareItem.y += 3;
		}
		
		override protected function onClick(e:MouseEvent):void
		{	
			JsHelper.GATracker(this.ItemType);
			JsHelper.Share(this.ItemType);
		}	
		
		//---------------------------------------------------------------------------//
	}
	
}