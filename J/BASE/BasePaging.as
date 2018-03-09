package J.BASE 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.BASE.BaseMovieClip;
	import J.UTIL.McUtil;
	
	/** @author Feyyaz */
	
	public class BasePaging extends BaseMovieClip
	{
		protected var Prev:BaseButton;
		protected var Next:BaseButton;		
		public var Item:MovieClip;
		
		var Container:MovieClip;
		
		public var PageNo:int = 1;
		public var ShowIndex:Number;
		
		private var ItemLength:int
		private var ViewSize:int;
		private var RepeatCount:int;
		private var XPadding:Number;
		private var YPadding:Number
		
		public var REPEATING:String = "REPEATING";
		
		public function BasePaging() { }			
		
		override protected function Events():void 
		{
			this.MouseDown(Prev, PrevPage);
			this.MouseDown(Next, NextPage);
		}
		
		/**
		 * Sayfalama işlemini başlat
		 * 
		 * @param Container 	Listeyi bulunduğu Container
		 * @param ItemLength 	Toplam Kayıt Sayısı 
		 * @param ViewSize 	Bir sayfada kaç kayıt görüneceği
		 * @param RepeatCount 	Her satırdaki tekrar sayısı
		 * @param XPadding 	Her kayıt arasındaki yatay x genişlik
		 * @param YPadding 	Her kayıt arasındaki dikey x genişlik
		 */		
		public function Generate(Container:MovieClip, ItemLength:int, ViewSize:int, RepeatCount:int, XPadding:Number = 10, YPadding:Number = 10) {
			
			this.ItemLength = ItemLength;
			this.ViewSize = ViewSize;
			this.RepeatCount = RepeatCount;
			this.XPadding = XPadding;
			this.YPadding = YPadding;
			this.Container = Container;
			
			Paging();
		}
		
		private function Paging() {
			var posX:Number = 0;
			var posY:Number = 0;
			
			McUtil.McClear(this.Container);
			
			for (var i:int = 1; i <= ViewSize; i++ ) {
				
				ShowIndex = (((PageNo - 1) * ViewSize) + i) - 1;			
				
				dispatchEvent(new Event(REPEATING));
				
				if (i > 1) {
					posX = ((i - 1) % RepeatCount == 0) ? 0 : posX + XPadding;
					posY = ((i - 1) % RepeatCount == 0) ? posY + YPadding : posY;
				}
				
				this.Container.addChild(Item);
				TweenLite.to(Item, .5, { x:posX, y:posY } );
				
				if (ShowIndex >= ItemLength - 1) 
					break;
			}
		}
		
		private function PrevPage(e:MouseEvent):void
		{
			if (PageNo > 1)
				PageNo--;
			else
				PageNo = ItemLength  //sona gitmesi için
				
			Paging();
		}
		
		private function NextPage(e:MouseEvent):void
		{
			if (PageNo < Math.ceil(ItemLength / ViewSize))
				PageNo++;
			else
				PageNo = 1;	//başa dönmesi için
				
			Paging();
		}
		
		public function GoToPage(PageNo:Number) {
			if ((PageNo > 0) && (PageNo <= Math.ceil(ItemLength / ViewSize))) {
				this.PageNo = PageNo
				Paging();
			}				
		}
	}
	
}