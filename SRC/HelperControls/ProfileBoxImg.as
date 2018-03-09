package HelperControls 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import J.BASE.BaseMovieClip;
	import J.UTIL.Colors;
	import J.UTIL.GraphicHelper;
		
	import J.BASE.BaseButton;
	
	import App.Lib;
	import HelperControls.ProfileLink;
	
	/** @author Feyyaz */
	
	public class ProfileBoxImg extends BaseMovieClip
	{
		public static var tLastGames:String = Lib.LastGames;
		public static var tChooseUniform:String = Lib.ChooseUniform;
		public static var tTrophies:String = Lib.Trophies;
		public static var tChangePhoto:String = Lib.ChangePhoto;
		
		private var mBack:Sprite;
		private var mIcon:MovieClip;
		private var ItemType:String;
		
		//---------------------------------------------------------------------------//
		
		public function ProfileBoxImg(ItemType:String, IsSmall:Boolean=false)
		{
			this.ItemType = ItemType;
		}
		
		override protected function Prep():void 
		{
			mBack = GraphicHelper.drawRoundRectWithBorder(70, 75, 3, Colors.Blue, 2);
			mIcon = new Lib(this.ItemType);
		}
		
		override protected function AddStage():void 
		{
			addChild(mBack);
			addChild(mIcon);
		}
		
		override protected function Load():void 
		{
			mIcon.x = 10;
			mIcon.y = 10;
		}
		
		//---------------------------------------------------------------------------//		
		
	}
	
}