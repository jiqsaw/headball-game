package com.parsera.utils
{
	import com.parsera.security.Secure;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	public class Utils
	{
		
		public static function findArrayIndex(arr:Array, data:Object):Number {
			var len:Number = arr.length;
			for(var i:Number = 0; i<len; i++) {
				if(arr[i] == data) {
				return i;
				}
			}
			return -1;
		}
		
		
		/* Gonderilen katari boolean a cevirir */
		public static function convertBoolean(value:String):Boolean {
			return value=="true"?true:false;
		}
		
		/* Gonderilen katari unsigned integer a cevirir */
		public static function convertUint(value:String):uint {
			return uint(value);
		}
		
		/* Gonderilen katari integer a cevirir */
		public static function convertInt(value:String):uint {
			return int(value);
		}
		
		/* Gonderilen zamani (ms) formatlayip geri verir */
		public static function formatTime(time:int):String {
			var minute:int = Math.floor(time / 60000);
			var second:int = Math.floor(time / 1000) % 60;
			var minute_str:String = minute.toString();
			var second_str:String = second.toString();
			minute_str = (minute_str.length == 2) ? minute_str : "0" + minute_str;
			second_str = (second_str.length == 2) ? second_str : "0" + second_str;
			return minute_str + ":" + second_str;
		}
		
		public static function getLoadVars(value:String):Object {
			var arr:Array = value.split("&");
			var obj:Object = new Object();
			for (var i:int = 0; i < arr.length; i++) {
				var arr_in:Array = arr[i].split("=");
				obj[arr_in[0]] = arr_in[1];
			}
			return obj;
		}
		
		public static function generateGUID():String {
			return Secure.calcMD5(getTimer() + "");
		}
		
		public static function formatter(text:String, ... args):String {
			if(text == null || text.length <= 0) {
				return null;
			}
			
			for(var i:int = 0; i<args.length; i++) {
				var pattern:RegExp = new RegExp("\\{"+i+"\\}", "g");
				text = text.replace(pattern, args[i]);
			}
			
			return text;
			
		}
		
		public static function openLink(url:String):void {
			try {
				var request:URLRequest = new URLRequest(url);
                navigateToURL(request, "_blank");
            }
            catch (e:Error) {
            }
		}
		
		public static function setHighestDepth(base:DisplayObjectContainer, item:DisplayObject):void {
			base.setChildIndex(item, base.numChildren - 1);
		}
		
		public static function setEnabled(item:MovieClip, enabled:Boolean):void {
			item.enabled = enabled;
			item.mouseEnabled = enabled;
			item.alpha = enabled ? 1 : .4;
		}
		
	}
}