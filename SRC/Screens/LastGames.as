package Screens 
{	
	import App.DataManagement;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.text.TextFormatAlign;
	import J.UTIL.Colors;
	import Services.PhpData;
	
	import J.UTIL.JsHelper;
	import J.BASE.BaseMovieClip;

	import Services.Naming;
	import App.Session;
	import App.Wording;
	import App.Global;
	import HelperControls.Text;
	import UserControls.ProfileBox;
	import HelperControls.CallButton;
	import HelperControls.ProfileBoxImg;
	
	/** @author Feyyaz */

	public class LastGames extends BaseMovieClip
	{
		
		private var mTxtTitle:Text;
		private var mProfileBoxImg:ProfileBoxImg;
		private var mClose:CallButton;
		
		private var mHome:Text;
		private var mHScore:Text;
		private var mAScore:Text;
		private var mAway:Text;
		
		private var mDash:Text;
		
		private var mContentRotation:Sprite;
		
		//---------------------------------------------------------------------------//
		
		public function LastGames() { JsHelper.GATracker("Son5Mac"); }
		
		override protected function Prep():void {		
			mTxtTitle = new Text(Wording.lastGamesTitle, Text.TitleWhite);
			mProfileBoxImg = new ProfileBoxImg(ProfileBoxImg.tLastGames);
			mClose = new CallButton(CallButton.Close);
			mContentRotation = new Sprite();			
		}
		
		override protected function AddStage():void {
			addChild(mProfileBoxImg);
			addChild(mTxtTitle);
			addChild(mClose);
			
			addChild(mContentRotation);
		}
		
		override protected function Events():void {
			
		}
		
		override protected function Load():void
		{		
			this.XY(mProfileBoxImg, 50, 40);
			this.XY(mTxtTitle, 160, 51);
			this.XY(mClose, 500, 330);
			
			mProfileBoxImg.rotation = Global.DefaultRotation;
		}	
		
		override protected function Start():void {			
			var php:PhpData = new PhpData(LastGamesResult);
			php.LastGames();
		}
		
		private function LastGamesResult(e:Event):void
		{			
			if (DataManagement.IsError()) {
				var NoData:Text = new Text(Wording.lastGamesNoData, Text.ErrorMessage);
				addChild(NoData);			
				this.XY(NoData, 150, 150);
			}
			else {
				var ObjData:Object = DataManagement.ResultData();
				var XHome:Number = 90;
				var XHScore:Number = 198;
				var XDash:Number = 299;
				var XAScore:Number = 320;
				var XAway:Number = 350;
				
				var posY:Number = 124;			
				
				var i:Number = 0;
				
				for each (var Item in ObjData)
				{
					mHome = new Text(Item[Naming.HOME], Text.matchUser, Colors.Blue, 24, 155, TextFormatAlign.RIGHT);
					mHScore = new Text(Item[Naming.HSCORE], Text.matchHScore);
					mDash = new Text("-", Text.List);
					mAScore = new Text(Item[Naming.ASCORE], Text.matchAScore);		
					mAway = new Text(Item[Naming.AWAY], Text.matchUser, Colors.Blue);
					posY += i + 28;
					
					mContentRotation.addChild(mHome);
					mContentRotation.addChild(mHScore);
					mContentRotation.addChild(mDash);
					mContentRotation.addChild(mAScore);
					mContentRotation.addChild(mAway);
					
					this.XY(mHome, XHome, posY);
					this.XY(mHScore, XHScore, posY);
					this.XY(mDash, XDash, posY);
					this.XY(mAScore, XAScore, posY);
					this.XY(mAway, XAway, posY);
					
					i++;							
				}
			}
			
			mContentRotation.rotation = Global.DefaultRotation;
		}
		
		//---------------------------------------------------------------------------//		

	}
	
}