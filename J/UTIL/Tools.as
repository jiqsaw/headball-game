package J.UTIL 
{
	
	/** @author Feyyaz */
	
	public class Tools 
	{
		
		public function Tools() 
		{
			
		}
		
		public static function print_a(obj, indent = null) {
			if (indent == null) indent = "";
			var out = "";
			for (var item in obj ) {
				if (typeof( obj[item] ) == "object" )
					out += indent+"[" + item + "] => Object\n";
				else
					out += indent+"[" + item + "] => " + obj[item]+"\n";
				out += print_a( obj[item], indent+"   " );
			}
			return out;
		}		
		
		public static function ResizeConstrain(Obj:Object, Size:Number, IsW:Boolean = true) {
			if (!IsW) {
				Obj.width = Obj.width / (Obj.height / Size);
				Obj.height = Size;
			}
			else {
				Obj.height = Obj.height / (Obj.width / Size);
				Obj.width = Size;
			}
		}
		
		public static function GetHtmlVars(target:Object, paramName:String) {
			if ((target != null) && (target.loaderInfo != null)) 
				if (target.loaderInfo.parameters[paramName] != undefined)
					return target.loaderInfo.parameters[paramName];
				
			return "";
		}
		
		public static function GetParamsVar(target:Object, paramName:String) {
			if (target[paramName] != undefined)
				return target[paramName];
				
			return "";
		}		
	}
	
}