package HelperControls 
{	
	import flash.display.Sprite;
	
	import J.BASE.BaseTextBox;

	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class TextBox extends BaseTextBox
	{
		private var mText:Text;
		private var InitialText:String;
		
		//---------------------------------------------------------------------------//
		
		public function TextBox(ItemType:String, InitialText:String = "") { 
			this.ItemType = ItemType;
			this.InitialText = InitialText;
		}
		
		override protected function Prep():void {
			CreateTextField();
		}
		
		private function CreateTextField():void
		{
			mText = new Text(InitialText, Text.InputText);
			addChild(mText);
			this.mInputText = mText;
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//
		
	}
	
}