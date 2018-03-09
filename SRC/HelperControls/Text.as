package HelperControls 
{	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	
	import J.BASE.BaseText;
	import J.UTIL.Colors;
	
	/** @author Feyyaz */

	public class Text extends BaseText
	{				
		public static const Custom:String = "Custom";
		public static const LongText:String = "LongText";
		public static const Links:String = "Links";
		public static const LinkDesc:String = "LinkDesc";
		public static const FormLabel:String = "FormLabel";
		public static const JoinButton:String = "JoinButton";
		public static const TitlePage:String = "TitlePage";
		public static const Title:String = "Title";		
		public static const TitleSmall:String = "TitleSmall";
		public static const TitleWhite:String = "TitleWhite";
		public static const TitleBlack:String = "TitleBlack";
		public static const TitleDesc:String = "TitleDesc";
		public static const ErrorMessage:String = "ErrorMessage";
		public static const SuccessMessage:String = "SuccessMessage";
		public static const ProfileText:String = "ProfileText";
		public static const ProfileValue:String = "ProfileValue";
		public static const BlueLabel:String = "BlueLabel";
		public static const ListHead:String = "ListHead";
		public static const List:String = "List";
		public static const Desc:String = "Desc";
		public static const Button:String = "Button";
		public static const matchUser:String = "matchUser";
		public static const matchHScore:String = "matchHScore";
		public static const matchAScore:String = "matchAScore";
		public static const WinnerTitles:String = "WinnerTitles";
		
		public static const ddlItem:String = "ddlItem";
		
		public static const InputText:String = "InputText";
		
		private static const DefaultRotation:Number = -3;
		
		private var ItemType:String = "";
		
		public function Text(Value:String, ItemType:String = "Custom", Color:uint = 0xFFFFFF, Size:Number = 24, W:Number = 0, Align:String = TextFormatAlign.LEFT, Leading:Number = -2) 
		{
			var myFont:DefaultFont = new DefaultFont();
			this.FontFamily = myFont.fontName;
			
			switch (ItemType) 
			{
				case Custom:
					this.Create(Color, Size, Align);
				break;
				
				case LongText:
					this.Create(Color, Size, Align, TextFieldType.DYNAMIC, -13, -0.5);
				break;
				
				case Links:
					var C:uint = (Color != Colors.White) ? Color : Colors.White;
					this.Create(C, Size);
					this.filters = new Array(this.Stroke(Colors.Black), this.Stroke(Colors.White));
				break;
				
				case LinkDesc:
					this.Create(Colors.Black, 17, TextFormatAlign.CENTER);
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case Button:
					this.Create(Colors.White, 28, TextFormatAlign.CENTER);
					this.filters = new Array(this.Stroke(Colors.Black), this.Stroke(Colors.Black));
				break;				
				
				case FormLabel:
					this.Create(Colors.Blue, Size);
					this.filters = new Array(this.Stroke(Colors.White));					
				break;
				
				case JoinButton:
					this.Create(Colors.Red, 36);
					this.rotation = DefaultRotation;
				break;
				
				case TitlePage:
					this.Create(Colors.White, 36);
					this.filters = new Array(this.Stroke(Colors.Black));
					this.rotation = DefaultRotation;
				break;
				
				case Title:
					this.Create(Colors.Red, 48);
					this.filters = new Array(this.Stroke(Colors.White));
					this.rotation = DefaultRotation;
				break;
				
				case TitleSmall:
					this.Create(Colors.Red, 28);
					this.filters = new Array(this.Stroke(Colors.White));
					this.rotation = DefaultRotation;
				break;				
				
				case TitleWhite:
					this.Create(Colors.White, 40);
					this.filters = new Array(this.Stroke(Colors.Black), this.Stroke(Colors.White));
					this.rotation = DefaultRotation;
				break;
				
				case TitleBlack:
					this.Create(Colors.Black, 40);
					this.filters = new Array(this.Stroke(Colors.White), this.Stroke(Colors.Black));
					this.rotation = DefaultRotation;
				break;
				
				case TitleDesc:
					this.Create(Colors.White, 18);
					this.filters = new Array(this.Stroke(Colors.Black), this.Stroke(Colors.White));
					this.rotation = DefaultRotation;
				break;				
				
				case ErrorMessage:			
					this.Create(Colors.Red, 20);
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case SuccessMessage:			
					this.Create(Colors.Blue, 26);
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case ProfileText:
					this.Create(Colors.Blue, 33);
					this.filters = new Array(this.Stroke(Colors.White));					
				break;
				
				case ProfileValue:
					this.Create(Colors.Red, Size);
					this.filters = new Array(this.Stroke(Colors.White));					
				break;
				
				case BlueLabel:
					this.Create(Colors.Blue, 21, TextFormatAlign.RIGHT);
					this.filters = new Array(this.Stroke(Colors.White));
				break;				
				
				case ListHead:
					this.Create(Colors.Orange, 16);
					this.filters = new Array(this.Stroke(Colors.Black));
				break;
				
				case List:
					this.Create(Colors.White, Size, Align);
					this.filters = new Array(this.Stroke(Colors.Black));
				break;
				
				case Desc:
					this.Create(Colors.White, 21);
					this.filters = new Array(this.Stroke(Colors.Black));
				break;				
				
				case matchUser:		
					this.Create(Color, Size, Align);
					this.filters = new Array(this.Stroke(Colors.White));
				break;					
				
				case matchHScore:
					this.Create(Colors.Black, 26, TextFormatAlign.RIGHT);
					W = 90;
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case matchAScore:
					this.Create(Colors.Black, 26);
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case Button:
					this.Create(Colors.Black, 26);
					this.filters = new Array(this.Stroke(Colors.White));
				break;
				
				case ddlItem:
					this.Create(Colors.Black, 19);
				break;								
				
				case InputText:					
					this.Create(Colors.Black, Size, TextFormatAlign.LEFT, TextFieldType.INPUT);
					this.filters = new Array(this.Stroke(Colors.Blue));
					W = 230;
					this.height = 29;
				break;
				
				case WinnerTitles:
					this.Create(Colors.Orange, 20);
					this.filters = new Array(this.Stroke(Colors.Black));
				break;				
			}
			
			this.htmlText = Value;
			
			if (W != 0) this.width = W;
		}
		
	}
	
}