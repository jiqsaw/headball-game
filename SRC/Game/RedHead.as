package Game
{
	import App.Session;
	import flash.display.MovieClip;
	import J.UTIL.JsHelper;
	import Services.SFSGlobal;
	
	/** @author Feyyaz */
	
	public class RedHead extends MovieClip
	{
		
		var mHead:MovieClip;
		public function RedHead() 
		{
			mHead = this["defHead"];
			
			if (SFSGlobal.UserSide == SFSGlobal.UserSideRight) {				
				
				if ((Session.sAvatarFileName != SwfGlobal.DefaultHead1) && (Session.sAvatarFileName != SwfGlobal.DefaultHead2))
				{
					mHead.visible = false;
					addChild(GameGlobals.SessionAvatar);
					GameGlobals.SessionAvatar.x = -GameGlobals.SessionAvatar.width;
					GameGlobals.SessionAvatar.x += (mHead.width / 2) + 20;
					GameGlobals.SessionAvatar.y = -3;
					
					if ((Session.sAccessoryNo == 2) || (Session.sAccessoryNo == 4))
						GameGlobals.SessionAvatar.x -= 26;					
				}
				else if (Session.sAvatarFileName == SwfGlobal.DefaultHead1)
					gotoAndStop(2);
			}
			else if (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) {
				
				if (!SFSGlobal.IsBotOpponent) {
					if ((SFSGlobal.OpponentHeadFileName != SwfGlobal.DefaultHead1) && (SFSGlobal.OpponentHeadFileName != SwfGlobal.DefaultHead2))
					{
						mHead.visible = false;
						addChild(SFSGlobal.OpponentHead);
						SFSGlobal.OpponentHead.x = -SFSGlobal.OpponentHead.width;
						SFSGlobal.OpponentHead.x += 90;
						SFSGlobal.OpponentHead.y = -5;
						
						if ((Session.sAccessoryNo == 2) || (Session.sAccessoryNo == 4))
							GameGlobals.SessionAvatar.x -= 26;						
					}
					else if (Session.sAvatarFileName == SwfGlobal.DefaultHead2)
						gotoAndStop(2);
				}
				else if (Session.sAvatarFileName == SwfGlobal.DefaultHead2)
					gotoAndStop(2);
			}
			
		}
		
	}
	
}