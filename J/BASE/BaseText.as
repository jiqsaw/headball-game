package J.BASE
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import J.UTIL.Filter;
	
	/** @author Feyyaz **/

	public class BaseText extends TextField
	{
		
		protected var FontFamily:String;
		
		public function BaseText() { 
			addEventListener(Event.ADDED_TO_STAGE, Init);			
		}
		
		private function Init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		protected function Create(Color:uint, Size:Number, Align:String = TextFormatAlign.LEFT, Type:String = TextFieldType.DYNAMIC, Leading:Number = -2, LetterSpacing:Number = 0) {
			
            this.autoSize = (Type == TextFieldType.INPUT || Align == TextFormatAlign.RIGHT) ? TextFieldAutoSize.NONE : TextFieldAutoSize.LEFT;
			this.type = Type;
			this.antiAliasType = AntiAliasType.NORMAL;
			
            this.border = false;
			this.wordWrap = false;
			this.multiline = true;
			this.background = (Type == TextFieldType.INPUT);
 			this.mouseEnabled = (Type == TextFieldType.INPUT);
			this.selectable = (Type == TextFieldType.INPUT);
			
			var TF:TextFormat = new TextFormat();
            TF.font = FontFamily;
            TF.color = Color;
            TF.size = Size;
			TF.underline = false;
			TF.align = Align;
			TF.indent = (Type == TextFieldType.INPUT) ? 5 : 0;
			TF.leading = Leading;
			TF.letterSpacing = -1;// LetterSpacing;
			
            this.defaultTextFormat = TF;
			this.embedFonts = true;
		}
		
		protected function Stroke(Color:uint):DropShadowFilter {
			
			return Filter.Stroke(Color);
		}		
	}
	
}