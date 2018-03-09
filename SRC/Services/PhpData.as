package Services 
{
	import App.DataManagement;
	import com.adobe.images.JPGEncoder;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenLite;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;

	import com.dynamicflash.util.Base64;
	import com.adobe.images.PNGEncoder;
	
	/** @author Feyyaz */
	
	public class PhpData extends Sprite
	{
		private var PhpURL = "http://www.ruffles.com.tr/enkafadar/php/data.php";
		private var PhpURLDownload = "http://www.ruffles.com.tr/enkafadar/php/save.php";
		private var PhpURLHeadCamera = "http://www.ruffles.com.tr/enkafadar/php/data_kafakamerasi.php";
		private var PhpURLErrorHandler = "http://www.ruffles.com.tr/enkafadar/php/errorhandler.php";
		private var PhpURLRandomBotName= "http://www.ruffles.com.tr/enkafadar/php/recursive.php";
		 
		public static var PhpFacebookShareURL = "http://www.ruffles.com.tr/enkafadar/index.php?share=";
		
		public static const PAGE_COMPLETE:String = "PAGE_COMPLETE";
		public static const PAGE_ERROR:String = "PAGE_ERROR";
		
		private var Request:URLRequest;
		private var Params:URLVariables;
		private var Loader:URLLoader;
		
		public static const tLogin:Number = 1;
		public static const tRegister:Number = 2;
		public static const tSendPassword:Number = 3;
		public static const tChangePassword:Number = 4;
		public static const tTopList:Number = 5;		
		public static const tLastGames:Number = 6;
		public static const tTrophies:Number = 7;
		public static const tAvatar:Number = 8;
		public static const tSaveDefaultHot:Number = 9;
		
		public static const tHeadCameraSaveScore = 1;
		public static const tHeadCameraTopScore = 2;
		
		public function PhpData(ResultListener:Function)
		{
			Request = new URLRequest(PhpURL);
			Params = new URLVariables();
			Loader = new URLLoader();
			
			DataManagement.ResultSet = new Object();
			
			addEventListener(PAGE_COMPLETE, ResultListener);
		}
		
		public function Login(Email:String, Password:String) {
			
			Params[Naming.ACTIONTYPE] = tLogin;
			
			Params[Naming.EMAIL] = Email;
			Params[Naming.PASSWORD] = Password;
			
			Call();
		}
		
		public function Register(Email:String, Password:String, FullName:String, City:Number) {
			
			Params[Naming.ACTIONTYPE] = tRegister;
			
			Params[Naming.EMAIL] = Email;
			Params[Naming.PASSWORD] = Password;
			Params[Naming.FULLNAME] = FullName;
			Params[Naming.CITY] = City;
			
			Call();
		}
		
		public function SendPassword(Email:String) {
			
			Params[Naming.ACTIONTYPE] = tSendPassword;
			
			Params[Naming.EMAIL] = Email;
			
			Call();
		}
		
		public function ChangePassword(NewPassword:String) {
			
			Params[Naming.ACTIONTYPE] = tChangePassword;
			
			Params[Naming.PASSWORD] = NewPassword;
			
			Call();
		}
		
		public function TopList() {
			
			Params[Naming.ACTIONTYPE] = tTopList;
			
			Call();			
		}
		
		public function Trophies() {
			
			Params[Naming.ACTIONTYPE] = tTrophies;
			
			Call();
		}
		
		public function LastGames() {
			
			Params[Naming.ACTIONTYPE] = tLastGames;
			
			Call();
		}
		
		public function SaveAvatar(AvatarData:BitmapData, Accessory:Number) {
			
			Params[Naming.ACTIONTYPE] = tAvatar;
			
			Params[Naming.AVATAR] = Base64.encodeByteArray(PNGEncoder.encode(AvatarData));
			Params[Naming.ACCESSORY] = Accessory;
			
			Call();
		}
		
		public function SaveDefaultHot(AvatarFileName:String) {
			
			Params[Naming.ACTIONTYPE] = tSaveDefaultHot;
			
			Params[Naming.AVATAR] = AvatarFileName;
			
			Call();
		}
		
		public function DownloadAvatar(AvatarData:BitmapData) {			
			var jpgEncoder:JPGEncoder = new JPGEncoder(100);			
			var jpgStream:ByteArray = jpgEncoder.encode(AvatarData);
			var encodedImage:Object = Base64.encodeByteArray(jpgStream);
			
			Params[Naming.AVATAR] = encodedImage;
			
			Request = new URLRequest(PhpURLDownload);
			
			Request.method = URLRequestMethod.POST;
			Request.data = Params;
			
			navigateToURL(Request, "_self");
		}
		
		private function AvatarDownloaded(e:Event):void { }
		
		
		public function ErrorHandler() {
			
			try 
			{
				if (!SFSGlobal.OpponentFinded) {
					Params[Naming.CUSTOMPARAM] = SwfGlobal.ErrorCommand;
					
					Request = new URLRequest(PhpURLErrorHandler);
					
					Call();
				}
			}
			catch (e:Error) { }
		}
		
		
		
		//HEADCAMERA
		public function GetTopScore() {
			
			Request = new URLRequest(PhpURLHeadCamera);
			
			Params[Naming.ACTIONTYPE] = tHeadCameraTopScore;
			
			Call();
		}
		
		public function SaveTopScore(FullName:String, Email:String, Mobile:String, Score:Number) {
			
			Request = new URLRequest(PhpURLHeadCamera);
			
			Params[Naming.ACTIONTYPE] = tHeadCameraSaveScore;
			
			Params[Naming.HEADCAMERAFULLNAME] = FullName;
			Params[Naming.HEADCAMERAEMAIL] = Email;
			Params[Naming.MOBILE] = Mobile;
			Params[Naming.GAMESCORE] = Score;			
			
			Call();
		}
		
		
		public function GetRandomBotName() {						
			Request = new URLRequest(PhpURLRandomBotName);		
			
			Call();
		}
		
		
		//----------------------------------
		
		
		
		private function Call() {							
			Request.method = URLRequestMethod.POST;
			Request.data = Params;
			
			Loader.addEventListener(Event.COMPLETE, Render);
			Loader.addEventListener(ProgressEvent.PROGRESS, Loading);
			Loader.load(Request);
			
			//if (Global.gIndicator == null) {
				//Global.gIndicator = new Indicator();
				//Global.gIndicator.alpha = 0;
				//Global.M.addChild(Global.gIndicator);
				//Global.gIndicator.x = Global.M.stage.mouseX;
				//Global.gIndicator.y = Global.M.stage.mouseY;			
				//TweenLite.to(Global.gIndicator, 1.5, { alpha: 1 } );
			//}
		}
		
		private function Loading(e:ProgressEvent):void 
		{
			//if (Global.gIndicator != null) {
				//Global.gIndicator.x = Global.M.stage.mouseX;
				//Global.gIndicator.y = Global.M.stage.mouseY;
			//}
		}
		
		private function Render(e:Event) {
			try {
				
				//if (Global.gIndicator != null) {
					//Global.M.removeChild(Global.gIndicator);
					//Global.gIndicator = null;					
				//}			
				DataManagement.ResultSet = JSON.decode(e.target.data);
				dispatchEvent(new Event(PAGE_COMPLETE));
			}
			catch (e:Error) { 
				trace("Error: " + e.toString());
				dispatchEvent(new Event(PAGE_ERROR));
			}								
		}
		
		
		public static function GenScoreShareData(HomeFullName:String, AwayFullName:String, HomeScore:Number, AwayScore:Number):String {
			return "{\"homefullname\":\"" + HomeFullName + "\", \"awayfullname\":\"" + AwayFullName + "\", \"homescore\":" + HomeScore.toString() + ", \"awayscore\":" + AwayScore.toString() + "}";
		}
	}
	
}