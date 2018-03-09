package J.BASE
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/** @author Feyyaz */
	
	public class BaseDropDownList extends BaseMovieClip
	{		
		protected var SelectedItem:BaseButton;
		protected var ListArea:MovieClip;
		
		protected var mList:MovieClip = new MovieClip();
		
		public var SelectedValue:String = "0";
		
		public function BaseDropDownList() { }
		
		override protected function AddStage():void
		{
			addChild(ListArea);
			addChild(SelectedItem);
			
			this.ListArea.addChild(mList);
			
			ListArea.visible = false;
		}		
		
		public function ShowHide():void
		{
			ListArea.visible = !ListArea.visible;
		}
		
		public function IsValid():Boolean {
			return (SelectedValue != "0");
		}
	}
	
}