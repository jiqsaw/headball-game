package Screens
{
	import flash.display.MovieClip;
	import J.UTIL.JsHelper;
	
	import J.BASE.BaseMovieClip;
	
	import App.Lib;
	import App.Wording;
	import HelperControls.CallButton;	
	import UserControls.JoinButton;
	
	/** @author Feyyaz */
	public class Join extends BaseMovieClip
	{		
		private var mJuliana:MovieClip;
		
		private var mLogin:JoinButton;
		private var mSign:JoinButton;
		
		private var mClose:CallButton;
		
		public function Join() { JsHelper.GATracker("Katil"); }
		
		override protected function Prep():void 
		{
			mJuliana = new Lib(Lib.JoinJuliana);
			mLogin = new JoinButton(JoinButton.tLogin, Wording.loginTitle);
			mSign = new JoinButton(JoinButton.tSign, Wording.signTitle);
			mClose = new CallButton(CallButton.Close);
		}
		
		override protected function AddStage():void 
		{
			addChild(mJuliana);
			addChild(mLogin);
			addChild(mSign);
			addChild(mClose);
		}
		
		override protected function Load():void 
		{
			this.XY(mJuliana, 270, 50);
			this.XY(mLogin, 105, 140);
			this.XY(mSign, 385, 140);
			this.XY(mClose, 520, 321);
		}
		
	}
	
}