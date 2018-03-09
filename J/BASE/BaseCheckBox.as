package J.BASE 
{
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;
	import J.UTIL.GraphicHelper;
	
	/** @author Feyyaz */
	
	public class BaseCheckBox extends BaseButton
	{
		protected var BackColor:uint = 0xFFFFFF;		
		protected var BorderColor:uint = 0xa5c3ff;
		protected var BorderSize:Number = 3;
		protected var RoundW:Number = 3;
		protected var Alpha:Number = 1;
		protected var W:Number = 25;
		protected var H:Number = 25;
		
		protected var IsChecked:Boolean = false;
		
		public function BaseCheckBox() { }
		
		override protected function Start():void { CreateGraphic(); }
		override protected function onMouseOver(e:MouseEvent):void { }		
		override protected function onMouseOut(e:MouseEvent):void { }
		override protected function onClick(e:MouseEvent):void
		{	
			//IsChecked = !IsChecked;
		}
		
		private function CreateGraphic():void
		{
			addChild(GraphicHelper.drawRoundRectWithBorder(W, H, BorderSize, BorderColor, RoundW, BackColor, Alpha));
		}
	}
	
}