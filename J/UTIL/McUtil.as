package J.UTIL
{
	import flash.display.MovieClip;
	
	/** @author Feyyaz */
	
	public class McUtil 
	{
		
		public function McUtil() { }
		
		public static function McClear(TargetMc:MovieClip){
			while(TargetMc.numChildren > 0){
				TargetMc.removeChildAt(TargetMc.numChildren - 1);
			}
		}
		
	}
	
}