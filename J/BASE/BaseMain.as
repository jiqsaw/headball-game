package J.BASE
{
	import fl.transitions.easing.Strong;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Feyyaz
	$(CBI)*/
	public class BaseMain extends Sprite
	{
		public function get StageW():Number { return stage.stageWidth; }
		public function get StageH():Number { return stage.stageHeight; }
		
		public function BaseMain() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
			super();
		}
		
		protected function Init(e:Event):void 
		{			
			removeEventListener(Event.ADDED_TO_STAGE, Init);			
			
			Arrange(); 			//Düzenlemeler, Ayarlar
			AddStage();			//Sahneye Ekle
			Events();			//Eventlerin tanımlanması	
		}		
		
		protected function Arrange():void { }				
		protected function AddStage():void { }
		protected function Events():void { }
		
		protected function Config(tabEnabled:Boolean, scaleMode:String, align:String, showDefaultContextMenu:Boolean) {
			tabEnabled = tabEnabled;
			stage.scaleMode = scaleMode;
			stage.align = align;
			stage.showDefaultContextMenu = showDefaultContextMenu;	
		}
		
	}
	
}