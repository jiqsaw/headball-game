package Screens 
{				
	import App.DataManagement;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;	
	import flash.ui.Keyboard;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import J.UTIL.Colors;
	import Services.PhpData;
	
	import J.UTIL.JsHelper;	
	import J.BASE.BaseTextBox;
	import J.UTIL.Validation;
	import J.UTIL.XmlHelper;
	import J.BASE.BaseMovieClip;

	import App.Wording;
	import App.Session;
	import App.Global;
	import App.Bus;
	import App.Lib;
	import HelperControls.DropDownList;
	import HelperControls.DdlItem;	
	import HelperControls.CallButton;
	import HelperControls.CheckBox;
	import HelperControls.TextBox;
	import HelperControls.Text;
	import HelperControls.Link;
	import Screens.Profile;
	
	/** @author Feyyaz */

	public class SignUp extends BaseMovieClip
	{			
		private var mchConditions:CheckBox;
		
		private var mSave:CallButton;
		private var mClose:CallButton;
		
		private var mTxtGirisYapTitle:Text;
		
		private var mTxtFullNameTitle:Text;
		private var mTxtCityTitle:Text;
		private var mTxtEmailTitle:Text;
		private var mTxtPasswordTitle:Text;
		private var mTxtConditionsLink:Link;
		private var mTxtConditionsTitle:Text;
		
		private var mTxtFullName:TextBox;
		private var mCity:DropDownList;
		private var mTxtEmail:TextBox;
		private var mTxtPassword:TextBox;		
		
		private var mTxtError:Text;
		private var mTxtSuccess:Text;
		
		private var mXFullName:MovieClip;
		private var mXCity:MovieClip;	
		private var mXEmail:MovieClip;
		private var mXPass:MovieClip;
		
		//---------------------------------------------------------------------------//
		
		public function SignUp() { JsHelper.GATracker("UyelikFormu"); }
		
		override protected function Prep():void {					
			
			mchConditions = new CheckBox();
			mSave = new CallButton(CallButton.Save);
			mClose = new CallButton(CallButton.Close);
			
			mTxtFullName = new TextBox(BaseTextBox.FullName);			
			mTxtEmail = new TextBox(BaseTextBox.Email);
			mTxtPassword = new TextBox(BaseTextBox.PasswordEasy);			
			
			mTxtGirisYapTitle = new Text(Wording.signTitle, Text.Title);
			
			mTxtFullNameTitle = new Text(Wording.formFullName, Text.FormLabel);
			mTxtCityTitle = new Text(Wording.formCity, Text.FormLabel);
			mTxtEmailTitle = new Text(Wording.formEmail, Text.FormLabel);
			mTxtPasswordTitle = new Text(Wording.formPassword, Text.FormLabel);
			mTxtConditionsLink = new Link(Wording.formConditionsLink, 20, Text.ErrorMessage);
			mTxtConditionsTitle = new Text(Wording.formConditions, Text.FormLabel);
			
			mTxtError = new Text("", Text.ErrorMessage, 338, 50);
			mTxtSuccess = new Text("", Text.SuccessMessage, 338, 30);
			
			mXFullName = new Lib(Lib.X);
			mXCity = new Lib(Lib.X);
			mXEmail = new Lib(Lib.X);
			mXPass = new Lib(Lib.X);
		}
		
		override protected function AddStage():void {
			addChild(mTxtGirisYapTitle);
			
			addChild(mTxtFullNameTitle);
			addChild(mTxtCityTitle);
			addChild(mTxtEmailTitle);
			addChild(mTxtPasswordTitle);
			addChild(mTxtConditionsLink);
			addChild(mTxtConditionsTitle);
			
			addChild(mTxtFullName);
			addChild(mTxtEmail);
			addChild(mTxtPassword);
			addChild(mchConditions);
			
			addChild(mTxtError);
			addChild(mTxtSuccess);
			
			addChild(mSave);
			addChild(mClose);
			
			addChild(mXFullName);
			addChild(mXCity);
			addChild(mXEmail);
			addChild(mXPass);					
		}
		
		override protected function Events():void {
			this.Click(mSave, SaveClick);
			this.LoadFile(CitiesLoaded, Lib.Cities);
			this.Click(mTxtConditionsLink, ConditionsClick);
			
			mTxtFullName.tabIndex = 0;			
			mTxtEmail.tabIndex = 2;
			mTxtPassword.tabIndex = 3;
			mTxtPassword.addEventListener(KeyboardEvent.KEY_DOWN, PasswordKeyDownHandler);			
		}
		
		private function PasswordKeyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.ENTER)
				SaveClick(null);
		}
		
		override protected function Load():void
		{			
			this.XY(mTxtGirisYapTitle, 145, 46);
			
			this.XY(mTxtFullNameTitle, 150, 100);
			this.XY(mTxtCityTitle, 150, 135);
			this.XY(mTxtEmailTitle, 150, 170);
			this.XY(mTxtPasswordTitle, 150, 205);
			this.XY(mTxtConditionsLink, 185, 256);
			this.XY(mTxtConditionsTitle, mTxtConditionsLink.x + 110, 252);
			
			this.XY(mTxtFullName, 240, mTxtFullNameTitle.y);			
			this.XY(mTxtEmail, 240, mTxtEmailTitle.y);
			this.XY(mTxtPassword, 240, mTxtPasswordTitle.y);
			this.XY(mchConditions, 152, mTxtConditionsTitle.y);
			
			this.XY(mTxtSuccess, 161, 287);
			this.XY(mTxtError, 161, 287);
			
			this.XY(mSave, 380, 321);
			this.XY(mClose, 520, 321);
			
			this.XY(mXFullName, 490, mTxtFullNameTitle.y);
			this.XY(mXCity, 490, mTxtCityTitle.y);
			this.XY(mXEmail, 490, mTxtEmailTitle.y);
			this.XY(mXPass, 490, mTxtPasswordTitle.y);
			
			mTxtError.visible = false;
			mXFullName.visible = false;
			mXCity.visible = false;
			mXEmail.visible = false;
			mXPass.visible = false;
			
			mchConditions.Check();
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//	
		
		private function CitiesLoaded(e:Event):void
		{					
			var Items:Array = XmlHelper.FirstNodes(new XML(e.target.data));
			mCity = new DropDownList(Wording.ddlCityInitial, XmlHelper.ConvertAttributesToObject(Items), "ID", "CITYNAME");
			addChild(mCity);
			this.XY(mCity, 239, mTxtCityTitle.y);
			mCity.tabIndex = 1;
		}
		
		private function ConditionsClick(e:MouseEvent):void
		{
			JsHelper.GATracker("KatilimKosullari");
			JsHelper.Popup(Lib.ConditionsPopup, 450, 600);						
		}		
		
		var php:PhpData;
		function SaveClick(e:MouseEvent):void
		{
			mTxtError.visible = mTxtSuccess.visible = false;
			
			mXFullName.visible = !mTxtFullName.IsValid();
			mXCity.visible = !mCity.IsValid();
			mXEmail.visible = !mTxtEmail.IsValid();
			mXPass.visible = !mTxtPassword.IsValid();
			
			if (!mchConditions.Checked) 
				ShowError(Wording.errConditionsCheck);
			
			if  (
					mTxtFullName.IsValid() &&
					mCity.IsValid() &&
					mTxtEmail.IsValid() &&
					mTxtPassword.IsValid() &&
					mchConditions.Checked
				)
			{				
				var FullName:String = mTxtFullName.Value;
				var City:Number = Number(mCity.SelectedValue);
				var Email:String = mTxtEmail.Value;
				var Password:String = mTxtPassword.Value;
				
				php = new PhpData(RegisterResult);
				php.Register(Email, Password, FullName, City);			
			}
		}
		
		private function RegisterResult(e:Event):void
		{
			switch (DataManagement.ResultType()) 
			{
				case DataManagement.rSuccess: //Başarılı				
					php = new PhpData(LoginResult);
					php.Login(mTxtEmail.Value, mTxtPassword.Value); //Login
				break;
				
				case DataManagement.rHasUser: //Kayıtlı Email
					ShowError(Wording.errHasUser);
				break;
				
				case DataManagement.rError: //Kayıt Edilmedi
					ShowError(Wording.errNoSignUp);
				break;				
			}			
		}
		
		private function LoginResult(e:Event) {
			if (DataManagement.LoginManagement() == DataManagement.rSuccess) {
				Bus.CloseSubPage();
				Bus.GetPage(new Profile());
			}
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