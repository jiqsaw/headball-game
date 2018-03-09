package  
{
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class Controls
	{
		public static function scoreUpdate(leftScore:Number, rightScore:Number)
		{
			GameGlobals.SCORE_BOARD.scoreUpdate(leftScore, rightScore);
		}
		
		
		public static function startMatch()
		{
			GameGlobals.COUNT_DOWN.starter();
			GameGlobals.SCORE_BOARD.setReady("left player name", "rightplayername", "leftplayercity", "rightplayercity");
		}
		
		public static function finishMatch()
		{
			GameGlobals.COUNT_DOWN.stoper();
		}
		
		
	}
}