package HelperControls
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;
	import J.UTIL.Filter;
	import J.UTIL.GraphicHelper;
	
	/** @author Feyyaz */
	
	public class DdlScrollButton extends BaseButton
	{
		private var Track:Sprite;
		
		public function DdlScrollButton() 
		{
			
		}
		
		override protected function Start():void 
		{
			Track = GraphicHelper.drawRoundRect(16, 19, 3, 0x666666)
			addChild(Track);
		}
		
		override protected function onMouseOver(e:MouseEvent):void
		{
			//ScrolTrack Over
		}
		
		override protected function onMouseOut(e:MouseEvent):void
		{
			//ScrolTrack Out
		}
		
		override protected function onClick(e:MouseEvent):void { }
	}
	
}