package Screens
{
	import App.DataManagement;
	import App.Session;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;
	import HelperControls.Link;
	import J.UTIL.Filter;
	import J.UTIL.GraphicHelper;
	import J.UTIL.Tools;
	import Services.Naming;
	import Services.PhpData;
	
	import J.BASE.BaseMovieClip;
	import J.UTIL.JsHelper;
	import J.UTIL.Colors;
	
	import App.Lib;
	import App.Bus;
	import App.Wording;
	import App.Global;
	import HelperControls.CallButton;
	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class TopList extends BaseMovieClip
	{
		private var Back:Sprite;		
		private var Ok:CallButton;
		private var Title:Text;
		
		private var WinnersList:Text;
		
		private var CategoryEnKafadar:Link;
		private var CategoryEnKafayiTakmis:Link;
		private var CategoryEnKafayiYedirten:Link;
		private var CategoryEnKafaDengi:Link;
		private var CategoryEnKafaYoran:Link;	
		
		private var HeadWeekContainer:Sprite;
		private var HeadWeek1:Link;
		private var HeadWeek2:Link;
		private var HeadWeek3:Link;
		private var HeadWeek4:Link;
		private var HeadWeek5:Link;
		private var HeadWeek6:Link;
		private var HeadWeek7:Link;
		private var HeadWeek8:Link;
		
		private var DataList:Object;
		
		private var catNoEnKafadar:Number = 0;
		private var catNoEnKafayiTakmis:Number = 1;
		private var catNoEnKafayiYedirten:Number = 2;
		private var catNoEnKafaDengi:Number = 3;
		private var catNoEnKafaYoran:Number = 4;
		
		private var SelectedWeekNo:Number = 0;
		private var SelectedCategory:Number = 0;
		
		public function TopList() { JsHelper.GATracker("TopList_Kazananlar"); }
		
		override protected function Prep():void 
		{
			Back = new Lib(Lib.TopListBack);
			Ok = new CallButton(CallButton.Ok);			
			Title = new Text(Wording.toplistWinnersTitle, Text.TitlePage);			
			
			WinnersList = new Text(Wording.winnersLoading, Text.Custom, Colors.White, 34, 547, TextFormatAlign.CENTER);
			WinnersList.filters = new Array(Filter.Stroke(Colors.Black));							
		}		
		
		override protected function AddStage():void {
			
		}
		
		override protected function Events():void
		{
			this.Click(Ok, OkClick);
		}
		
		override protected function Load():void
		{
			this.XY(Ok, 782, 515);
		}
		
		private function OkClick(e:MouseEvent):void
		{
			Bus.GoToDefault();
		}
		
		override protected function Start():void 
		{
			this.XY(Title, 250, 78);
			Title.alpha = 0;
			addChild(Title);
			TweenLite.to(Title, 0.5, { alpha: 1 } );
			
			addChild(Back);
			
			JulianaBackLoad();
			
			addChild(Ok);
			Ok.alpha = 0;
			TweenLite.to(Ok, .5, { alpha:1 } );					
		}
		
		private function JulianaBackLoad():void
		{	
			var JulianaBackMask:Sprite = GraphicHelper.draw(Back.width, Back.height + 15);
			JulianaBackMask.x = 100;
			JulianaBackMask.y = 90;
			
			addChild(JulianaBackMask);
			
			Back.x = JulianaBackMask.x;
			Back.y = JulianaBackMask.y + JulianaBackMask.height;
			
			Back.mask = JulianaBackMask;
			TweenLite.to(Back, .3, { y:90, onComplete:JullianaLoaded } );						
		}	
		
		private function JullianaLoaded() {					
			DesignCategoryGenerate();
			DesignHeadWeekGenerate();
			
			this.LoadFile(onDataLoaded, Lib.WinnersSrc);				
		}
		
		function onDataLoaded(e:Event):void
		{
			trace(9);
			DataList = JSON.decode(e.currentTarget.data);
			
			trace(1);
			addChild(WinnersList);
			this.XY(WinnersList, 450, 232);
			
			CategoryEnKafadar.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function ShowWinner():void
		{
			TweenLite.to(WinnersList, .5, { alpha: 0, onComplete:
														function () {
															WinnersList.text = DataList[SelectedWeekNo][SelectedCategory];
															TweenLite.to(WinnersList, .5, { alpha: 1 } );
														}
													} );														
		}
		
		/*----------------------------*/
		
		function DesignCategoryGenerate() {
			
			CategoryEnKafadar = new Link(Wording.winnersCategoryEnKafadar, 20, Text.WinnerTitles, catNoEnKafadar.toString());
			CategoryEnKafayiTakmis = new Link(Wording.winnersCategoryEnKafayiTakmis, 20, Text.WinnerTitles, catNoEnKafayiTakmis.toString());
			CategoryEnKafayiYedirten = new Link(Wording.winnersCategoryEnKafayiYedirten, 20, Text.WinnerTitles, catNoEnKafayiYedirten.toString());
			CategoryEnKafaDengi = new Link(Wording.winnersCategoryEnKafaDengi, 20, Text.WinnerTitles, catNoEnKafaDengi.toString());
			CategoryEnKafaYoran = new Link(Wording.winnersCategoryEnKafaYoran, 20, Text.WinnerTitles, catNoEnKafaYoran.toString());
			
			addChild(CategoryEnKafadar);
			addChild(CategoryEnKafayiTakmis);
			addChild(CategoryEnKafayiYedirten);
			addChild(CategoryEnKafaDengi);
			addChild(CategoryEnKafaYoran);
			
			this.XY(CategoryEnKafadar, 270, 110);
			this.XY(CategoryEnKafayiTakmis, CategoryEnKafadar.x + CategoryEnKafadar.width + 23, 110);
			this.XY(CategoryEnKafayiYedirten, CategoryEnKafayiTakmis.x + CategoryEnKafayiTakmis.width + 23, 110);
			this.XY(CategoryEnKafaDengi, CategoryEnKafayiYedirten.x + CategoryEnKafayiYedirten.width + 23, 110);
			this.XY(CategoryEnKafaYoran, CategoryEnKafaDengi.x + CategoryEnKafaDengi.width + 23, 110);
			
			
			CategoryEnKafadar.addEventListener(MouseEvent.CLICK, EnKafadarClick);																	
			CategoryEnKafayiTakmis.addEventListener(MouseEvent.CLICK, CategoryClick);
			CategoryEnKafayiYedirten.addEventListener(MouseEvent.CLICK, CategoryClick);
			CategoryEnKafaDengi.addEventListener(MouseEvent.CLICK, CategoryClick);
			CategoryEnKafaYoran.addEventListener(MouseEvent.CLICK, CategoryClick);
		}		
		
		private function EnKafadarClick(e:MouseEvent):void
		{
			SelectedWeekNo = 0;
			CategoryClick(e);
		}
		
		function DesignHeadWeekGenerate() {
			
			HeadWeekContainer = new Sprite();
			
			HeadWeek1 = new Link(Wording.winnersWeek1, 21, Text.WinnerTitles, "1");
			HeadWeek2 = new Link(Wording.winnersWeek2, 21, Text.WinnerTitles, "2");
			HeadWeek3 = new Link(Wording.winnersWeek3, 21, Text.WinnerTitles, "3");
			HeadWeek4 = new Link(Wording.winnersWeek4, 21, Text.WinnerTitles, "4");
			HeadWeek5 = new Link(Wording.winnersWeek5, 21, Text.WinnerTitles, "5");
			HeadWeek6 = new Link(Wording.winnersWeek6, 21, Text.WinnerTitles, "6");
			HeadWeek7 = new Link(Wording.winnersWeek7, 21, Text.WinnerTitles, "7");
			HeadWeek8 = new Link(Wording.winnersWeek8, 21, Text.WinnerTitles, "8");
			
			HeadWeekContainer.addChild(HeadWeek1);
			HeadWeekContainer.addChild(HeadWeek2);
			HeadWeekContainer.addChild(HeadWeek3);
			HeadWeekContainer.addChild(HeadWeek4);
			HeadWeekContainer.addChild(HeadWeek5);
			HeadWeekContainer.addChild(HeadWeek6);
			HeadWeekContainer.addChild(HeadWeek7);
			HeadWeekContainer.addChild(HeadWeek8);
			
			addChild(HeadWeekContainer);
			
			this.XY(HeadWeekContainer, 290, 160);
			
			this.XY(HeadWeek1, 0, 0);
			this.XY(HeadWeek2, HeadWeek1.x + HeadWeek1.width + 11, 0);
			this.XY(HeadWeek3, HeadWeek2.x + HeadWeek2.width + 11, 0);
			this.XY(HeadWeek4, HeadWeek3.x + HeadWeek3.width + 11, 0);
			this.XY(HeadWeek5, HeadWeek4.x + HeadWeek4.width + 11, 0);
			this.XY(HeadWeek6, HeadWeek5.x + HeadWeek5.width + 11, 0);
			this.XY(HeadWeek7, HeadWeek6.x + HeadWeek6.width + 11, 0);
			this.XY(HeadWeek8, HeadWeek7.x + HeadWeek7.width + 11, 0);
			
			HeadWeek1.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek2.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek3.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek4.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek5.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek6.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek7.addEventListener(MouseEvent.CLICK, HeadClick);
			HeadWeek8.addEventListener(MouseEvent.CLICK, HeadClick);
			
		}
		
		private function CategoryClick(e:MouseEvent):void
		{
			var Sender:Link = (e.currentTarget as Link);		
			
			CategoriesInitial();
			LinkActive(Sender);
			
			SelectedCategory = int(Sender.CommandValue);
			
			trace("SelectedCategory : " + SelectedCategory);
			
			HeadWeekContainer.visible = !(SelectedCategory == catNoEnKafadar);
			
			if (SelectedCategory > 0) {
				SelectedWeekNo = 8;
				HeadWeekInitial();
				LinkActive(HeadWeek8);
			}
			
			ShowWinner();
		}
		
		private function HeadClick(e:MouseEvent):void
		{
			var Sender:Link = (e.currentTarget as Link);
			
			HeadWeekInitial();
			LinkActive(Sender);
			
			SelectedWeekNo = int(Sender.CommandValue);
			
			trace("SelectedWeekNo : " + SelectedWeekNo);			
			
			ShowWinner();
		}
		
		private function LinkActive(Target:Link) 
		{
			Target.Disable();
			Target.TxtItem.textColor = Colors.Red;
		}
		
		private function CategoriesInitial() {
			CategoryEnKafadar.TxtItem.textColor = Colors.Orange;
			CategoryEnKafayiTakmis.TxtItem.textColor = Colors.Orange;
			CategoryEnKafayiYedirten.TxtItem.textColor = Colors.Orange;
			CategoryEnKafaDengi.TxtItem.textColor = Colors.Orange;
			CategoryEnKafaYoran.TxtItem.textColor = Colors.Orange;
			
			CategoryEnKafadar.Enable();
			CategoryEnKafayiTakmis.Enable();
			CategoryEnKafayiYedirten.Enable();
			CategoryEnKafaDengi.Enable();
			CategoryEnKafaYoran.Enable();
		}
		
		private function HeadWeekInitial() {
			HeadWeek1.TxtItem.textColor = Colors.Orange;
			HeadWeek2.TxtItem.textColor = Colors.Orange;
			HeadWeek3.TxtItem.textColor = Colors.Orange;
			HeadWeek4.TxtItem.textColor = Colors.Orange;
			HeadWeek5.TxtItem.textColor = Colors.Orange;
			HeadWeek6.TxtItem.textColor = Colors.Orange;
			HeadWeek7.TxtItem.textColor = Colors.Orange;
			HeadWeek8.TxtItem.textColor = Colors.Orange;
			
			HeadWeek1.Enable();
			HeadWeek2.Enable();
			HeadWeek3.Enable();
			HeadWeek4.Enable();
			HeadWeek5.Enable();
			HeadWeek6.Enable();
			HeadWeek7.Enable();
			HeadWeek8.Enable();
		}
	}
	
}