package UserControls
{
	import App.Wording;
	import com.greensock.easing.Circ;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	import J.BASE.BaseMovieClip;
	import J.UTIL.Align;
	
	import App.Lib;
	
	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class EntryAwards extends BaseMovieClip
	{
		
		private var mBack1:Lib;
		private var mBack2:Lib;
		private var mBack3:Lib;		
		private var mBack4:Lib;
		private var mBack5:Lib;
		private var mBack6:Lib;		
		private var mBack7:Lib;
		
		private var mPlayStationDesc:Text;
		private var mPes2010Desc:Text;
		private var mProjeksiyonDesc:Text;
		private var mDavulDesc:Text;
		private var mKlaksonDesc:Text;
		private var mBallDesc:Text;
		private var mKronometreDesc:Text;
		
		private var mPlayStation:Lib;
		private var mPes2010:Lib;
		private var mProjeksiyon:Lib;
		private var mDavul:Lib;
		private var mKlakson:Lib;
		private var mBall:Lib;
		private var mKronometre:Lib;		
		
		
		public function EntryAwards() 
		{
			
		}
		
		override protected function Prep():void 
		{
			mBack1 = new Lib(Lib.EntryAwardBack);
			mBack2 = new Lib(Lib.EntryAwardBack);
			mBack3 = new Lib(Lib.EntryAwardBack);			
			mBack4 = new Lib(Lib.EntryAwardBack);
			mBack5 = new Lib(Lib.EntryAwardBack);
			mBack6 = new Lib(Lib.EntryAwardBack);
			mBack7 = new Lib(Lib.EntryAwardBack);
			
			mPlayStationDesc = new Text(Wording.awardsPlayStation, Text.Desc);
			mPes2010Desc = new Text(Wording.awardsPes2010, Text.Desc);
			mProjeksiyonDesc = new Text(Wording.awardsProjeksiyon, Text.Desc);
			mDavulDesc = new Text(Wording.awardsDavul, Text.Desc);
			mKlaksonDesc = new Text(Wording.awardsKlakson, Text.Desc);
			mBallDesc = new Text(Wording.awardsFutbolTopu, Text.Desc);
			mKronometreDesc = new Text(Wording.awardsKronometre, Text.Desc);
			
			mDavul = new Lib(Lib.AwardsDavul);
			mKlakson = new Lib(Lib.AwardsKlakson);
			mBall = new Lib(Lib.AwardsBall);
			mKronometre = new Lib(Lib.AwardsKronometre);			
			mPlayStation = new Lib(Lib.AwardsPlayStation);
			mPes2010 = new Lib(Lib.AwardsPes2010);
			mProjeksiyon = new Lib(Lib.AwardsProjeksiyon);			
		}
		
		override protected function AddStage():void 
		{					
			addChild(mBack1);
			addChild(mBack2);
			addChild(mBack3);			
			addChild(mBack4);
			addChild(mBack5);
			addChild(mBack6);
			addChild(mBack7);
			
			mBack1.addChild(mPlayStation);
			mBack2.addChild(mPes2010);
			mBack3.addChild(mProjeksiyon);		
			mBack4.addChild(mDavul);
			mBack5.addChild(mKlakson);
			mBack6.addChild(mBall);
			mBack7.addChild(mKronometre);
			
			//mBack1.addChild(mPlayStationDesc);
			//mBack2.addChild(mPes2010Desc);
			//mBack3.addChild(mProjeksiyonDesc);
			//mBack4.addChild(mDavulDesc);
			//mBack5.addChild(mKlaksonDesc);
			//mBack6.addChild(mBallDesc);
			//mBack7.addChild(mKronometreDesc);			
		}
		
		var arrList:Array;
		override protected function Load():void 
		{
			this.XY(mPlayStationDesc, 25, 25);
			this.XY(mPes2010Desc, 25, 25);
			this.XY(mProjeksiyonDesc, 25, 25);
			this.XY(mDavulDesc, 30, 15);
			this.XY(mKlaksonDesc, 20, 65);
			this.XY(mBallDesc, 25, 25);
			this.XY(mKronometreDesc, 25, 25);
			
			mPlayStation.x = mPes2010.x = mProjeksiyon.x = mDavul.x = mKlakson.x = mBall.x = mKronometre.x = 30;
			mPlayStation.y = mPes2010.y = mProjeksiyon.y = mDavul.y = mKlakson.y = mBall.y = mKronometre.y = 20;
			
			mBack4.alpha = mBack5.alpha = mBack6.alpha = mBack7.alpha = 0;
			mBack4.x = mBack5.x = mBack6.x = mBack7.x = 340;
			
			Align.CustomCenter(mBack1.width, mBack1.height, mPlayStation);
			Align.CustomCenter(mBack1.width, mBack1.height, mPes2010);
			Align.CustomCenter(mBack1.width, mBack1.height, mProjeksiyon);
			Align.CustomCenter(mBack1.width, mBack1.height, mDavul);
			Align.CustomCenter(mBack1.width, mBack1.height, mKlakson);
			Align.CustomCenter(mBack1.width, mBack1.height, mBall);
			Align.CustomCenter(mBack1.width, mBack1.height, mKronometre);
			
			Hide(mBack1);
			Hide(mBack2);
			Hide(mBack3);
			Hide(mBack4);
			Hide(mBack5);
			Hide(mBack6);
			Hide(mBack7);
		}
		
		var Count:Number = 1;
		
		override protected function Start():void 
		{
			switch (Count) 
			{
				case 1:
					Slide(mBack1, mBack2, mBack3, mBack7);
				break;
				
				case 2:
					Slide(mBack2, mBack3, mBack4, mBack1);					
				break;
				
				case 3:
					Slide(mBack3, mBack4, mBack5, mBack2);					
				break;
				
				case 4:
					Slide(mBack4, mBack5, mBack6, mBack3);
				break;
				
				case 5:
					Slide(mBack5, mBack6, mBack7, mBack4);
				break;
				
				case 6:
					Slide(mBack6, mBack7, mBack1, mBack5);					
				break;
				
				case 7:
					Slide(mBack7, mBack1, mBack2, mBack6);					
				break;				
			}		
		}
		
		private function Slide(Obj1:MovieClip, Obj2:MovieClip, Obj3:MovieClip, HideObj:MovieClip) {
			
			Hide(HideObj);
			
			TweenLite.to(Obj1, .1, { ease:Circ.easeIn, x:0, y:30, rotation: -13, delay:.2, alpha:1 } );
			TweenLite.to(Obj2, .1, { ease:Circ.easeIn, x:170, y:0, rotation:3, delay:.3, alpha:1 } );
			TweenLite.to(Obj3, .1, { ease:Circ.easeIn, x:305, y:40, rotation:2, delay:.4, alpha:1, onComplete:SlideRender } );
		}		
		
		private function SlideRender() {			
			Count++;
			if (Count > 7)
				Count = 1;
				
			TweenLite.delayedCall(3, Start);
		}
		
		private function Hide(Obj:MovieClip) {
			TweenLite.to(Obj, .7, { alpha: 0, x: 340, y:40 } );
		}	
	}
	
}