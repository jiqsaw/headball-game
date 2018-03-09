package HelperControls 
{
	import com.adobe.crypto.MD5;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import J.BASE.BaseButton;
	import J.UTIL.Colors;
	import J.UTIL.Filter;
	import J.UTIL.GraphicHelper;
	
	import J.BASE.BaseMovieClip;
	
	import App.Wording;
	import App.Lib;
	import HelperControls.Link;
	
	/** @author Feyyaz */
	
	public class MenuItem extends BaseButton
	{
		private var mMenuItemBack:Lib;
		private var mLink:Text;
		private var mMask:Sprite;
		
		//---------------------------------------------------------------------------//
		
		public function MenuItem(ItemType:String, ItemText:String)
		{
			this.ItemType = ItemType;
			this.ItemText = ItemText;
		}
		
		override protected function Start():void { 
			mMenuItemBack = new Lib(this.ItemType);
			
			var mStroke:Text = new Text(ItemText, Text.Custom, 0x000000, 24);
			//mStroke.filters = new Array(Filter.Stroke(Colors.Black));
			var mLinkContainer:MovieClip = new MovieClip();
			
			mLink = new Text(ItemText, Text.Links);
			
			addChild(mMenuItemBack);
			addChild(mStroke);
			addChild(mLinkContainer);
			mLinkContainer.addChild(mLink);
			
			mStroke.x = 23;
			mStroke.y = 21;
			
			mLinkContainer.x = 23;
			mLinkContainer.y = 21;
			
			mMask = new Sprite();
			
			var Mask1:Sprite = GraphicHelper.draw(mLinkContainer.width, mLinkContainer.height, Colors.White, 1);
			var MaskOver:Lib = new Lib(Lib.MenuOverMask);
			//mMask.addChild(Mask1);
			mMask.addChild(MaskOver);
			MaskOver.y = Mask1.height;
			
			addChild(mMask);
			mMask.x = mLinkContainer.x;
			mMask.y = mLinkContainer.y;
			mMask.mask = mStroke;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			Over();
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			Out();
		}
		
		override protected function onClick(e:MouseEvent):void { }
		
		//---------------------------------------------------------------------------//
		
		private function ShowLink() {
			mLink.visible = true;
		}
		
		public function Over() {
			TweenLite.to(mMask, .5, { y:-5 } );
		}
		
		public function Out() {
			TweenLite.to(mMask, .5, { y:22 } );
		}
		
		public function Active():void {
			Out();
			this.Enable();
		}		
	}
	
}