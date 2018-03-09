package Screens 
{		
	import App.DataManagement;
	import App.Global;
	import com.adobe.serialization.json.JSON;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;	
	import J.UTIL.Colors;
	import J.UTIL.Filter;
	import J.UTIL.Tools;
	import Services.PhpData;

	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;
	import J.BASE.BaseMovieClip;
		
	import Services.Naming;
	import UserControls.TrophyList;
	import App.Wording;
	import App.Session;
	import HelperControls.Paging;
	import HelperControls.Text;
	import HelperControls.CallButton;
	import HelperControls.ProfileBoxImg;
	
	/** @author Feyyaz */

	public class Trophies extends BaseMovieClip
	{
		
		private var mTxtTitle:Text;
		private var mProfileBox:ProfileBoxImg;
		private var mClose:CallButton;
		
		private var mTrophyItem:TrophyList;
		private var mTrophiesContainer:MovieClip;
		
		private var mPaging:Paging;
		
		//---------------------------------------------------------------------------//
		
		public function Trophies() { JsHelper.GATracker("Trophyler"); }
		
		override protected function Prep():void {		
			mTxtTitle = new Text(Wording.trophiesTitle, Text.Custom, Colors.White, 30);
			mTxtTitle.filters = new Array(Filter.Stroke(Colors.Black));
			mProfileBox = new ProfileBoxImg(ProfileBoxImg.tTrophies);
			mClose = new CallButton(CallButton.Close);
		}
		
		override protected function AddStage():void {
			addChild(mProfileBox);
			addChild(mTxtTitle);
			addChild(mClose);
		}
		
		override protected function Events():void { }
		
		override protected function Load():void
		{
			this.XY(mProfileBox, 50, 40);
			this.XY(mTxtTitle, 120, 51);
			this.XY(mClose, 500, 330);
			
			mProfileBox.width = mProfileBox.height = 62;
			
			mProfileBox.rotation = Global.DefaultRotation;
		}
		
		var ObjData:Object
		override protected function Start():void {
			
			var php:PhpData = new PhpData(TrophiesResult);
			php.Trophies();
		}
		
		private function TrophiesResult(e:Event):void
		{
			if (DataManagement.IsError()) {
				var NoData:Text = new Text(Wording.trophyNoData, Text.ErrorMessage);
				addChild(NoData);			
				this.XY(NoData, 150, 150);
			}
			else {
				ObjData = DataManagement.TrophiesManagement();
				
				mPaging = new Paging();
				addChild(mPaging);
				this.XY(mPaging, 88, 310);
				
				mPaging.addEventListener(mPaging.REPEATING, onRepeating);
				
				var List:MovieClip = new MovieClip();
				
				addChild(List);
				this.XY(List, 90, 120);
				
				mPaging.Generate(List, ObjData.length, 9, 3, 167, 56);							
				
				mPaging.visible = ObjData.length > 9;
			}
		}
		
		private function onRepeating(e:Event):void
		{
			var TrophyItem = ObjData[mPaging.ShowIndex];
			mPaging.Item = new TrophyList(TrophyItem[Naming.TROPHYNO], TrophyItem[Naming.TROPHYLEVEL]);
		}
		
		//---------------------------------------------------------------------------//	
		
	}
	
}