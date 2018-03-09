package J.BASE
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/** @author Feyyaz */
	
	public class BaseProgress extends BaseMovieClip
	{
		protected var Bar:Sprite;
		protected var Track:BaseButton;
		
		public function BaseProgress() { }
		
		override protected function Events():void 
		{
			Track.RemoveAllEvents();
			Track.addEventListener(MouseEvent.MOUSE_DOWN, TrackMouseDown);
		}
		
		private function TrackMouseDown(e:MouseEvent) {
			e.currentTarget.startDrag(false, new Rectangle(Bar.x, 0, Bar.width, 0));
			
			Track.addEventListener(MouseEvent.MOUSE_MOVE, TrackDragging);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, TrackDragging);
			stage.addEventListener(MouseEvent.MOUSE_UP, TrackDrop);
		}		
		
		private function TrackDrop(e:MouseEvent) {
			Track.stopDrag();	
			Track.removeEventListener(MouseEvent.MOUSE_MOVE, TrackDragging);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, TrackDragging);
			stage.removeEventListener(MouseEvent.MOUSE_UP, TrackDrop);
		}
		
		protected function TrackDragging(e:Event):void { }
		
	}
	
}