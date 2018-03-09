package App
{	
	import com.adobe.serialization.json.JSON;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import Services.SFS;
	import Services.SFSClient;
	import Services.SFSGlobal;
	
	import J.UTIL.Tools;
	import Services.Naming;
	import App.Session;
	
	/** @author Feyyaz */
	
	public class DataManagement
	{	
		public static var ResultSet:Object = null;
		
		public static const rSuccess:Number = 0;
		public static const rError:Number = 1;
		public static const rHasUser:Number = 2;
		public static const rNoUser:Number = 3;
		
		public function DataManagement() { }
		
		public static function LoginManagement():Number {			
			if (!IsError()) {
				
				//SmartFox Bağlan
				SFS.Connect();
				
				var Data:Object = ResultSet[Naming.DATA];
				Session.BindLogin(
					Data[Naming.ID], Data[Naming.EMAIL], Data[Naming.PASSWORD], Data[Naming.NAME],
					Data[Naming.SURNAME], Data[Naming.CITY], Data[Naming.CITYNAME], Data[Naming.SCORE], Data[Naming.MATCHWIN], Data[Naming.MATCHLOST],
					Data[Naming.MATCHDRAW], Data[Naming.AVERAGE], Data[Naming.ORDER], Data[Naming.AVATAR], Data[Naming.ACCESSORY], Data[Naming.TROPHIES]);
				
				return rSuccess;
			}
			return ResultType();
		}
		
		public static function TrophiesManagement():Object {
			return JSON.decode(ResultData().toString());
		}
		
		public static function ResultType():Number {
			return Number(ResultSet[Naming.ERROR]);
		}
		
		public static function ResultData():Object {
			return ResultSet[Naming.DATA];
		}		
		
		public static function IsError():Boolean {
			return !(ResultType() == 0);
		}
	}
	
}