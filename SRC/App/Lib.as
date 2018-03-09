package App
{
	import J.BASE.BaseMovieClip;

	/** @author Feyyaz */
	
	public class Lib extends BaseMovieClip
	{  
		//EXTERNAL PATHS
		public static const GameSwf = "Game.swf";
		public static const GameClientSwf = "GameClient.swf";
		
		public static const HowToPlayTextSrc = "Data/HowToPlay.txt";
		public static const AwardsDesc = "Data/Awards.txt";
		public static const Cities = "Xml/Cities.xml";
		public static const AvatarPath = "http://www.ruffles.com.tr/enkafadar/Avatar/";
		public static const InvitePath = "http://www.ruffles.com.tr/enkafadar/davet.php";
		
		public static const ConditionsPopup = "Conditions.php";
		
		public static const WinnersSrc = "Data/Winners.txt";
		
		//MAIN
		public static const BackImg = "BackImg";
		
		//AVATAR
		public static const AvatarBody = "AvatarBody";
		public static const AvatarHot = "AvatarHot";
		public static const AvatarDownloadBack = "AvatarDownloadBack";
		
		//MENU
		public static const MenuItemAwards:String = "MenuItemAwards";
		public static const MenuItemTopList:String = "MenuItemTopList";	
		public static const MenuItemHowToPlay:String = "MenuItemHowToPlay";
		public static const MenuOverMask:String = "MenuOverMask";
		
		//SUB CONTAINER
		public static const SubContainerBoard:String = "SubContainerBoard";
		public static const SketchLeft:String = "SketchLeft";
		public static const SketchRight:String = "SketchRight";		
		
		//JOIN
		public static const JoinJuliana:String = "JoinJuliana";
		public static const JoinLoginBack:String = "JoinLoginBack";
		public static const JoinSignBack:String = "JoinSignBack";		
		
		//ENTRY		
		public static const HotBall:String = "HotBall";
		public static const EntryAwardBack:String = "EntryAwardBack";	
		public static const HotCam:String = "HotCam";
		
		//PROFILE
		public static const SiralamaBack:String = "SiralamaBack";
		public static const ChangePasswordIcon:String = "ChangePasswordIcon";
		public static const DownloadPhotoIcon:String = "DownloadPhotoIcon";		
		public static const LastGames:String = "LastGames";
		public static const ChooseUniform:String = "ChooseUniform";
		public static const Trophies:String = "Trophys";
		public static const ChangePhoto:String = "ChangePhoto";
		public static const FBInvite:String = "FBInvite";
		
		//HOW TO PLAY
		public static const JulianaHowToPlay:String = "JulianaHowToPlay";		
		
		//ÖDÜLLER
		public static const AwardsJuliana = "AwardsJuliana";
		public static const AwardsDavul = "AwardsDavul";
		public static const AwardsKlakson = "AwardsKlakson";
		public static const AwardsBall = "AwardsBall";
		public static const AwardsKronometre = "AwardsKronometre";
		public static const AwardsPlayStation = "AwardsPlayStation";
		public static const AwardsPes2010 = "AwardsPes2010";
		public static const AwardsProjeksiyon = "AwardsProjeksiyon";
		
		//TOPLIST
		public static const TopListBack:String = "TopListBack";
		public static const JulianaTopList:String = "JulianaTopList";
		
		//LOAD PHOTO
		public static const LoadPhotoFacebook:String = "LoadPhotoFacebook";
		public static const LoadPhotoWebCam:String = "LoadPhotoWebCam";
		public static const LoadPhotoPc:String = "LoadPhotoPc";
		public static const LoadPhotoDefaultHot1:String = "LoadPhotoDefaultHot1";
		public static const LoadPhotoDefaultHot2:String = "LoadPhotoDefaultHot2";
		public static const LoadPhotoNoWebCam:String = "LoadPhotoNoWebCam";
		
		//PHOTO EDIT
		public static const PhotoEditMove:String = "PhotoEditMove";
		public static const PhotoEditRotate:String = "PhotoEditRotate";
		public static const PhotoEditZoom:String = "PhotoEditZoom";
		public static const PhotoEditBtnFrame:String = "PhotoEditBtnFrame";
		
		//WEBCAM
		public static const WebCamMask:String = "WebCamMask";
		public static const PreviewMask:String = "PreviewMask";
		
		//MATCH RESULT
		public static const RovansBack:String = "RovansBack";
		
		//GLOBAL
		public static const Check:String = "Check";
		public static const X:String = "X";
		public static const ArrowLeft:String = "ArrowLeft";
		public static const ArrowRight:String = "ArrowRight";
		public static const ArrowDown:String = "ArrowDown";
		public static const ArrowUp:String = "ArrowUp";
		public static const IconWin:String = "IconWin";
		public static const IconLose:String = "IconLose";
		public static const IconDraw:String = "IconDraw";
		public static const FacebookShare:String = "FacebookShare";
		public static const LogoSmall:String = "LogoSmall";
		
		//SCROLL
		public static const ScrollTop = "ScrollTop";
		public static const ScrollBottom = "ScrollBottom";
		public static const ScrollBall = "ScrollBall";
		
		private var ItemType:String;
		
		public function Lib(ItemType:String)
		{
			this.ItemType = ItemType;
		}
		
		override protected function Prep():void { }
		override protected function AddStage():void { }
		override protected function Events():void { }
		override protected function Load():void {
			this.gotoAndStop(ItemType);
		}
		override protected function Start():void { }		
	}
	
}