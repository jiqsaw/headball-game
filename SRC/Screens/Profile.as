package Screens 
{	
	import App.Global;
	import App.LibButton;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import J.UTIL.Filter;
	import J.UTIL.JsHelper;
	import J.UTIL.Tools;
	import Services.PhpData;
	import UserControls.Accessories;
	
	import J.UTIL.Align;	
	import J.BASE.BaseText;
	import J.BASE.BaseMovieClip;
	import J.UTIL.GraphicHelper;
	import J.UTIL.Colors;

	import App.Bus;
	import App.Session;
	import App.Wording;
	import App.Lib;
	import HelperControls.Text;
	import HelperControls.ProfileLink;
	import UserControls.ProfileBox;
	import HelperControls.ProfileBoxImg;
	import HelperControls.CallButton;
	
	/** @author Feyyaz */

	public class Profile extends BaseMovieClip
	{					
		private var mHr:Sprite;
		
		private var mIconBack:Sprite;
		private var mIconBack2:Sprite;
		
		private var mChangePasswordIcon:MovieClip;
		private var mDownloadPhotoIcon:MovieClip;
		
		private var mTxtProfileTitle:Text;
		private var mTxtFullName:Text;
		
		private var mTxtPuanTitle:Text;
		private var mTxtPuan:Text;
		
		private var mTxtAverajTitle:Text;
		private var mTxtAveraj:Text;
		
		private var mTxtGalibiyetTitle:Text;
		private var mTxtMaglubiyetTitle:Text;
		private var mTxtBeraberlikTitle:Text;
		
		private var mTxtGalibiyet:Text;
		private var mTxtMaglubiyet:Text;
		private var mTxtBeraberlik:Text;
		
		private var mSiralamaBack:MovieClip;
		private var mSiralamaLabel:Text;
		private var mSiralamaValue:Text;
		
		private var mChangePassword:ProfileLink;
		private var mDownloadPhoto:ProfileLink;
		
		private var mSon5macBox:ProfileBox;
		private var mTrophiesBox:ProfileBox;
		private var mChangePhotoBox:ProfileBox;
		
		private var mStartGame:CallButton;
		
		private var AvatarFull:MovieClip;
		
		private var FBInviteDesc:Text;
		private var FBInviteBtn:LibButton;
		
		//---------------------------------------------------------------------------//
		
		public function Profile() { JsHelper.GATracker("Profil"); }
		
		override protected function Prep():void {
			
			if (!Session.sIsLogin)
				Bus.GetPage(new Entry());
				
			mHr = GraphicHelper.drawRoundRectWithBorder(326, 8, 2, Colors.White, 1, Colors.Blue);
			
			mIconBack = GraphicHelper.drawRoundRectWithBorder(28, 28, 3, Colors.Blue, 6);
			mIconBack2 = GraphicHelper.drawRoundRectWithBorder(28, 28, 3, Colors.Blue, 6);
			
			mChangePasswordIcon = new Lib(Lib.ChangePasswordIcon);
			mDownloadPhotoIcon = new Lib(Lib.DownloadPhotoIcon);
			
			var FullName:String = Session.sName + " <font color='#FF0000'>" + Session.sSurname  + "</font>";
			
			mTxtProfileTitle = new Text(Wording.profileProfileTitle, Text.Custom, Colors.White, 46);
			mTxtPuanTitle = new Text(Wording.profilePuanTitle, Text.Custom, 0xF3C721, 85, 150, TextFormatAlign.RIGHT);
			mTxtFullName = new Text(FullName, Text.ProfileText);
			
			mTxtPuan = new Text(Session.sScore.toString(), Text.Custom, 0xFFFFFF, 85, 260, TextFormatAlign.RIGHT);
			
			mTxtAverajTitle = new Text(Wording.profileAverajTitle, Text.BlueLabel);
			
			mTxtGalibiyetTitle = new Text(Wording.profileGalibiyetTitle, Text.BlueLabel);
			mTxtMaglubiyetTitle = new Text(Wording.profileMaglubiyetTitle, Text.BlueLabel);
			mTxtBeraberlikTitle = new Text(Wording.profileBeraberlikTitle, Text.BlueLabel);
			
			mTxtGalibiyet = new Text(Session.sMatchWin.toString(), Text.ProfileValue);
			mTxtMaglubiyet = new Text(Session.sMatchLost.toString(), Text.ProfileValue);
			mTxtBeraberlik = new Text(Session.sMatchDraw.toString(), Text.ProfileValue);
			mTxtAveraj = new Text(Session.sAverage.toString(), Text.ProfileValue);
			
			mChangePassword = new ProfileLink(ProfileLink.tChangePassword);
			mDownloadPhoto = new ProfileLink(ProfileLink.tDownloadPhoto);
			
			mSon5macBox = new ProfileBox(ProfileBoxImg.tLastGames, ProfileBox.tLastGames);
			mTrophiesBox = new ProfileBox(ProfileBoxImg.tTrophies, ProfileBox.tTrophies);
			mChangePhotoBox = new ProfileBox(ProfileBoxImg.tChangePhoto, ProfileBox.tChangePhoto);
			
			mSiralamaBack = new Lib(Lib.SiralamaBack);
			mSiralamaLabel = new Text(Wording.profileSira, Text.Custom, Colors.Black, 18);
			mSiralamaValue = new Text(Session.sOrder.toString(), Text.ProfileValue);
			
			mStartGame = new CallButton(CallButton.StartGame);
			
			FBInviteDesc = new Text(Wording.profileFBInviteDesc, Text.Desc);
			FBInviteBtn = new LibButton(Lib.FBInvite);
		}
		
		override protected function AddStage():void {								
			
			addChild(mHr);
			
			addChild(mIconBack);
			addChild(mIconBack2);
			
			addChild(mChangePasswordIcon);
			addChild(mDownloadPhotoIcon);
			
			addChild(mTxtProfileTitle);
			
			addChild(mTxtPuan);
			addChild(mTxtPuanTitle);
			
			addChild(mTxtFullName);
			
			addChild(mTxtGalibiyetTitle);
			addChild(mTxtMaglubiyetTitle);
			addChild(mTxtBeraberlikTitle);
			
			addChild(mTxtGalibiyet);
			addChild(mTxtMaglubiyet);
			addChild(mTxtBeraberlik);
			
			addChild(mTxtAverajTitle);
			addChild(mTxtAveraj);
			
			addChild(mChangePassword);
			addChild(mDownloadPhoto);
			
			addChild(mSon5macBox);
			addChild(mTrophiesBox);
			addChild(mChangePhotoBox);
			
			addChild(mSiralamaBack);
			mSiralamaBack.addChild(mSiralamaLabel);
			mSiralamaBack.addChild(mSiralamaValue);
			
			addChild(mStartGame);					
			
			addChild(FBInviteDesc);
			addChild(FBInviteBtn);
			
			GenerateAvatar();
		}
		
		override protected function Events():void {
			this.Click(mStartGame, StartGame);
			this.Click(mChangePassword, ChangePasswordClick);
			this.Click(mDownloadPhoto, AvatarDownloadClick);
			this.Click(FBInviteBtn, FBInviteBtnClick);
		}		
		
		override protected function Load():void {
			this.XY(mHr, 206, 145);
			
			this.XY(mIconBack, 	291, 218);
			this.XY(mIconBack2, 291, 252);
			
			this.XY(mChangePasswordIcon, 299, 224);
			this.XY(mDownloadPhotoIcon, 293, 257);
			
			this.XY(mTxtProfileTitle, 206, 82);
			
			this.XY(mTxtPuan, 470, 81);
			this.XY(mTxtPuanTitle, 754, 81);
			
			this.XY(mTxtFullName, 285, 173);
			
			this.XY(mTxtGalibiyetTitle, 525, 164);
			this.XY(mTxtMaglubiyetTitle, 654, 164);
			this.XY(mTxtBeraberlikTitle, 776, 164);
			
			this.XY(mTxtGalibiyet, 630, 164);
			this.XY(mTxtMaglubiyet, 759, 164);
			this.XY(mTxtBeraberlik, 882, 164);
			
			this.XY(mTxtAverajTitle, 678, 216);
			this.XY(mTxtAveraj, 780, 216);
			
			
			this.XY(mChangePassword, 325, 222);
			this.XY(mDownloadPhoto, 325, 260);
			
			this.XY(mSon5macBox, 300, 336);			
			this.XY(mTrophiesBox, mSon5macBox.x + 90, 336);
			this.XY(mChangePhotoBox, mTrophiesBox.x + 82, 336);
			
			mSon5macBox.rotation = 3;
			mTrophiesBox.rotation = -2;
			mChangePhotoBox.rotation = 2;
			
			this.XY(mSiralamaBack, 560, 200);
			this.XY(mSiralamaLabel, 18, 20);
			this.XY(mSiralamaValue, 53, 15);
			
			this.XY(mStartGame, 708, 482);
			
			this.XY(FBInviteDesc, 590, 336);
			this.XY(FBInviteBtn, 710, 410);
			
			mSiralamaBack.rotation += 8;
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//
		
		private function GenerateAvatar():void
		{
			var bmpData:BitmapData;
			
			if (Session.sAvatarHot == null)
				this.LoadObj(AvatarFileLoad, Lib.AvatarPath + Session.sAvatarFileName);
			else
				SetAvatar();
		}
		
		private function AvatarFileLoad(e:Event):void 
		{			
			Session.sAvatarHot = e.currentTarget.content;
			Session.sAvatarHot.smoothing = true;
			SetAvatar();
		}
		
		private function SetAvatar() {
			AvatarFull = new MovieClip();
			Session.sAvatar = new MovieClip();
			
			var mAvatarBody = new Lib(Lib.AvatarBody);			
			var mAccessory:Accessories = new Accessories(Session.sAccessoryNo);
			
			Session.sAvatarHot.filters = new Array(Filter.Stroke());
			mAccessory.filters = new Array(Filter.Stroke());			
			
			Session.sAvatar.scaleX = Session.sAvatar.scaleY = .7;
			
			Session.sAvatar.addChild(Session.sAvatarHot);			
			Session.sAvatar.addChild(mAccessory);			
			
			if ((Session.sAvatarFileName == Global.gDefaultHot1) || (Session.sAvatarFileName == Global.gDefaultHot2))
				mAccessory.visible = false;
			
			AvatarFull.addChild(Session.sAvatar);
			AvatarFull.addChild(mAvatarBody);
			addChild(AvatarFull);
			
			this.XY(Session.sAvatarHot, 90, 0);
			this.XY(mAccessory, 125, 0);
			this.XY(Session.sAvatar, 16, 0);
			this.XY(mAvatarBody, 0, 88);
			
			this.XY(AvatarFull, 116, 180);
			
			//Oyun için avatar ın bmp datasını hazırlar		
			Session.sAvatarBmpData = new BitmapData(Session.sAvatar.width, Session.sAvatar.height, true, 0);
			Session.sAvatarBmpData.draw(Session.sAvatar, null, null, null, null, true);
		}		
		
		private function ChangePasswordClick(e:MouseEvent):void
		{
			Bus.GetSubPage(new ChangePassword());
		}
		
		private function AvatarDownloadClick(e:MouseEvent):void
		{
			var AvatarBack:Lib = new Lib(Lib.AvatarDownloadBack);
			
			var AvatarData:BitmapData = new BitmapData(200, 250, true, 0);
			AvatarData.draw(AvatarFull, new Matrix(1, 0, 0, 1, 0, 36), null, null, null, true);
			
			var Avatar:Bitmap = new Bitmap(AvatarData);
			
			var DownloadImg:MovieClip = new MovieClip();
			DownloadImg.addChild(AvatarBack);
			DownloadImg.addChild(Avatar);
			
			this.XY(Avatar, 5, 0);
			
			addChild(DownloadImg);
			this.XY(DownloadImg, 400, 200);
			
			DownloadImg.visible = false;
			
			var DownloadImgData:BitmapData = new BitmapData(DownloadImg.width, DownloadImg.height);
			DownloadImgData.draw(DownloadImg, null, null, null, null, true);					
			
			var php:PhpData = new PhpData(AvatarDownloaded);
			php.DownloadAvatar(DownloadImgData);
			
		}
		
		private function AvatarDownloaded(e:Event):void
		{
			JsHelper.GATracker("AvatarIndir");
		}		
		
		private function StartGame(e:MouseEvent):void
		{
			Bus.StartGame(Lib.GameSwf);
		}		
		
		private function FBInviteBtnClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(Lib.InvitePath), "_blank");
		}		
	}
	
}