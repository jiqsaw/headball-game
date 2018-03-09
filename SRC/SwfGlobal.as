package  
{
	import App.Bus;
	import App.SoundControl;
	import flash.display.MovieClip;
	
	/** @author Feyyaz */
	
	public class SwfGlobal 
	{
		public static var gSounds:SoundControl;
		public static var SoundOpen:Boolean = false;
		
		public static var IsHeadCamOpen:Boolean;
		public static var HeadCamTopScore:Number = 512;
		
		public static var GameType:String = "";
		
		public static var ErrorCommand:String;
		
		
		//HTML PARAMETERS
		public static var htmlVarsIP:String = "ip";
		public static var htmlVarsKafaKamerasi:String = "kafakamerasi";
		
		
		//OUT URL
		public static var WandaURL:String = "http://www.wandadigital.com";
		
		
		//GAME
		public static var SEH:Number = 493;
		public static var DefaultHead1:String = "DefaultHot1.png";
		public static var DefaultHead2:String = "DefaultHot2.png";
		public static const AvatarPath = "http://www.ruffles.com.tr/enkafadar/Avatar/";				
		
		
		//SWF EVENTS
		public static const GAME_OPPONENTFINDED:String = "GAME_OPPONENTFINDED";
		public static const GAME_START:String = "GAME_START";
		public static const GAME_READYTOSET:String = "GAME_READYTOSET";
		public static const GAME_POSUPDATE:String = "GAME_POSUPDATE";
		public static const GAME_SETFINISH:String = "GAME_SETFINISH";
		public static const GAME_FINISHED:String = "GAME_FINISHED";
		public static const GAME_EXIT:String = "GAME_EXIT";
		public static const GAME_ROVANSOPPONENTDECLINE:String = "GAME_ROVANSOPPONENTDECLINE";
		public static const GAME_CLOSE_SUBPAGE:String = "GAME_CLOSE_SUBPAGE";
		public static const GAME_MESSAGE:String = "GAME_MESSAGE";
		public static const GAME_ROVANS:String = "GAME_ROVANS";
		
		public static const HEADCAMERA_START:String = "HEADCAMERA_START";
		public static const HEADCAMERA_REMOVE:String = "HEADCAMERA_REMOVE";
		public static const HEADCAMERA_ALLOW:String = "HEADCAMERA_ALLOW";
		public static const HEADCAMERA_DENY:String = "HEADCAMERA_DENY"
		public static const HEADCAMERA_HIGHSCORE:String = "HEADCAMERA_HIGHSCORE";
		public static const HEADCAMERA_OPENEDCAM:String = "HEADCAMERA_OPENEDCAM";			
		
		public function SwfGlobal() 
		{
			
		}		
		
	}
	
}