package App
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import J.UTIL.Tools;
	
	/** @author Feyyaz */

	public class Session
	{
		public static var IP:String;
		
		public static var sIsLogin:Boolean;
		public static var sIsSFSLogin:Boolean;
		
		public static var sUserID:Number;		
		public static var sEmail:String;
		public static var sPass:String;
		public static var sName:String;
		public static var sSurname:String;
		public static var sCityID:Number;
		public static var sCity:String;
		
		public static var sAvatar:MovieClip;
		public static var sAvatarBmpData:BitmapData;
		public static var sAvatarHot:Bitmap;
		public static var sAvatarFileName:String;
		public static var sAccessoryNo:Number;
		public static var sTrophies:Object;
		
		public static var sScore:Number;
		public static var sMatchWin:Number;
		public static var sMatchLost:Number;
		public static var sMatchDraw:Number;
		public static var sAverage:Number;
		public static var sOrder:Number;
		
		public function Session() { }
		
		public static function sFullName() {
			return sName + " " + sSurname;
		}
		
		public static function BindLogin(UserID:Number, Email:String, Pass:String, Name:String, Surname:String, CityID:Number, CityName:String, Score:Number, MatchWin:Number, MatchLost:Number, MatchDraw:Number, Average:Number, Order:Number, AvatarFileName:String, AccessoryNo:Number, Trophies:Object) {
			sIsLogin = true;
			sUserID = UserID;
			sEmail = Email;
			sPass = Pass;
			sName = Name;
			sSurname = Surname;
			sCityID = CityID;
			sCity = CityName;
			sScore = Score;
			sMatchWin = MatchWin;
			sMatchLost = MatchLost;
			sMatchDraw = MatchDraw;
			sAverage = Average;
			sOrder = Order;
			sAvatarFileName = AvatarFileName;
			sAccessoryNo = AccessoryNo;
			sTrophies = Trophies;
		}
		
		public static function GetAvatar():MovieClip {
			//return sAvatar;
			var GameAvatar:MovieClip = sAvatar;
			GameAvatar.scaleX = GameAvatar.scaleY = .5;			
			return GameAvatar;
		}
	}
	
}