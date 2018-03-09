package Game 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import com.yigit.helpers.DisplayHelpers;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class MesajMc extends MovieClip
	{
		public function MesajMc(str:String, xPos:Number, yPos:Number) 
		{
			tf.text = str;
			x = xPos;
			y = yPos;
			DisplayHelpers.addContent(GameGlobals.Con, this);
			TweenLite.delayedCall(2, remover);
		}
		
		private function remover():void
		{
			DisplayHelpers.removeContent(GameGlobals.Con, this);
		}
		
	}

}