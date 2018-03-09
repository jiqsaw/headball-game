package UserControls 
{	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import J.BASE.BaseMovieClip;

	import HelperControls.ShareIconItem;
	
	/** @author Feyyaz */

	public class ShareIcons extends BaseMovieClip
	{
		private var mFacebook:ShareIconItem;
		private var mTwitter:ShareIconItem;
		private var mFriendFeed:ShareIconItem;
		
		//---------------------------------------------------------------------------//
		
		public function ShareIcons() { trace("Loaded Share Icons"); }
		
		override protected function Prep():void 
		{
			mFacebook = new ShareIconItem(ShareIconItem.facebook);
			mTwitter = new ShareIconItem(ShareIconItem.twitter);
			mFriendFeed = new ShareIconItem(ShareIconItem.friendfeed);
		}
		
		override protected function AddStage():void { 
			addChild(mFacebook);
			addChild(mTwitter);
			addChild(mFriendFeed);
		}		
		
		override protected function Events():void { }		
		override protected function Load():void { 
			var xPos:Number = 30;
			mFacebook.x = 0;
			mTwitter.x = xPos;
			mFriendFeed.x = xPos * 2;
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//
		
		
	}
	
}