package HelperControls
{
	import App.Session;
	import be.wellconsidered.apis.fbbridge.events.FBBridgeEvent;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import J.UTIL.JsHelper;
	import Screens.Profile;
	import Services.PhpData;

	import J.BASE.BaseButton;
	import J.UTIL.Colors;
	import J.UTIL.Upload;
	import J.UTIL.FacebookHelper;
	
	import App.Lib;
	import App.Bus;
	import App.Global;
	import App.Wording;
	import Screens.PhotoEdit;
	import Screens.WebCamPhoto;
	import Screens.Facebook;
	import Screens.ChangePassword;
	import Screens.Login;
	
	/** @author Feyyaz */
	
	public class LoadPhotoItem extends BaseButton
	{
		public static const tFacebook:String = Lib.LoadPhotoFacebook;
		public static const tWebCam:String = Lib.LoadPhotoWebCam;
		public static const tNoWebCam:String = Lib.LoadPhotoNoWebCam;
		public static const tPc:String = Lib.LoadPhotoPc;
		public static var tDefaultHot:String = Lib.LoadPhotoDefaultHot1;
		
		private var mImg:MovieClip;
		private var mText:TextField;
		
		private var objUpload:Upload;
		
		private var FB:FacebookHelper;
		
		public function LoadPhotoItem(ItemType:String, ItemText:String) { 
			this.ItemType = ItemType;
			this.ItemText = ItemText;
		}
		
		override protected function Start():void 
		{
			if (ItemType == tDefaultHot) {
				if (Session.sAvatarFileName == Global.gDefaultHot1)
					mImg = new Lib(Lib.LoadPhotoDefaultHot2);
				else
					mImg = new Lib(Lib.LoadPhotoDefaultHot1);
			}
			else
				mImg = new Lib(ItemType);
			
			mText = new Text(ItemText, Text.LinkDesc);
			
			addChild(mImg);
			addChild(mText);
			
			mText.x = 0;
			mText.y = mImg.height + 10;
		}
		
		override protected function onMouseOver(e:MouseEvent):void 
		{
			if (this.enabled)
				mText.textColor = Global.gOverColor;
		}
		
		override protected function onMouseOut(e:MouseEvent):void 
		{
			if (this.enabled)
				mText.textColor = Colors.Black;
		}
		
		var SaveNewDefaultAvatar:String;
		override protected function onClick(e:MouseEvent):void 
		{
			switch (this.ItemType) 
			{
				case tFacebook:
					FB = new FacebookHelper();
					FB.Connect(UserLogged);
				break;
				
				case tWebCam:
					Bus.GetSubPage(new WebCamPhoto());
				break;
				
				case tPc:
					LoadPhoto();
				break;
				
				case tDefaultHot:				
					SaveNewDefaultAvatar = (Session.sAvatarFileName == Global.gDefaultHot1) ? Global.gDefaultHot2 : Global.gDefaultHot1;
					trace("SaveNewDefaultAvatar : " + SaveNewDefaultAvatar);
					var php:PhpData = new PhpData(SavedDefaultPhoto);
					php.SaveDefaultHot(SaveNewDefaultAvatar);				
				break;
			}
		}
		
		private function SavedDefaultPhoto(e:Event):void
		{			
			Session.sAvatarHot = null;
			Session.sAvatarFileName = SaveNewDefaultAvatar;
			Bus.CloseSubPage();
			Bus.GetPage(new Profile());
		}
		
		private function LoadPhoto():void
		{
			objUpload = new Upload(Upload.JPG_GIF_PNG, Wording.loadphotoExtDesc);
			objUpload.Load(PhotoLoaded);
		}
		
		private function PhotoLoaded(e:Event):void
		{
			if (objUpload.IsValid) {
				Bus.GetSubPage(new PhotoEdit(objUpload.GetBitmap(e)), false);
			}
		}
		
		private function UserLogged(e:FBBridgeEvent):void
		{
			FB.IsLogin = true;
			Bus.GetSubPage(new Facebook(), false);
		}
	}
	
}	