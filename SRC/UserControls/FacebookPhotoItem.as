package UserControls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import J.UTIL.JsHelper;
	
	import J.UTIL.Align;
	import J.UTIL.Colors;
	import J.BASE.BaseButton;
	import J.UTIL.GraphicHelper;
	
	import App.Bus;
	import Screens.PhotoEdit;
	
	/** @author Feyyaz */
	
	public class FacebookPhotoItem extends BaseButton
	{
		private var mContainer:Sprite;
		private var Photo:Bitmap;
		private var BigSrc:String;
		
		public function FacebookPhotoItem(Photo:Bitmap, BigSrc:String)
		{
			this.Photo = Photo;
			this.BigSrc = BigSrc;
		}
		
		override protected function Start():void 
		{
			mContainer = GraphicHelper.draw(57, 57);
			
			addChild(mContainer);
			
			mContainer.addChild(Photo);
			
			Align.CustomCenter(mContainer.width, mContainer.height, Photo);
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			this.y -= 3;
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			this.y += 3;
		}		
		
		override protected function onClick(e:MouseEvent):void 
		{
			//this.Disable();
			var PhotoLoader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;			
			PhotoLoader.load(new URLRequest(BigSrc), context);
			
			PhotoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, PhotoLoaded);							
		}		
		
		private function PhotoLoaded(e:Event):void 
		{
			JsHelper.Console(BigSrc);
			var BigPhoto:Bitmap = e.currentTarget.content;
			Bus.GetSubPage(new PhotoEdit(BigPhoto), false);
		}
	}
	
}