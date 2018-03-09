package HelperControls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.BASE.BaseButton;
	import J.BASE.BaseMovieClip;
	import J.BASE.BasePaging;

	import HelperControls.Text;
	import App.Wording;
	import App.Lib;
	
	/** @author Feyyaz */
	
	public class Paging extends BasePaging
	{
		private var PagingText:Text;
		
		public function Paging(PagingText:Text = null) 
		{ 
			if (PagingText == null)
				PagingText = new Text(Wording.Paging)
				
			this.PagingText = PagingText;
		}
		
		override protected function Prep():void 
		{			
			this.Prev = new PagingButton(PagingButton.tPrev);
			this.Next = new PagingButton(PagingButton.tNext);
		}
		
		override protected function AddStage():void 
		{
			addChild(this.PagingText);
			addChild(Prev);
			addChild(Next);
		}
		
		override protected function Load():void 
		{
			this.XY(Prev, 0, 7)
			this.XY(this.PagingText, 30, 0)			
			this.XY(Next, this.PagingText.x + this.PagingText.width + 10, 7)
		}
		
	}
	
}