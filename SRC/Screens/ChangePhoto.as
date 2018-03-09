package Screens 
{	
	import App.Global;
	import flash.text.TextField;	
	import J.UTIL.JsHelper;
	import J.UTIL.WebCam;

	import J.BASE.BaseMovieClip;

	import App.Wording;
	import HelperControls.Text;
	import HelperControls.CallButton;
	import HelperControls.ProfileBoxImg;
	import HelperControls.LoadPhotoItem;

	/** @author Feyyaz */

	public class ChangePhoto extends BaseMovieClip
	{
		
		private var mTxtTitle:Text;
		private var mTxtDescription:TextField;
		private var mProfileBoxImg:ProfileBoxImg;
		private var mClose:CallButton;
		
		private var mFacebook:LoadPhotoItem;
		private var mWebCam:LoadPhotoItem;
		private var mPc:LoadPhotoItem;
		private var mDefaultHot:LoadPhotoItem;
		
		//---------------------------------------------------------------------------//
		
		public function ChangePhoto() { JsHelper.GATracker("FotografDegistir"); }
		
		override protected function Prep():void {		
			mTxtTitle = new Text(Wording.changePhotoTitle, Text.TitleSmall);
			mTxtDescription = new Text(Wording.changePhotoDesc, Text.TitleDesc);
			mProfileBoxImg = new ProfileBoxImg(ProfileBoxImg.tChangePhoto);
			mClose = new CallButton(CallButton.Close);
			
			mFacebook = new LoadPhotoItem(LoadPhotoItem.tFacebook, Wording.loadphotoFacebook);			
			mPc = new LoadPhotoItem(LoadPhotoItem.tPc, Wording.loadphotoPc);
			mDefaultHot = new LoadPhotoItem(LoadPhotoItem.tDefaultHot, Wording.loadphotoDefaultHot);
			
			var PhotoImg:String = WebCam.HasCamera() ? LoadPhotoItem.tWebCam : LoadPhotoItem.tNoWebCam;
			mWebCam = new LoadPhotoItem(PhotoImg, Wording.loadphotoWebCam);
			if (!WebCam.HasCamera()) mWebCam.Disable();
		}
		
		override protected function AddStage():void {
			addChild(mProfileBoxImg);
			addChild(mTxtTitle);
			addChild(mTxtDescription);
			addChild(mClose);
			
			addChild(mFacebook);
			addChild(mWebCam);
			addChild(mPc);
			addChild(mDefaultHot);
			
			mProfileBoxImg.rotation = Global.DefaultRotation;
		}
		
		override protected function Events():void { }
		
		override protected function Load():void
		{
			this.XY(mProfileBoxImg, 50, 40)
			this.XY(mTxtTitle, 160, 50)
			this.XY(mTxtDescription, 160, 85)
			this.XY(mClose, 500, 330);
			
			this.XY(mFacebook, 90, 155);
			this.XY(mWebCam, 226, 155);
			this.XY(mPc, 348, 155);
			this.XY(mDefaultHot, 473, 155);
		}	
		
		override protected function Start():void {
			
		}
		
		//---------------------------------------------------------------------------//	
		
	}
	
}