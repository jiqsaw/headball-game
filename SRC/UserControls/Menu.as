package UserControls
{	
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	
	import com.greensock.*;
	import com.greensock.easing.*;	
	
	import J.BASE.BaseMovieClip;

	import Screens.Awards;
	import Screens.HowToPlay;
	import Screens.TopList;	
	import App.Lib;
	import App.Wording;
	import App.Bus;
	import HelperControls.MenuItem;
	
	/** @author Feyyaz */	
	
	public class Menu extends BaseMovieClip
	{
		private var mAwards:MenuItem;
		private var mTopList:MenuItem;
		private var mHowToPlay:MenuItem;
		
		//---------------------------------------------------------------------------//
		
		public function Menu() { trace("Loaded Menu"); }
		
		override protected function Prep():void 
		{
			mAwards = new MenuItem(Lib.MenuItemAwards, Wording.menuAwards);
			mTopList = new MenuItem(Lib.MenuItemTopList, Wording.menuTopList);
			mHowToPlay = new MenuItem(Lib.MenuItemHowToPlay, Wording.menuHowToPlay);
		}
		
		override protected function AddStage():void {		
		}
		
		override protected function Events():void { 
			this.Click(mAwards, PageClick);
			this.Click(mTopList, PageClick);
			this.Click(mHowToPlay, PageClick);			
		}		
		
		private function PageClick(e:MouseEvent):void
		{
			switch (e.currentTarget)
			{
				case mAwards:
					Bus.GetPage(new Awards());
					mAwards.Disable();
					mTopList.Active();
					mHowToPlay.Active();
				break;
				
				case mTopList:
					Bus.GetPage(new TopList());
					mTopList.Disable();
					mAwards.Active();
					mHowToPlay.Active();					
				break;
				
				case mHowToPlay:
					Bus.GetPage(new HowToPlay());
					mHowToPlay.Disable();
					mAwards.Active();
					mTopList.Active();					
				break;
			}
		}
		
		override protected function Load():void {			
			AddAwards();
			setTimeout(AddTopList, 400);
			setTimeout(AddHowToPlay, 800);					
		}
		
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//
		
		function AddAwards() {
			this.XY(mAwards, 7, 0);
			addChild(mAwards);
		}
		
		function AddTopList() {
			this.XY(mTopList, 130, 0);
			addChild(mTopList);
		}
		
		function AddHowToPlay() {
			this.XY(mHowToPlay, 253, 0);
			addChild(mHowToPlay);
		}
		
		public function ReturnDefault() {
			mAwards.Active();
			mTopList.Active();
			mHowToPlay.Active();
		}
	}
}