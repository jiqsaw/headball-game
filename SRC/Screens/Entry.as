package Screens 
{				
	import App.Session;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Sine;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	import J.UTIL.GraphicHelper;
	import J.UTIL.Filter;
	import J.UTIL.JsHelper;
	import J.UTIL.Colors;
	import J.BASE.BaseText;	
	import J.BASE.BaseMovieClip;

	import App.Lib;
	import App.Bus;
	import App.Global;
	import App.Wording;
	import HelperControls.Text;
	import HelperControls.CallButton;	
	import UserControls.EntryAwards;
	import UserControls.ResizePhotoMask;
	
	/** @author Feyyaz */

	public class Entry extends BaseMovieClip
	{
		private var mHotBall:MovieClip;
		
		private var mTxtDescription:Text;
		
		private var mPlay:CallButton;
		private var mJoin:CallButton;			
		
		private var mEntryAwards:EntryAwards;
		
		public static const PAGE_LOADED:String = "PAGE_LOADED";
		
		//---------------------------------------------------------------------------//
		
		public function Entry() { JsHelper.GATracker("Splash"); }
		
		override protected function Prep():void {
			
			if (Session.sIsLogin)
				Bus.GetPage(new Profile());					
				
			mHotBall = new Lib(Lib.HotBall);
			
			mTxtDescription = new Text(Wording.EntryDescription, Text.Custom, Colors.White, 24, 390);
			mTxtDescription.filters = new Array(Filter.Stroke(Colors.Black));
			
			mPlay = new CallButton(CallButton.Play);
			mJoin = new CallButton(CallButton.Join);					
			
			mEntryAwards = new EntryAwards();
		}
		
		override protected function AddStage():void {			
			addChild(mEntryAwards);
		}
		
		override protected function Events():void {
			mPlay.addEventListener(MouseEvent.CLICK, PlayClick);
			mJoin.addEventListener(MouseEvent.CLICK, JoinClick);
		}
		
		override protected function Load():void
		{
			this.XY(mEntryAwards, 450, 115);	
		}
		
		override protected function Start():void { 
			HotBallLoad();
		}
		
		//---------------------------------------------------------------------------//		
		
		function PlayClick(e:MouseEvent):void
		{
			Bus.StartGame(Lib.GameClientSwf);
		}
		
		function JoinClick(e:MouseEvent):void
		{
			Bus.GetSubPage(new Join());
		}			
		
		private function HotBallLoad() {
			
			addChild(mHotBall);
			mHotBall.x = 13;
			
			mHotBall.alpha = 0;
			var HotBallMask:Sprite = GraphicHelper.draw(mHotBall.width, mHotBall.height);
			mHotBall.y = mHotBall.height;
			mHotBall.mask = HotBallMask;
			
			addChild(HotBallMask);
			TweenLite.to(mHotBall, 1.3, { alpha:1, ease:Quint.easeInOut, y:0 } );
			TweenLite.delayedCall(.4, DescriptionLoad);
		}
		
		private function DescriptionLoad() {						
			this.XY(mTxtDescription, 485, 310);
			mTxtDescription.alpha = 0;
			addChild(mTxtDescription);			
			TweenLite.to(mTxtDescription, 2, { alpha:1 } );
			ButtonsLoad();			
		}
		
		private function ButtonsLoad() {			
			this.XY(mPlay, 545, 510);
			this.XY(mJoin, 742, 510);
			
			addChild(mPlay);
			addChild(mJoin);
			
			mPlay.alpha = mJoin.alpha = 0;
			
			TweenLite.to(mPlay, .5, { y:470, alpha:1, ease:Quint.easeOut, delay: .1 } );
			TweenLite.to(mJoin, .5, { y:470, alpha:1, ease:Quint.easeOut, delay: .2 } );
			
			dispatchEvent(new Event(PAGE_LOADED));
		}		
	}
}