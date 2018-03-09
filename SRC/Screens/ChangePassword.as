package Screens 
{	
	import App.DataManagement;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.UTIL.JsHelper;
	import Services.PhpData;
	
	import J.BASE.BaseTextBox;	
	import J.BASE.BaseMovieClip;

	import App.Bus;
	import App.Global;
	import App.Session;
	import App.Wording;
	import App.Lib;
	import Screens.ChangePassword;
	import HelperControls.Text;
	import HelperControls.TextBox;
	import HelperControls.CallButton;
	
	/** @author Feyyaz */

	public class ChangePassword extends BaseMovieClip
	{
		private var mTxtChangePasswordTitle:Text;
		private var mTxtOldPasswordTitle:Text;
		private var mTxtNewPasswordTitle:Text;
		
		private var mTxtOldPassword:TextBox;
		private var mTxtNewPassword:TextBox;
		
		private var mChange:CallButton;
		private var mClose:CallButton;
		
		private var mTxtError:Text;
		
		private var mXOldPass:MovieClip;
		private var mXNewPass:MovieClip;
		
		//---------------------------------------------------------------------------//		
		
		public function ChangePassword() { JsHelper.GATracker("SifreDegistir"); }
		
		override protected function Prep():void {
			
			mTxtChangePasswordTitle = new Text(Wording.changepassTitle, Text.Title);
			mTxtOldPasswordTitle = new Text(Wording.formOldPassword, Text.FormLabel);
			mTxtNewPasswordTitle = new Text(Wording.formNewPassword, Text.FormLabel);
			
			mTxtOldPassword = new TextBox(BaseTextBox.PasswordEasy);
			mTxtNewPassword = new TextBox(BaseTextBox.PasswordEasy);
			
			mTxtError = new Text("", Text.ErrorMessage);
			
			mChange = new CallButton(CallButton.Change);
			mClose = new CallButton(CallButton.Close);
			
			mXOldPass = new Lib(Lib.X);
			mXNewPass = new Lib(Lib.X);
		}
		
		override protected function AddStage():void {
			
			addChild(mTxtChangePasswordTitle);
			addChild(mTxtOldPasswordTitle);
			addChild(mTxtNewPasswordTitle);
			
			addChild(mTxtOldPassword);
			addChild(mTxtNewPassword);
			
			addChild(mTxtError);
			
			addChild(mChange);
			addChild(mClose);
			
			addChild(mXOldPass);
			addChild(mXNewPass);
		}
		
		override protected function Events():void {
			mChange.addEventListener(MouseEvent.CLICK, ChangeClick);
		}
		
		override protected function Load():void
		{	
			this.XY(mTxtChangePasswordTitle, 130, 72);
			this.XY(mTxtOldPasswordTitle, 150, 152);
			this.XY(mTxtNewPasswordTitle, 150, 192);
			
			this.XY(mTxtOldPassword, 274, 152);
			this.XY(mTxtNewPassword, 274, 192);
			
			this.XY(mTxtError, 163, 253);
			
			this.XY(mChange, 371, 321);
			this.XY(mClose, 520, 321);
			
			this.XY(mXOldPass, 508, 152);
			this.XY(mXNewPass, 508, 192);			
			
			mTxtError.visible = false;
			mXOldPass.visible = false;
			mXNewPass.visible = false;
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//
		
		function ChangeClick(e:MouseEvent):void
		{	
			mXOldPass.visible = !mTxtOldPassword.IsValid();
			mXNewPass.visible = !mTxtNewPassword.IsValid();
			
			if (mTxtOldPassword.IsValid() && mTxtNewPassword.IsValid())
			{
				if (mTxtOldPassword.Value == mTxtNewPassword.Value)
					ShowError(Wording.errChangePassLike);
					
				else if (mTxtOldPassword.Value != Session.sPass)
					ShowError(Wording.errWrongPass);
					
				else
					ChagePasswordDB();
			}
		}
		
		function ChagePasswordDB() {			
			var php:PhpData = new PhpData(ChangePasswordResult);
			php.ChangePassword(mTxtNewPassword.Value);
		}
		
		private function ChangePasswordResult(e:Event):void
		{
			if (!DataManagement.IsError()) {
				Session.sPass = mTxtNewPassword.Value;
				HideError();
				Success();			
			}
			else
				ShowError(Wording.errNoChangePass);
		}
		
		private function Success():void
		{
			removeChild(mTxtOldPassword);
			removeChild(mTxtOldPasswordTitle);
			removeChild(mTxtNewPassword);
			removeChild(mTxtNewPasswordTitle);
			removeChild(mChange);
			
			var mSuccessText = new Text(Wording.changepassSuccess, Text.SuccessMessage);
			addChild(mSuccessText);
			this.XY(mSuccessText, 160, 180);
		}		
		
		private function ShowError(ErrorMessage:String) {
			mTxtError.text = ErrorMessage;
			mTxtError.visible = true;
		}
		
		private function HideError() {
			mTxtError.text = "";
			mTxtError.visible = false;			
		}		
	}
	
}