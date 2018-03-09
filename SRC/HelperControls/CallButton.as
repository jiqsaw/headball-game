package HelperControls
{	
	import com.greensock.easing.Circ;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import J.UTIL.Filter;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	
	import J.UTIL.Align;	
	import J.BASE.BaseButton;
	import J.UTIL.JsHelper;
	
	import App.Bus;
	import App.Lib;
	import App.Wording;
	import Screens.SignUp;
	
	/** @author Feyyaz */
	
	public class CallButton extends BaseButton
	{	
		public static var Play = Wording.callPlay;
		public static var SignUp = Wording.callSignUp;
		public static var Ok = Wording.callOk;
		public static var Save = Wording.callSave;
		public static var Close = Wording.callClose;
		public static var StartGame = Wording.callStartGame;
		public static var Change = Wording.callChange;
		public static var Join = Wording.callJoin;
		public static var Login = Wording.callLogin;
		public static var Take = Wording.callTake;
		
		private var ButtonBack:MovieClip;
		
		private var ButtonText:Text;
		
		private var timerOverAnimation:Number;
		
		private var IsDefaultEvents:Boolean;
		
		//---------------------------------------------------------------------------//
		
		public function CallButton(ItemType:String, IsDefaultEvents:Boolean = true) 
		{	
			this.stop();
			this.ItemType = ItemType;
			
			this.IsDefaultEvents = IsDefaultEvents;
		}
		
		override protected function Start():void
		{
			ButtonBack = new Lib("btn" + this.ItemType);
			addChild(ButtonBack);
			
			ButtonText = new Text(this.ItemType, Text.Button);
			
			addChild(ButtonText);
			Align.CustomCenter(ButtonBack.width, ButtonBack.height, ButtonText);
			ButtonText.rotation -= 2;			
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			ButtonBack.filters = new Array(Filter.Hue());
		}
		
		override protected function onMouseOut(e:MouseEvent):void
		{
			ButtonBack.filters = new Array();
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			if (IsDefaultEvents) {
				switch (this.ItemType) 
				{
					case Close:
						Bus.CloseSubPage();
					break;
				}
			}
			
			RemoveAllEvents();
		}
		
		
		//---------------------------------------------------------------------------//
	}
	
}