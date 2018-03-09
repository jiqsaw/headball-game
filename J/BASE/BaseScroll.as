package J.BASE
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import J.BASE.BaseMovieClip;
	import J.UTIL.GraphicHelper;
	
	/** @author Feyyaz */
	
	public class BaseScroll extends BaseMovieClip
	{
		protected var MasterClass:MovieClip;	//Scrollun bulunduğu class
		protected var AreaW:Number;				//Görünen alan genişlik
		protected var AreaH:Number;				//Görünen alan yükseklik
		protected var AreaX:Number;				//Görünen alan X
		protected var AreaY:Number;				//Görünen alan Y
		
		protected var Top:MovieClip;			//Yukarı Ok
		protected var Bottom:MovieClip;			//Aşağı Ok
		protected var Track:MovieClip;			//Scroll Objesi
		protected var Bar:Sprite;				//Scroll Bar
		
		protected var Content:Object;			//İçerik
		protected var ContentArea:Sprite;		//Görünen alan (mask)
		protected var ContentStartY:Number;		//İçeriğin Başlangç Y değeri		
		protected var TrackTopY:Number;			//Scroll Topunun Başlangıç Y değeri
		protected var TrackBottomY:Number;		//Scroll Topunun Bitiş Y değeri		
		
		protected var StepCount:Number;  		//Kaç parçada gösterileceği		
		
		protected var IsTween:Boolean = true; 	//Tween ile kayması
		
		public function BaseScroll() { }
		
		protected function Generate(MasterClass:MovieClip, Content:Object, AreaW:Number, AreaH:Number, AreaX:Number, AreaY:Number, StepCount:Number = 10) {
			this.StepCount = StepCount;
			this.MasterClass = MasterClass;
			this.Content = Content;
			this.AreaW = AreaW;
			this.AreaH = AreaH;
			this.AreaX = AreaX;
			this.AreaY = AreaY;
		}
		
		override protected function AddStage():void 
		{					
			ContentArea = GraphicHelper.draw(AreaW, AreaH);
			this.XY(ContentArea, AreaX, AreaY);
			Content.mask = ContentArea;
			MasterClass.addChild(ContentArea);			
			
			addChild(Bar);
			addChild(Top);
			addChild(Bottom);
			addChild(Track);
		}
		
		override protected function Load():void
		{			
			var TopX:Number = 0;
			var BarX:Number = (Top.width / 2) - (Bar.width / 2);
			var TrackX:Number = BarX + (Bar.width / 2) - (Track.width / 2);
			var BottomX:Number = 0;
			
			var TopY:Number = 0;
			var BarY:Number = Top.height + 10;
			var TrackY:Number = BarY;
			var BottomY:Number = BarY + Bar.height + 10;
			
			this.XY(Top, TopX, TopY);
			this.XY(Bar, BarX, BarY);
			this.XY(Track, TrackX, TrackY);
			this.XY(Bottom, BottomX, BottomY);			
		}				
		
		override protected function Start():void 
		{
			ContentStartY = Content.y;
			TrackTopY = Bar.y;
			TrackBottomY = (Bar.y + Bar.height) - Track.height;			
		}
		
		override protected function Events():void 
		{
			this.Click(Top, UpClick);
			this.Click(Bottom, DownClick);
			this.MouseDown(Track, Drag);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, Wheel);
		}
		
		private function Wheel(e:MouseEvent):void 
		{
			if (e.delta < 0)
				Bottom.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			else
				Top.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function Drag(e:MouseEvent) {
			e.currentTarget.startDrag(false, new Rectangle(e.currentTarget.x, TrackTopY, 0, TrackBottomY));			
			
			Track.addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, Dragging);
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);			
		}
		
		private function Drop(e:MouseEvent) {
			Track.stopDrag();
			Track.removeEventListener(MouseEvent.MOUSE_MOVE, Dragging);
		}
			
		private function UpClick(e:MouseEvent) {
			Track.y -= Bar.height / StepCount;
			Scrolling();
		}
		
		private function DownClick(e:MouseEvent) {
			Track.y += Bar.height / StepCount;
			Scrolling();
		}	
		
		private function Dragging(e:MouseEvent):void 
		{
			Scrolling();
		}
		
		private function Scrolling() {
			Track.y = (Track.y < TrackTopY) ? TrackTopY :
							(Track.y > TrackBottomY) ? TrackBottomY :
							Track.y;
			
			//En üst seviyeden bulunduğu nokta arasındaki fark
			var GoY:Number = (Track.y - TrackTopY);
			
			//Toplam kaydırılması gereken alan / Toplam Bar alanından kaydırılan pay
			GoY = (Content.height - this.AreaH) / ((TrackBottomY - TrackTopY) / GoY);
			
			GoY = GoY * -1;
			//Başlangıç Y değerini ekle ve biraz pay bırak
			GoY += ContentStartY;
			
			(IsTween) ? TweenLite.to(Content, .3, { y: GoY } ) : Content.y = GoY;
		}		
	}
	
}