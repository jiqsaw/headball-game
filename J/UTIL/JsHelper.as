package J.UTIL
{
	import flash.external.ExternalInterface;
	
	/** @author Feyyaz */
	
	public class JsHelper 
	{		
		public function JsHelper() { }
		
		public static function Share(PageName:String)
		{
			var jsFunc:String = "Share('" + PageName + "')";			
			Call(jsFunc);
			Console(jsFunc);
		}
		
		public static function ShareDynamic(ShareURL:String, Site:String)
		{
			var jsFunc:String = "socialShare('" + ShareURL + "', '" + Site + "')";
			Call(jsFunc);
		}
		
		public static function GATracker(PageName:String) 
		{
			//var jsFunc:String = "pageTracker._trackPageview('fl_" + PageName + "')";
			var jsFunc:String = "_gaq.push(['_trackPageview', '" + PageName + "'])";			
			Call(jsFunc);
		}
		
		public static function Popup(PageName:String, Width:Number, Height:Number) 
		{
			var jsFunc:String = "Popup('" + PageName + "', " + Width.toString() + ", " + Height.toString() + ")";
			Call(jsFunc);
		}
		
		public static function Console(Msg:String) {
			Call("console.debug('" + Msg + "')");
			trace(Msg);
		}
		
		public static function FacebookInit() {
			
			var jsFunc:String = "setTimeout(FBFlashBridgeInit, 500)";
			Call(jsFunc);
			
			jsFunc = "FBFlashBridgeInit()";
			Call(jsFunc);
		}
		
		private static function Call(jsFunc:String) {
			if (ExternalInterface.available)
				try { ExternalInterface.call(jsFunc); }
				catch (error:Error) { trace(error); }	
			
			//trace("JS: " + jsFunc);
		}
	}
	
}