package Screens
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.TextField;		
	import flash.ui.Keyboard;
	import J.UTIL.Tools;
	import Services.SFSGlobal;

	
	import J.BASE.BaseTextBox;
	import J.UTIL.Validation;
	import J.BASE.BaseMovieClip;
	import J.UTIL.JsHelper;

	import App.Wording;
	import App.Session;
	import App.Global;
	import App.Bus;
	import App.Lib;
	import App.DataManagement;
	
	import HelperControls.Link;
	import HelperControls.CallButton;
	import HelperControls.TextBox;
	import HelperControls.Text;		
	
	import Services.PhpData;
	import Services.SFSClient;
	
	/** @author Feyyaz */
	
	public class Login extends BaseMovieClip
	{	
		private var mTxtLoginTitle:Text;
		
		private var mTxtEmailTitle:Text;
		private var mTxtPasswordTitle:Text;
		
		private var mTxtEmail:TextBox;
		private var mTxtPassword:TextBox;
		
		private var mLogin:CallButton;
		private var mClose:CallButton;
		
		private var mXEmail:MovieClip;
		private var mXPass:MovieClip;
		
		private var mSendPassword:Link;
		
		private var mTxtSuccess:Text;
		private var mTxtError:Text;
		private var mMailInitial:String = "";
		
		private var php:PhpData;
		
		private var LoginSO:SharedObject;
		
		public function Login() { JsHelper.GATracker("UyeGiris"); }
		
		override protected function Prep():void 
		{
			LoginSO = SharedObject.getLocal("LoginData");
			GetCookie();
			
			mTxtEmail = new TextBox(BaseTextBox.Email, mMailInitial);
			mTxtPassword = new TextBox(BaseTextBox.PasswordEasy);
			
			mTxtLoginTitle = new Text(Wording.loginTitle, Text.Title);
			mTxtEmailTitle = new Text(Wording.formEmail, Text.FormLabel);
			mTxtPasswordTitle = new Text(Wording.formPassword, Text.FormLabel);
			
			mSendPassword = new Link(Wording.SendPassLink);
			
			mLogin = new CallButton(CallButton.Login);
			mClose = new CallButton(CallButton.Close);
			
			mXEmail = new Lib(Lib.X);
			mXPass = new Lib(Lib.X);
			
			mTxtError = new Text("", Text.ErrorMessage, 338, 30);
			mTxtSuccess = new Text("", Text.SuccessMessage, 338, 30);
		}
		
		override protected function AddStage():void 
		{
			addChild(mTxtLoginTitle);
			addChild(mTxtEmailTitle);
			addChild(mTxtPasswordTitle);
			addChild(mTxtEmail);
			addChild(mTxtPassword);
			addChild(mLogin);
			addChild(mClose);
			
			addChild(mSendPassword);
			
			addChild(mXEmail);
			addChild(mXPass);
			
			addChild(mTxtError);
			addChild(mTxtSuccess);
		}
		
		override protected function Events():void {
			this.Click(mLogin, LoginClick);
			this.Click(mSendPassword, SendPassClick);
			
			mTxtEmail.tabIndex = 0;
			mTxtPassword.tabIndex = 1;
			mLogin.tabIndex = 2;
			mTxtPassword.addEventListener(KeyboardEvent.KEY_DOWN, PasswordKeyDownHandler);
		}
		
		private function PasswordKeyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER)
				LoginClick(null);
		}
		
		override protected function Load():void 
		{
			this.XY(mTxtLoginTitle, 145, 66);
			
			this.XY(mTxtEmailTitle, 150, 142);
			this.XY(mTxtPasswordTitle, 150, 182);
			
			this.XY(mTxtEmail, 222 , mTxtEmailTitle.y);
			this.XY(mTxtPassword, 222 , mTxtPasswordTitle.y);
			
			this.XY(mXEmail, 465, 142);
			this.XY(mXPass, 465, 182);
			
			this.XY(mTxtSuccess, 161, 270);
			this.XY(mTxtError, 161, 270);
			
			this.XY(mSendPassword, 337, 235);
			
			this.XY(mLogin, 380, 321);
			this.XY(mClose, 520, 321);
			
			mXEmail.visible = false;
			mXPass.visible = false;
			mTxtError.visible = false;
			mTxtSuccess.visible = false;
			
			//**************
			//mTxtEmail.Value = "feyyaz.ucakan@wandadigital.com";
			//mTxtPassword.Value = "2";
			//***************
		}
		
		//---------------------------------------------------------------------------//	
		
		private function SendPassClick(e:MouseEvent):void
		{
			mTxtError.visible = mTxtSuccess.visible = false;
			if (!mTxtEmail.IsValid()) 
				mXEmail.visible = true;
			else {			
				var Email:String = mTxtEmail.Value;			
				
				php = new PhpData(SendPasswordResult);
				php.SendPassword(Email);
				
				mXEmail.visible = false;
			}
		}
		
		private function SendPasswordResult(e:Event) {			
			switch (DataManagement.ResultType())
			{
				case DataManagement.rSuccess: //Başarılı
					mTxtSuccess.text = Wording.succSendPassword;
					mTxtSuccess.visible = true;
				break;
				
				case DataManagement.rNoUser: //Üye Bulunamadı
					mTxtError.text = Wording.errLoginNoUser;
					mTxtError.visible = true;
				break;
				
				case DataManagement.rError: //Şifre Gönderilemedi
					mTxtError.text = Wording.errNoSendPass;
					mTxtError.visible = true;
				break;
			}			
		}
		
		function LoginClick(e:MouseEvent):void
		{
			mTxtError.visible = mTxtSuccess.visible = false;
			mXEmail.visible = !mTxtEmail.IsValid();
			mXPass.visible = !mTxtPassword.IsValid();
			
			if (mTxtEmail.IsValid() && mTxtPassword.IsValid())
			{
				SetSO(mTxtEmail.Value);
				
				php = new PhpData(LoginResult);
				php.Login(mTxtEmail.Value, mTxtPassword.Value);
			}
		}		
		
		private function LoginResult(e:Event):void
		{
			if (DataManagement.LoginManagement() == DataManagement.rNoUser)
				ShowError(Wording.errLoginNoUser);
			else {
				if (Session.sIsLogin) {
					
					SetUserIP();
					Bus.CloseSubPage();
					Bus.GetPage(new Profile());
				}
			}
		}
		
		private function SetUserIP():void
		{
			Session.IP = Tools.GetHtmlVars(SwfCom.L, SwfGlobal.htmlVarsIP);
		}		
		
		private function ShowError(ErrorMessage:String) {
			mTxtError.text = ErrorMessage;
			mTxtError.visible = true;
		}
		
		private function HideError() {
			mTxtError.text = "";
			mTxtError.visible = false;			
		}
		
		private function GetCookie():void
		{
			if (LoginSO.data.Email != null)
				this.mMailInitial = LoginSO.data.Email;
		}
		
		private function SetSO(Email:String) {
			LoginSO.data.Email = mTxtEmail.Value;
			LoginSO.flush();
		}
	}
	
}