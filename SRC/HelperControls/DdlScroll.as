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
	
	public class DdlScroll extends BaseScroll
	{	
		public function DdlScroll(MasterClass:MovieClip, Content:Object, AreaW:Number, AreaH:Number, AreaX:Number, AreaY:Number) { 
			
			this.Generate(MasterClass, Content, AreaW, AreaH, AreaX, AreaY);
		}
		
		override protected function Prep():void 
		{
			this.Top = new MovieClip();
			this.Bottom = new MovieClip();
			this.Track = new DdlScrollButton();
			this.Bar = GraphicHelper.draw(2, 88, 0x666666);
		}	
		
	}
	
}