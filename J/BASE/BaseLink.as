package J.BASE
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/** @author Feyyaz **/
	
	public class BaseLink extends MovieClip
	{
		public var TxtItem:TextField = null;
		protected var ItemText:String;
		
		public function BaseLink() {
			addEventListener(Event.ADDED_TO_STAGE, Init);
			super();
		}
		
		private function Init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, Init);			
			Prep();
			Config();
			Events();
			Start();
		}
		
		protected function Prep():void { }
		
		private function Config():void {
			buttonMode = true;
			mouseChildren = false;
		}			
		
		private function Events():void
		{
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener(MouseEvent.CLICK, onClick);			
		}
		
		protected function Start():void { }
		
		protected function onMouseOver(e:MouseEvent):void { super.onMouseOver(e); }
		protected function onMouseOut(e:MouseEvent):void { super.onMouseOut(e); }		
		protected function onClick(e:MouseEvent):void { super.onClick(e); }		
		
		private function RemoveAllEvents() {
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeEventListener(MouseEvent.CLICK, onClick);		
		}
		
		public function Disable() {
			this.buttonMode = false;
			this.enabled = false;
			this.mouseEnabled = false;
			RemoveAllEvents();
		}
		
		public function Enable() {
			this.buttonMode = true;
			this.enabled = true;
			this.mouseEnabled = true;
			Events();
		}		
	}
	
}