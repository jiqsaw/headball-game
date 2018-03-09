package Game
{
	import App.Session;
	import flash.display.MovieClip;
	import J.UTIL.JsHelper;
	import Services.SFSGlobal;
	
	/** @author Feyyaz */
	
	public class BlueHead extends MovieClip
	{
		
		var mHead:MovieClip;
		public function BlueHead() 
		{
			mHead = this["defHead"];
			if (SFSGlobal.UserSide == SFSGlobal.UserSideLeft) {
				
				if ((Session.sAvatarFileName != SwfGlobal.DefaultHead1) && (Session.sAvatarFileName != SwfGlobal.DefaultHead2))
				{
					mHead.visible = false;
					addChild(GameGlobals.SessionAvatar);
					
					GameGlobals.SessionAvatar.x = -GameGlobals.SessionAvatar.width;
					GameGlobals.SessionAvatar.x += (mHead.width / 2) + 4;
					GameGlobals.SessionAvatar.y = -5;
					
					if ((Session.sAccessoryNo == 2) || (Session.sAccessoryNo == 4))
						GameGlobals.SessionAvatar.x -= 26;
				}
				else if (Session.sAvatarFileName == SwfGlobal.DefaultHead2)
					gotoAndStop(2);
			}
			else if (SFSGlobal.UserSide == SFSGlobal.UserSideRight) {
				
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
					else if (Session.sAvatarFileName == SwfGlobal.DefaultHead1)
						gotoAndStop(2);
				}
			}
			
		}
		
	}
	
}