package HelperControls 
{
	import App.Lib;
	import App.Session;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.text.TextField;
	import J.BASE.BaseMovieClip;
	import J.BASE.BaseText;
	import J.UTIL.Align;
	import J.UTIL.JsHelper;
	import Services.PhpData;

	import J.BASE.BaseLink;
	
	import App.Wording;	
	import App.Bus;
	import App.Global;
	import Screens.ChangePassword;
	
	/** @author Feyyaz */

	public class ProfileLink extends BaseMovieClip
	{	
		public static var tChangePassword:String = Wording.profileChangePassword;
		public static var tDownloadPhoto:String = Wording.profileDownloadPhoto;
		
		private var mLink:Link;
		private var ItemText:String;
		
		public function ProfileLink(ItemText:String)
		{
			this.ItemText = ItemText;			
		}
		
		override protected function Prep():void {
			mLink = new Link(this.ItemText, 17);
			addChild(mLink);
		}

	}
	
}