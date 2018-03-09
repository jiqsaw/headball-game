package HeadCameraSrc
{
	import App.DataManagement;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import HelperControls.TextBox;
	import J.BASE.BaseMovieClip;
	import J.BASE.BaseTextBox;
	import Services.PhpData;
	
	/** @author Feyyaz */
	
	public class SaveScore extends BaseMovieClip
	{
		var txtEmail:TextBox;
		var txtFullName:TextBox;
		var txtGSM:TextBox;
		var mtxtError:TextField;
		
		var php:PhpData;
		
		var TopScore:Number;
		
		public static const SAVESCORE_FINISH:String = "SAVESCORE_FINISH";
		
		public function SaveScore(TopScore:Number) 
		{
			this.TopScore = TopScore;
		}
		
		override protected function Prep():void 
		{
			txtEmail = new TextBox(BaseTextBox.Email, "");
			txtFullName = new TextBox(BaseTextBox.FullName, "");
			txtGSM = new TextBox(BaseTextBox.GSM, "");
			mtxtError = this["txtError"];
			
			mtxtError.text = "";
		}
		
		override protected function AddStage():void 
		{
			addChild(txtEmail);
			addChild(txtFullName);
			addChild(txtGSM);
		}
		
		override protected function Events():void 
		{	
			this["btnOK"].addEventListener(MouseEvent.CLICK, OKClick);
			this["btnOK"].buttonMode = true;
			
			this["btnCancel"].addEventListener(MouseEvent.CLICK, CancelClick);
			this["btnCancel"].buttonMode = true;
			this["btnCancel"].visible = false;
		}
		
		override protected function Load():void 
		{
			this.XY(txtEmail, 300, 261);
			this.XY(txtFullName, 300, 296);
			this.XY(txtGSM, 300, 331);
			
		}
		
		private function CancelClick(e:MouseEvent):void
		{
			
		}			
		
		private function OKClick(e:MouseEvent):void
		{
			if (!txtEmail.IsValid())
				mtxtError.text = "Lütfen geçerli bir email adresi giriniz";
				
			else if (!txtFullName.IsValid())
				mtxtError.text = "Lütfen adınızı ve soyadınızı giriniz";
				
			else if (!txtGSM.IsValid())
				mtxtError.text = "Lütfen cep telefonunuzu doğru giriniz";
				
			else {
				php = new PhpData(SaveScoreResult);
				php.SaveTopScore(txtFullName.Value, txtEmail.Value, txtGSM.Value, this.TopScore);
			}
			
		}
		
		private function SaveScoreResult(e:Event):void
		{
			if (!DataManagement.IsError())
				dispatchEvent(new Event(SAVESCORE_FINISH));
		}
	}
	
}