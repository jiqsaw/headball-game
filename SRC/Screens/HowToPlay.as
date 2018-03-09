package Screens
{	
	import App.Session;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.UTIL.GraphicHelper;
		
	import J.UTIL.JsHelper;
	import J.BASE.BaseMovieClip;
	
	import App.Lib;
	import App.Bus;
	import App.Wording;
	import J.UTIL.Colors;
	import HelperControls.Scroll;
	import HelperControls.Text;
	import HelperControls.CallButton;
	
	/** @author Feyyaz */
	
	public class HowToPlay extends BaseMovieClip
	{
		private var DataSrc:String = Lib.HowToPlayTextSrc;
		
		private var Juliana:MovieClip;
		private var Title:Text;
		private var DetailText:Text;
		private var Ok:CallButton;
		
		private var mScroll:Scroll;
		
		private var ContentArea:Sprite;
		private var Content:MovieClip;
		
		public function HowToPlay() { JsHelper.GATracker("OlayNedir"); }
		
		override protected function Prep():void 
		{
			Juliana = new Lib(Lib.JulianaHowToPlay);
			Title = new Text(Wording.menuHowToPlay, Text.TitlePage);
			
			this.LoadFile(onTxtLoaded, DataSrc);
			
			Ok = new CallButton(CallButton.Ok);					
		}
		
		override protected function AddStage():void 
		{			
			addChild(Title);			
		}
		
		override protected function Events():void {
			this.Click(Ok, OkClick);
		}
		
		private function OkClick(e:MouseEvent):void
		{
			Bus.GoToDefault();
		}
		
		override protected function Load():void 
		{
			JulianaLoad();			
			this.XY(Title, 255, 90);
			this.XY(Ok, 760, 530);
		}		
		
		private function JulianaLoad():void {
			addChild(Juliana);
			this.XY(Juliana, 0, 85);
			TweenLite.to(Juliana, .4, { x: 120 } );
		}
		
		function onTxtLoaded(e:Event):void {
			
			DetailText = new Text(e.currentTarget.data, Text.LongText, Colors.White, 21);
			addChild(DetailText);
			this.XY(DetailText, 295, 140);			
			
			mScroll = new Scroll(this, DetailText, 810, 420, 90, 120);
			addChild(mScroll);
			this.XY(mScroll, 900, 100);
			
			addChild(Ok);
			
			Animations();
		}		
		
		private function Animations():void
		{
			Title.alpha = 0;
			TweenLite.to(Title, 0.5, { alpha: 1 } );
			
			DetailText.alpha = 0;
			TweenLite.to(DetailText, 1, { alpha: 1 } );
			
			mScroll.alpha = 0;
			TweenLite.to(mScroll, 1.5, { alpha: 1 } );
			
			TweenLite.to(Ok, .4, { y: 495 } );			
		}
	}
	
}