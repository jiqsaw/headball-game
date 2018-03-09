package Game
{
	import App.Session;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import J.UTIL.JsHelper;
	import Services.PhpData;
	import Services.SFS;
	import Services.SFSGlobal;
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class SearchOpponent extends MovieClip
	{
		private var names:Array = new Array();
		private var surnames:Array = new Array();
		private var cities:Array = new Array();
		
		private var timer:Timer
		private var elapsedTime:Number = 10;
		
		public var mStartBtn:MovieClip;		
		
		public function SearchOpponent() 
		{
			x = 966 / 2 + 50;
			y = 545 / 2 + 30;
			
			mStartBtn = this["startBtn"];
			
			timeTf.visible = false;
			mStartBtn.visible = SFSGlobal.OpponentFinded;
			
			names = ["Pelin", "Yelda", "Merve", "Mine", "Sena", "Eda", "Yasemin", "Gözde", "Selin", "Sinem", "Yağmur", "İrem", "Emel", "Elif", "Burcu", "Gülşen", "Ahu", "Banu", "Eda", "Aslı", "Arzu", "Aslınaz", "Berfin", "Beste", "Çiğdem", "Tansu", "Bengi", "Deniz", "Erendiz", "Habibe", "Esra", "İncilay", "Jülide", "Kumru", "Neslihan", "Nilüfer", "Nükhet", "Papatya", "Yeşim", "Yaprak", "Zeynep", "Simge","Hakan", "Cem", "Mert", "Ufuk", "Mehmet", "Ceyhun", "Burak", "Enver", "Soner", "Erol", "Umut", "Sezgin", "Mustafa", "Murat", "Övünç", "Temel", "Seren", "Serhan", "Erhan", "Selçuk", "Kemal", "Yunus", "Önder", "Arıkan", "Arif", "Atilla", "Yiğit", "Uygur", "Ali", "Ümit", "Zafer", "Serdar", "Yekta", "Şahin", "Bahadır", "Batuhan", "Burak", "Çağıl", "Özkan", "Çelikkan", "Kemal", "Egemen", "Kaplan", "Keremşah", "Kuzey", "Volkan", "Onur", "Nail", "Dağhan", "Halit", "Bertan", "Akın", "Zikri", "Emre", "Ferruh"];
			surnames = ["Koçak", "Koralp", "Yağıztekin", "Yalın", "Yüksel", "Yılmaz", "Polat", "Kaya", "Şahin", "Çelik", "Nebi", "Demirbüken", "Doğaç", "Oskay", "Özkaya", "Olgun", "Karakaya", "Demirci", "Güney", "Ergüven", "Şen", "Tetik", "Acar", "Öztürk", "Yıldırım", "Karagöz", "Yapıcı", "Bulut", "Kılıç", "Oral", "Tunalı", "Ahmetler", "Tatlıcı", "Birkan", "Gümüş", "Karadeniz", "Korkut", "Akar", "Candaş", "İren", "Cesur", "İkinci", "Ilıcan", "Kudret", "Lemioğlu", "Muammer", "Öktem", "Öztürk", "Tumay", "Tunç", "Şafak", "Abay", "Aytunç", "Ateş", "Girgin", "Erkaptan", "Yıldızdoğan", "Akdoğan", "Çınar", "Demirkan", "Durukan", "Ezel", "Erenay", "Tuncer", "Işıtan", "Medeni", "Akca", "Özipek", "Pamir", "Sergen", "Simavi", "Tansel", "Tolunay", "Ünverdi", "Varol", "Vural", "Yücel"];
			cities = ["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Aksaray", "Amasya", "Ankara", "Antalya", "Ardahan", "Artvin", "Aydın", "Balıkesir", "Bartın", "Batman", "Bayburt", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Düzce", "Edirne ", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Iğdır", "Isparta", "İstanbul", "İzmir", "Kahramanmaraş", "Karabük", "Karaman", "Kars", "Kastamonu", "Kayseri", "Kırıkkale", "Kırklareli", "Kırşehir", "Kilis", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Mardin", "Mersin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Şırnak", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van ", "Yalova", "Yozgat", "Zonguldak"];			
			
			timer = new Timer(10);
			timer.addEventListener(TimerEvent.TIMER, updatePhotos)
			timer.start();
			
			mStartBtn.addEventListener(MouseEvent.CLICK, StartBtnClick);
			
			kafalar1.gotoAndPlay(16);
			
			//TweenLite.delayedCall(25, SFSErrorHandler);
		}	
		
		private function updatePhotos(e:TimerEvent):void
		{
			var name:String = names[Math.floor(Math.random() * (names.length-1))] + " " + surnames[Math.floor(Math.random() * surnames.length)];
			var city:String = cities[Math.floor(Math.random() * (cities.length -1))];
			
			var name2:String = names[Math.floor(Math.random() * (names.length-1))] + " " + surnames[Math.floor(Math.random() * surnames.length)];
			var city2:String = cities[Math.floor(Math.random() * (cities.length -1))];
			
			opponentName.text = name;
			opponentCity.text = city;
			
			playerName.text = name2;
			playerCity.text = city2;
		}
		
		public function opponentFound():void
		{		
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, updatePhotos);
			
			timer = new Timer(1000, 10);
			timer.addEventListener(TimerEvent.TIMER, countDown);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onCountdowncomplete);
			timer.start();
			timeTf.htmlText = "<font color='#DC121E'>" + elapsedTime + "</font><font color='#1157EA' size='16'>sn içinde başlayacak</font>";
			
			timeTf.visible = true;
			timeTf.mouseEnabled = false;
			
			mStartBtn.visible = true;
			mStartBtn.buttonMode = true;
			
			opponentName.text = SFSGlobal.RightPlayerName;			
			opponentCity.text = SFSGlobal.RightPlayerCity;			
			
			playerName.text = SFSGlobal.LeftPlayerName;			
			playerCity.text = SFSGlobal.LeftPlayerCity;			
			
			kafalar2.visible = kafalar1.visible = false;
			leftbody.gotoAndStop(1);
			rightbody.gotoAndStop(6);
			
			
			if (SFSGlobal.UserSide == SFSGlobal.UserSideLeft)
			{
				
				if (Session.sAvatarFileName == SwfGlobal.DefaultHead1)				
					defleft.gotoAndStop(1);
					
				else if (Session.sAvatarFileName == SwfGlobal.DefaultHead2)	
					defleft.gotoAndStop(2);
					
				else {
					
					GameGlobals.SessionAvatar = Session.GetAvatar();					
					defleft.getChildAt(0).alpha = 0;
					defleft.addChild(GameGlobals.SessionAvatar);
					
					GameGlobals.SessionAvatar.x = -GameGlobals.SessionAvatar.width;
					GameGlobals.SessionAvatar.x += (defleft.getChildAt(0).width / 2) - 25;
					GameGlobals.SessionAvatar.y += 5;
					
					if ((Session.sAccessoryNo == 2) || (Session.sAccessoryNo == 4))
						GameGlobals.SessionAvatar.x -= 26;
				}
				
				if (SFSGlobal.IsBotOpponent) {
					//Eğer kullanıcı default kafalardan birine sahipse
					(Session.sAvatarFileName == SwfGlobal.DefaultHead1) ? defright.gotoAndStop(1) : defright.gotoAndStop(2);
				}
				else 
				{
					//Eğer rakip default kafalardan birine sahipse
					if ((SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead1) || (SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead2)) {						
						if (SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead1)
							defright.gotoAndStop(1);
						else
							defright.gotoAndStop(2);
							
						if (Session.sAvatarFileName == SFSGlobal.OpponentHeadFileName)
							(Session.sAvatarFileName == SwfGlobal.DefaultHead1) ? defright.gotoAndStop(2) : defright.gotoAndStop(1);						
					}
					else
					{
						defright.getChildAt(0).alpha = 0;
						defright.addChild(SFSGlobal.OpponentHead);
						SFSGlobal.OpponentHead.x = SFSGlobal.OpponentHead.width * -1;
						SFSGlobal.OpponentHead.x += 70;
						SFSGlobal.OpponentHead.y += 5;
					}
				}
			}
			else if (SFSGlobal.UserSide == SFSGlobal.UserSideRight)
			{
				
				if (Session.sAvatarFileName == SwfGlobal.DefaultHead1)
					defright.gotoAndStop(1);
					
				else if (Session.sAvatarFileName == SwfGlobal.DefaultHead2) {
					defright.gotoAndStop(2);
				}
				else {
					GameGlobals.SessionAvatar = Session.GetAvatar();
					
					defright.getChildAt(0).alpha = 0;
					defright.addChild(GameGlobals.SessionAvatar);
					
					GameGlobals.SessionAvatar.x = -GameGlobals.SessionAvatar.width;
					GameGlobals.SessionAvatar.x += (defright.getChildAt(0).width / 2) - 25;
					GameGlobals.SessionAvatar.y += 5;
					
					if ((Session.sAccessoryNo == 2) || (Session.sAccessoryNo == 4))
						GameGlobals.SessionAvatar.x -= 26;					
				}
				
				//Eğer rakip default kafaylaysa
				if ((SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead1) || (SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead2)) {
					if (SFSGlobal.OpponentHeadFileName == SwfGlobal.DefaultHead1)
						defleft.gotoAndStop(1);
					else
						defleft.gotoAndStop(2);
						
					if (Session.sAvatarFileName == SFSGlobal.OpponentHeadFileName)
						(defleft.currentFrame == 1) ? defleft.gotoAndStop(2) : defleft.gotoAndStop(1);
				}
				else
				{
					defleft.getChildAt(0).alpha = 0;
					defleft.addChild(SFSGlobal.OpponentHead);
					
					SFSGlobal.OpponentHead.x = SFSGlobal.OpponentHead.width * -1;
					SFSGlobal.OpponentHead.x += 70;
					SFSGlobal.OpponentHead.y += 5;
				}				
			}
			
			defleft.alpha = 1;
			defright.alpha = 1;
		}
		
		private function StartBtnClick(e:MouseEvent):void
		{
			beginClick();
			SFS.ReadyToPlay();
		}
		
		private function beginClick():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, countDown);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onCountdowncomplete);
			startBtn.visible = false;
			timeTf.htmlText = "Rakibin cevabı<br/>bekleniyor";
		}
		
		private function onCountdowncomplete(e:TimerEvent):void
		{
			StartBtnClick(null);
		}
		
		private function countDown(e:TimerEvent):void
		{
			elapsedTime--;
			timeTf.htmlText = "<font color='#DC121E'>"+elapsedTime+"</font><font color='#1157EA' size='16'>sn içinde başlayacak</font>";
		}
		
		private function SFSErrorHandler() {
			var php:PhpData = new PhpData(SendError);
			php.ErrorHandler();
		}
		
		private function SendError(e:Event):void { }
	}

}