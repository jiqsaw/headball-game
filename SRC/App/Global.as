package App
{	

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;	
	import UserControls.Logo;
	import UserControls.Menu;
	
	import J.UTIL.Colors;
	
	import Containers.Master;	
	import Containers.SubContainer;	
	import UserControls.Frame;
	
	/** @author Feyyaz */
		
	public class Global
	{
		public static var M:Main;		// Main
		public static var GameContainer:Sprite = null;
		public static var Back:MovieClip;
		public static var gFrame:Frame;
		public static var gMaster:Master;
		public static var gMainLogo:Logo;
		public static var gMenu:Menu;
		public static var gContainer:MovieClip;
		public static var gOverlay:Sprite;
		public static var gSubContainer:SubContainer;		
		public static var gIndicator:MovieClip = null;
		
		public static var gDefaultHot1:String = "DefaultHot1.png";
		public static var gDefaultHot2:String = "DefaultHot2.png";
		
		public static var gAvatar:Bitmap;
		public static var gAvatarFull:Bitmap;
		
		public static var gPhotoW:Number = 387;
		public static var gPhotoH:Number = 201;
		public static var gPhotoMaxH:Number = 560;
		
		public static var gAvatarHotW:Number = 56;
		public static var gAvatarHotH:Number = 59;
		
		public static var gOverColor:uint = Colors.Blue;		
		
		public static var DefaultRotation:Number = -3;
		public static var CityIstanbulID:Number = 34;
		
		public static var GameStageW:Number = 966;
		public static var GameStageH:Number = 545;
		public static var RovansWaitTime:Number = 10;		
		
		public function Global() { }
		
	}
	
}