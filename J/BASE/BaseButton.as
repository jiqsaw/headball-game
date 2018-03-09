package J.BASE
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	
	/** @author Feyyaz **/
	
	public class BaseButton extends MovieClip
	{	
		protected var ItemType:String;
		public var ItemText:String;
		
		public function BaseButton() 
		{
			this.stop();
			addEventListener(Event.ADDED_TO_STAGE, Init);
			super();
		}
		
		private function Init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			this.buttonMode = true;
			this.mouseEnabled = true;
			mouseChildren = false;
			Events();
			Start();
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
		
		public function RemoveAllEvents() {
			removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			removeEventListener(MouseEvent.CLICK, onClick);		
		}
		
		public function Disable() {
			this.enabled = false;
			this.mouseEnabled = false;
			RemoveAllEvents();
		}
		
		public function Enable() {
			this.enabled = true;
			this.mouseEnabled = true;
			Events();
		}		
		
	}
	
}