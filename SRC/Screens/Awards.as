package Screens
{
	import App.Session;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import J.BASE.BaseMovieClip;
	import J.UTIL.Filter;
	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;
	import J.UTIL.Colors;
	
	import App.Lib;
	import App.Bus;
	import App.Wording;
	import HelperControls.Text;
	import HelperControls.CallButton;
	
	
	/** @author Feyyaz */
	
	public class Awards extends BaseMovieClip
	{
		private var DataSrc:String = Lib.AwardsDesc;
		
		private var Title:Text;
		private var DetailText:Text;
		private var Ok:CallButton;
		private var mJuliana:Lib;
		private var mDavul:Lib;
		private var mKlakson:Lib;
		private var mBall:Lib;
		private var mKronometre:Lib;
		
		private var mPlayStation:Lib;
		private var mPes2010:Lib;
		private var mProjeksiyon:Lib;
		
		private var mPlayStationTitle:Text;
		private var mPes2010Title:Text;
		private var mProjeksiyonTitle:Text;
		
		private var Container:MovieClip;
		
		public function Awards() { JsHelper.GATracker("Oduller"); }
		
		override protected function Prep():void 
		{
			Title = new Text(Wording.menuAwards, Text.TitlePage);
			Ok = new CallButton(CallButton.Ok);
			
			mJuliana = new Lib(Lib.AwardsJuliana);
			mDavul = new Lib(Lib.AwardsDavul);
			mKlakson = new Lib(Lib.AwardsKlakson);
			mBall = new Lib(Lib.AwardsBall);
			mKronometre = new Lib(Lib.AwardsKronometre);
			
			mPlayStation = new Lib(Lib.AwardsPlayStation);
			mPes2010 = new Lib(Lib.AwardsPes2010);
			mProjeksiyon = new Lib(Lib.AwardsProjeksiyon);
			
			mPlayStationTitle = new Text(Wording.awardsPlayStation, Text.Custom, 0xe1091f, 21);
			mPes2010Title = new Text(Wording.awardsPes2010, Text.Custom, 0xe4bb1f, 21);
			mProjeksiyonTitle = new Text(Wording.awardsProjeksiyon, Text.Custom, 0x0a44ce, 21);
			
			this.LoadFile(onTxtLoaded, DataSrc);
			
			Container = new MovieClip();
		}
		
		override protected function AddStage():void 
		{
			Container.alpha = 0;
			addChild(Container);
			
			Container.addChild(Title);
			Container.addChild(Ok);
			addChild(mJuliana);
			Container.addChild(mDavul);
			Container.addChild(mKlakson);
			Container.addChild(mBall);
			Container.addChild(mKronometre);
			Container.addChild(mPlayStation);
			Container.addChild(mPes2010);
			Container.addChild(mProjeksiyon);			
			Container.addChild(mPlayStationTitle);
			Container.addChild(mPes2010Title);
			Container.addChild(mProjeksiyonTitle);
		}
		
		
		override protected function Events():void 
		{
			this.Click(Ok, OkClick);
		}
		
		override protected function Load():void 
		{
			this.XY(Title, 380, 75);
			this.XY(Ok, 780, 510);
			
			this.XY(mJuliana, 0, 100);
			this.XY(mDavul, 375, 260);
			this.XY(mKlakson, 530, 262);
			this.XY(mBall, 636 , 258);
			this.XY(mKronometre, 747 , 260);
			
			this.XY(mPlayStation, 322, 400);
			this.XY(mPes2010, 506 , 431);
			this.XY(mProjeksiyon, 634 , 410);	
			
			this.XY(mPlayStationTitle, 336 , 440);
			this.XY(mPes2010Title, 546 , 512);
			this.XY(mProjeksiyonTitle, 666 , 446);
		}
		
		override protected function Start():void 
		{
			mDavul.filters = new Array(Filter.Stroke(Colors.White));
			mKlakson.filters = new Array(Filter.Stroke(Colors.White));
			mBall.filters = new Array(Filter.Stroke(Colors.White));
			mKronometre.filters = new Array(Filter.Stroke(Colors.White));
			mPlayStation.filters = new Array(Filter.Stroke(Colors.White));
			mPes2010.filters = new Array(Filter.Stroke(Colors.White));
			mProjeksiyon.filters = new Array(Filter.Stroke(Colors.White));
			
			mPlayStationTitle.filters = new Array(Filter.Stroke(Colors.Black));
			mPes2010Title.filters = new Array(Filter.Stroke(Colors.Black));
			mProjeksiyonTitle.filters = new Array(Filter.Stroke(Colors.Black));
			
			JulianaLoad();
		}	
		
		private function JulianaLoad() {
			TweenLite.to(mJuliana, .4, { x: 126 } );
		}
		
		private function OkClick(e:MouseEvent):void
		{
			Bus.GoToDefault();
		}				
		
		function onTxtLoaded(e:Event):void {			
			DetailText = new Text(e.currentTarget.data, Text.LongText, Colors.White, 22);
			Container.addChild(DetailText);
			this.XY(DetailText, 380, 118);
			DetailText.rotation = 0.5;
			
			ContentsLoad();
		}
		
		private function ContentsLoad():void {
			TweenLite.to(Container, 2, { alpha: 1 } );
		}
	}
	
}