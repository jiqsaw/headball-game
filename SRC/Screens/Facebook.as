package Screens
{
	import be.wellconsidered.apis.fbbridge.events.FBBridgeEvent;
	import J.UTIL.McUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.display.MovieClip;
	
	import J.BASE.BaseMovieClip;
	import J.UTIL.FacebookHelper;
	import J.UTIL.JsHelper;

	import HelperControls.Paging;
	import UserControls.FacebookPhotoItem;
	import HelperControls.Text;
	import HelperControls.CallButton;
	import HelperControls.DropDownList;
	import HelperControls.DdlItem;
	import App.Wording;
	import App.Lib;
	
	/** @author Feyyaz */
	
	public class Facebook extends BaseMovieClip
	{
		private var mTitle:Text;
		private var mUsersLabel:Text;
		private var mAlbumLabel:Text;
		
		private var mClose:CallButton;
		
		private var mUsers:DropDownList;
		private var mAlbums:DropDownList;
		
		private var FB:FacebookHelper;
		private var FbPhotoItem:FacebookPhotoItem;
		private var PhotoLoader:Loader;
		private var arrAlbumPhotos:Array;		
		private var ItemNo:Number = 0;
		private var arrItems:Array = new Array();
		
		private var mPaging:Paging;
		
		private var LoadingText:Text;
		private var PhotoLoadingProgressText:Text;
		
		var PhotoList:MovieClip;
		
		public function Facebook() {
			FB = new FacebookHelper();					
		}
		
		override protected function Prep():void 
		{
			mTitle = new Text(Wording.facebookTitle, Text.TitleSmall);
			mUsersLabel = new Text(Wording.facebookUserLabel, Text.FormLabel);
			mAlbumLabel = new Text(Wording.facebookAlbumLabel, Text.FormLabel);
			
			mClose = new CallButton(CallButton.Close);
			
			LoadingText = new Text("");
			PhotoLoadingProgressText = new Text("", Text.ErrorMessage);
			
			PhotoList = new MovieClip();
		}
		
		override protected function AddStage():void 
		{			
			addChild(mTitle);
			addChild(mUsersLabel);
			addChild(mAlbumLabel);
			addChild(mClose);
			addChild(LoadingText);
			addChild(PhotoLoadingProgressText);
		}
		
		override protected function Load():void 
		{
			this.XY(mTitle, 66, 60);
			this.XY(mUsersLabel, 140, 100);
			this.XY(mAlbumLabel, 140, 134);
			
			this.XY(mClose, 500, 330);
			
			HideLoading();
			ShowLoading(Wording.Loading, 240, mUsersLabel.y);
		}	
		
		override protected function Start():void 
		{
			FB.addEventListener(FBBridgeEvent.USER_FRIENDS, GetUserFriendsLoaded);
			FB.GetUserFriends();
		}
		
		private function GetUserFriendsLoaded(e:FBBridgeEvent):void
		{
			BindUsers();
		}
		
		private function BindUsers() {
			HideLoading();
			mUsers = new DropDownList(Wording.facebookUserLabel, FB.arrUserFriends, "uid", "name");
			mUsers.addEventListener(DropDownList.onChange, GetAlbums);			
			addChild(mUsers);
			this.XY(mUsers, 240, mUsersLabel.y);
			mUsers.SelectFirstItem();			
		}
		
		private function GetAlbums(e:Event):void 
		{
			try { removeChild(mAlbums); }
			catch (e:Error) { }			
			
			ShowLoading(Wording.Loading, 240, mAlbumLabel.y);			
			FacebookHelper.fbSession.addEventListener(FBBridgeEvent.ALBUMS_GET, AlbumsLoaded);
			FacebookHelper.fbSession.getUserAlbums(Number(mUsers.SelectedValue));
		}
		
		private function AlbumsLoaded(e:FBBridgeEvent):void
		{
			if (e.data.length > 0) {
				FB.arrAlbums = e.data;
				mAlbums = new DropDownList(Wording.facebookAlbumLabel, FB.arrAlbums, "aid", "name");
				
				addChild(mAlbums);
				mAlbums.addEventListener(DropDownList.onChange, GetAlbumPhotos);						
				this.XY(mAlbums, 240, mAlbumLabel.y);
				//mAlbums.SelectFirstItem();
				
				swapChildren(mUsers, mAlbums);
			} 
			else {
				try { removeChild(mAlbums); }
				catch (e:Error) { }
				
				ShowLoading(Wording.facebookAlbumsError, 240, mAlbumLabel.y);
			}
			
		}
		
		private function GetAlbumPhotos(e:Event):void 
		{
			HideLoading();
			ShowLoading(Wording.facebookPhotosLoading, 90, 180);			
			var AlbumID:String = mAlbums.SelectedValue;
				
			//FacebookHelper.fbSession.getAlbumPhotos("3377183504113676373");
			FacebookHelper.fbSession.addEventListener(FBBridgeEvent.PHOTOS_ALBUM_GET, AlbumPhotosLoaded);
			FacebookHelper.fbSession.getAlbumPhotos(AlbumID);
		}
		
		private function AlbumPhotosLoaded(e:FBBridgeEvent)
		{
			try 
			{
				arrAlbumPhotos = e.data;
				McUtil.McClear(PhotoList);
				GetPhoto();
				this.XY(PhotoLoadingProgressText, 90, 220);
				PhotoLoadingProgressText.visible = true;
			}
			catch (e:Error)
			{
				HideLoading();
				ShowLoading(Wording.facebookPhotoError, 90, 180);
			}
		}
		
		
		private function GetPhoto() {
			try
			{
				PhotoLoader = new Loader();
				var context:LoaderContext = new LoaderContext();
				context.checkPolicyFile = true;			
				PhotoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, PhotoLoaded);
				PhotoLoader.load(new URLRequest(arrAlbumPhotos[ItemNo].src_small), context);
				ShowPhotoLoadingProgress();
			}
			catch (e:Error)
			{
				JsHelper.Console(e.toString());
			}
		}
		
		private function PhotoLoaded(e:Event):void
		{
			var bmpData:BitmapData = new BitmapData(50, 50);
			bmpData.draw(PhotoLoader);
			var Photo:Bitmap = new Bitmap(bmpData, "auto", true);
			
			FbPhotoItem = new FacebookPhotoItem(Photo, arrAlbumPhotos[ItemNo].src_big);
			arrItems[ItemNo] = FbPhotoItem;
			
			ItemNo++;
			
			if (ItemNo < arrAlbumPhotos.length)
				GetPhoto();
			else
				GeneratePaging();
		}						
		
		private function GeneratePaging():void
		{			
			HideLoading();
			
			mPaging = new Paging();
			addChild(mPaging);
			this.XY(mPaging, 88, 310);
			
			mPaging.addEventListener(mPaging.REPEATING, onRepeating);			
			
			addChild(PhotoList);
			this.XY(PhotoList, 90, 180);
			
			mPaging.Generate(PhotoList, arrItems.length, 16, 8, 61, 61);						
		}
		
		private function onRepeating(e:Event):void
		{
			mPaging.Item = arrItems[mPaging.ShowIndex];
		}
		
		private function ShowLoading(ErrorMessage:String, posX:Number, posY:Number) {
			LoadingText.text = ErrorMessage;
			LoadingText.visible = true;
			this.XY(LoadingText, posX, posY);
		}
		
		private function ShowPhotoLoadingProgress() {			
			PhotoLoadingProgressText.text = ItemNo.toString() + " / " + arrAlbumPhotos.length.toString();
		}
		
		private function HideLoading() {
			LoadingText.visible = PhotoLoadingProgressText.visible = false;			
		}
		
	}
	
}