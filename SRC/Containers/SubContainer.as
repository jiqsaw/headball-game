package Containers
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import J.UTIL.GraphicHelper;
	
	import J.UTIL.Align;
	import J.BASE.BaseMovieClip;
	
	import App.Lib;
	import App.Global;
	
	/** @author Feyyaz */
	
	public class SubContainer extends BaseMovieClip
	{
		private var mSubContainerBoard:MovieClip;
		private var mSketchLeft:MovieClip;
		private var mSketchRight:MovieClip;
		
		private var ShowPage:MovieClip;
		private var IsAddSketchs:Boolean;
		private var IsTween:Boolean;
		
		private var MaxW:Number;
		private var MaxN:Number;
		
		//---------------------------------------------------------------------------//
		
		public function SubContainer(ShowPage:MovieClip, IsAddSketchs:Boolean, IsTween:Boolean) {
			this.ShowPage = ShowPage;
			this.IsAddSketchs = IsAddSketchs;
			this.IsTween = IsTween;
		}
		
		override protected function Prep():void {
			mSubContainerBoard = new Lib(Lib.SubContainerBoard);
			
			if (IsAddSketchs) {
				mSketchLeft = new Lib(Lib.SketchLeft);
				mSketchRight = new Lib(Lib.SketchRight);
			}
		}
		
		override protected function AddStage():void {							
			addChild(mSubContainerBoard);
			
			if (IsTween) {
				mSubContainerBoard.scaleX = 1.4;
				mSubContainerBoard.scaleY = 1.4;
				mSubContainerBoard.alpha = 0;					
				
				TweenLite.to(mSubContainerBoard, .4, { scaleX:1, scaleY:1, alpha: 1, onComplete:SketchLoad, onUpdate:AlignCenter } );
			}
			else {
				AlignCenter();
				SketchLoad();
			}
		}
		
		private function AlignCenter():void
		{
			Align.toCenterOfSize(this, mSubContainerBoard.width, mSubContainerBoard.height);
		}
		
		override protected function Events():void { }	
		override protected function Start():void { }
		
		//---------------------------------------------------------------------------//		
		
		private function SketchLoad():void
		{	
			if (IsAddSketchs) {				
				this.XY(mSketchLeft, 35, 225);
				this.XY(mSketchRight, 550, 42);
				
				addChild(mSketchLeft);
				addChild(mSketchRight);
			}
			LoadPage();
		}
		
		private function LoadPage() {
			this.ShowPage.alpha = 0;
			addChild(this.ShowPage);
			
			TweenLite.to(this.ShowPage, 1.5, { alpha: 1 } );
		}
	}
	
}