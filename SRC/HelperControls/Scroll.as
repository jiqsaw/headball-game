package HelperControls
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import J.UTIL.GraphicHelper;	
	import J.BASE.BaseButton;
	import J.BASE.BaseScroll;
	
	import App.Lib;
	import HelperControls.ScrollButton;
	
	/** @author Feyyaz */
	
	public class Scroll extends BaseScroll
	{	
		public function Scroll(MasterClass:MovieClip, Content:Object, AreaW:Number, AreaH:Number, AreaX:Number, AreaY:Number) { 
			
			this.Generate(MasterClass, Content, AreaW, AreaH, AreaX, AreaY);
		}
		
		override protected function Prep():void 
		{
			this.Top = new ScrollButton(ScrollButton.tScrollTop);
			this.Bottom = new ScrollButton(ScrollButton.tScrollBottom);
			this.Track = new ScrollButton(ScrollButton.tScrollBall);			
			this.Bar = GraphicHelper.draw(6, 356, 0xf2c621);
		}
	}
	
}