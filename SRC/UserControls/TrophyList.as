package UserControls
{
	import App.Wording;
	import J.BASE.BaseMovieClip;
	import J.UTIL.Colors;

	import HelperControls.Text;
	
	/** @author Feyyaz */
	
	public class TrophyList extends BaseMovieClip
	{
		
		public static const EnCentilmen:Number = 1;
		public static const KafadanEnKopuk:Number = 2;
		public static const KafadanEnUcmus:Number = 3;
		public static const KafadanEnUydurma:Number = 4;
		public static const KafasiEnAgirBasan:Number = 5;
		public static const KafasiEnHizliCalisan:Number = 6;
		public static const KafasinaEnDankEtmis:Number = 7;
		public static const KafasiniEnKullanmis:Number = 8;
		public static const KafasininEnDikineGiden:Number = 9;
		public static const KafayaEnKoymus:Number = 10;
		public static const KafayaEnTakmis:Number = 11;
		public static const KafayiEnBozmus:Number = 12;
		public static const KafayiEnYemis:Number = 13;
		public static const KafayiEnYormus:Number = 14;
		public static const MessiKupasi:Number = 15;
		public static const NewtonKupasi:Number = 16;
		
		private var ItemType:Number;
		private var ItemText:String;
		
		private var Level:Number = 0;
		
		private var mText:Text;
		
		private var arrTrophyNames:Array = new Array();
		
		
		public function TrophyList(ItemType:Number, Level:Number) { 
			this.ItemType = ItemType;			
			this.Level = Level;
			
			arrTrophyNames[0] = "";
			arrTrophyNames[1] = Wording.trophyKafayaEnTakmis;
			arrTrophyNames[2] = Wording.trophyKafayiEnYedirtmis;
			arrTrophyNames[3] = Wording.trophyKafayiEnBozmus;
			arrTrophyNames[4] = Wording.trophyKafasiEnHizliCalisan;
			arrTrophyNames[5] = Wording.trophyKafasiEnAgirCalisan;
			arrTrophyNames[6] = Wording.trophyKafayiEnYormus;
			arrTrophyNames[7] = Wording.trophyKafasininEnDikineGiden;
			arrTrophyNames[8] = Wording.trophyKafasiniEnKullanmis;
			arrTrophyNames[9] = Wording.trophyEnCentilmen;
			arrTrophyNames[10] = Wording.trophyMessiKupasi;
			arrTrophyNames[11] = Wording.trophyNewtonKupasi;
			
			//this.ItemText = ItemText;
			this.ItemText = arrTrophyNames[this.ItemType];
		}
		
		override protected function Prep():void 
		{
			mText = new Text(this.ItemText, Text.Custom, Colors.Red, 16);
		}
		
		override protected function AddStage():void 
		{
			addChild(mText);
			
			for (var i:int = 1; i <= 3; i++) 
			{
				if (i <= this.Level)
					this["TrophyStar" + i.toString()].visible = true;
				else
					this["TrophyStar" + i.toString()].visible = false;
			}
		}
		
		override protected function Load():void 
		{
			this.XY(mText, 54, 0);
		}
		
		override protected function Start():void 
		{
			gotoAndStop(this.ItemType);
		}
		
	}
	
}