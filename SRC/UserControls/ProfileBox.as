package UserControls
{	
	import flash.events.Event;
	import flash.events.MouseEvent;	
	
	import J.UTIL.Colors;
	import J.BASE.BaseMovieClip;
	import J.BASE.BaseButton;

	import App.Wording;
	import App.Global;
	import App.Bus;
	import HelperControls.Text;
	import HelperControls.ProfileBoxImg;
	
	import Screens.LastGames;
	import Screens.Trophies;
	import Screens.ChangePhoto;
	
	/** @author Feyyaz */

	public class ProfileBox extends BaseButton
	{
		public static var tLastGames:String = Wording.profileSon5mac;
		public static var tChooseUniform:String = Wording.profileFormaniAyarla;
		public static var tTrophies:String = Wording.profileTrophies;
		public static var tChangePhoto:String = Wording.profileChangePhoto;
		
		private var mProfileBoxImg:ProfileBoxImg;
		private var mLink:Text;
		
		public function ProfileBox(ItemType:String, ItemText:String)
		{
			this.ItemType = ItemType;
			this.ItemText = ItemText;
		}
		
		override protected function Start():void { 
			mProfileBoxImg = new ProfileBoxImg(this.ItemType);
			mLink = new Text(this.ItemText, Text.Links, Colors.White, 18);
			
			addChild(mProfileBoxImg);
			addChild(mLink);
			
			mProfileBoxImg.x = mProfileBoxImg.y = 0;
			mLink.x = 3;
			
			if (this.ItemType == ProfileBoxImg.tChangePhoto)
				mProfileBoxImg.x = 12;
			
			mLink.y = mProfileBoxImg.y + mProfileBoxImg.height + 10;
		}
		
		override protected function onMouseOver(e:MouseEvent):void { 
			mLink.textColor = Global.gOverColor;
		}
		
		override protected function onMouseOut(e:MouseEvent):void { 
			mLink.textColor = Colors.White;
		}
		
		override protected function onClick(e:MouseEvent):void { 			
			switch (this.ItemText) 
			{
				case tLastGames:
					Bus.GetSubPage(new LastGames());
				break;
				
				case tChooseUniform:
				break;
				
				case tTrophies:
					Bus.GetSubPage(new Trophies(), false);
				break;
				
				case tChangePhoto:
					Bus.GetSubPage(new ChangePhoto(), false);
				break;				
			}
		}
		
		
	}
	
}