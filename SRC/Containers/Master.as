package Containers 
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import J.UTIL.Tools;
	
	import com.greensock.*;
	import com.greensock.easing.*;

	import J.UTIL.Align;	
	import J.BASE.BaseMovieClip;
	import J.UTIL.GraphicHelper;
	import J.UTIL.JsHelper;	
	
	import App.Lib;
	import App.Bus;
	import App.Global;
	import App.Wording;
	import App.SoundControl;	
	import HelperControls.SoundButton;
	import HelperControls.HeadCameraBtn;	
	import HelperControls.Link;
	import Screens.Entry;
	import UserControls.Logo;
	import UserControls.Menu;
	import UserControls.ShareIcons;
	import UserControls.Frame;

	/** @author Feyyaz */
	
	public class Master extends BaseMovieClip
	{	
		private var ContentBack:Sprite;		
		private var mSoundButton:SoundButton;
		private var mMenu:Menu;		
		private var mConditions:Link;
		private var mShareIcons:ShareIcons;
		
		private var mHeadCamera:HeadCameraBtn;
		
		//---------------------------------------------------------------------------//
		
		public function Master() {  }
		
		override protected function Prep():void {
			
			CreateContent();
			
			SwfGlobal.gSounds = new SoundControl();			
			Global.gFrame = new Frame();			
			Global.gContainer = new BaseMovieClip();		
			Global.gMainLogo = new Logo();
			
			this.mouseChildren = this.mouseEnabled = true;
			
			mSoundButton = new SoundButton();
			mMenu = new Menu();
			mShareIcons = new ShareIcons();
			mConditions = new Link(Wording.ConditionsTitle, 15);
			
			mHeadCamera = new HeadCameraBtn();
		}
		
		override protected function AddStage():void { }
		
		override protected function Events():void { 
			this.Click(mConditions, ConditionsClick);
		}		
		
		override protected function Load():void { }
		
		override protected function Start():void {
			FrameLoad();			
		}
		
		//---------------------------------------------------------------------------//		
		
		private function CreateContent() {
			this.ContentBack = new Sprite();
			var ContainerFloor:Sprite = GraphicHelper.draw(960, 515, 0x000000);								
			var ContainerFloor2:Sprite = GraphicHelper.draw(ContainerFloor.width, ContainerFloor.height, 0xFF0000);
			
			ContainerFloor2.alpha = .8;
			ContainerFloor2.alpha = .2;
			
			ContainerFloor.x = ContainerFloor2.x = 5;
			ContainerFloor.y = ContainerFloor2.y = 51;
			
			ContainerFloor.blendMode = BlendMode.OVERLAY;
			ContainerFloor2.blendMode = BlendMode.OVERLAY;
			
			ContentBack.addChild(ContainerFloor);
			ContentBack.addChild(ContainerFloor2);
			
			ContentBack.alpha = 0;			
		}
		
		
		
		private function FrameLoad() {
			Global.gFrame.x = 18;			
			Global.gFrame.y -= Global.gFrame.height;
			addChild(Global.gFrame);
			TweenLite.to(Global.gFrame, 1, { y:27, ease:Bounce.easeOut, onComplete:ContentBackLoad } );
		}
		
		private function ContentBackLoad() {
			
			addChild(ContentBack);
			this.XY(ContentBack, 50, 22);
			
			TweenLite.to(this.ContentBack, 3, { alpha: .8 } );			
			ContainerLoad();
		}
		
		private function ContainerLoad() {
			
			this.XY(Global.gContainer, Global.gFrame.x + 22, 18);
			addChild(Global.gContainer);
			
			LogoLoad();
			SoundButtonLoad();			
			HeadCamLoad();			
			
			var objEntry:Entry = new Entry();
			Bus.GetPage(objEntry);
			objEntry.addEventListener(Entry.PAGE_LOADED, ShareIconsLoad);
		}
		
		private function LogoLoad() {
			addChild(Global.gMainLogo);
			
			MenuLoad();
		}
		
		private function SoundButtonLoad():void
		{
			mSoundButton.alpha = 0;
			addChild(mSoundButton);
			this.XY(mSoundButton, 60, 210);
			TweenLite.to(mSoundButton, .5, { alpha: 1 } );
		}
		
		private function HeadCamLoad() {
			this.XY(mHeadCamera, 50, 460);
			
			addChild(mHeadCamera);
			mHeadCamera.alpha = 0;
			TweenLite.to(mHeadCamera, .5, { y:360, alpha:1, ease:Quint.easeOut, delay: .2 } );
		}		
		
		private function MenuLoad() {
			addChild(mMenu);
			this.XY(mMenu, 550, 24);
		}
		
		private function ShareIconsLoad(e:Event) {
			this.XY(mShareIcons, 73, 553);
			mShareIcons.alpha = 0;
			addChild(mShareIcons);
			TweenLite.to(mShareIcons, 2, { alpha:1 } );
			
			ConditionsLoad();
		}
		
		private function ConditionsLoad() {
			this.XY(mConditions, 167, 560);
			mConditions.alpha = 0;
			addChild(mConditions);
			TweenLite.to(mConditions, 2, { alpha:1 } );
		}
		
		private function ConditionsClick(e:MouseEvent):void
		{
			JsHelper.GATracker("KatilimKosullari");
			JsHelper.Popup(Lib.ConditionsPopup, 450, 600);			
		}
		
		public function MenuDefault() {
			mMenu.ReturnDefault();
		}
	}
	
}