package Game
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import J.UTIL.NumberUtil;
	
	public class AuidenceMsg extends MovieClip
	{
		private var mMsg:TextField;
		
		var arrMsgs:Array = new Array();
		
		public function AuidenceMsg() 
		{
			visible = false;
			
			mMsg = this["tf"];
			
			SetArray();
			
			TweenLite.delayedCall(12, ShowMsg);
		}
		
		private function SetArray():void
		{
			arrMsgs[0] = "Bu gol olur";
			arrMsgs[1] = "Barajda kalır";
			arrMsgs[2] = "Look at the tabela";
			arrMsgs[3] = "Iskalama, kafala!";
			arrMsgs[4] = "Hep kafasının dikine gidiyor";
			arrMsgs[5] = "Gol olur";
			arrMsgs[6] = "Ahtopot Paul'e soralım";
			arrMsgs[7] = "İyi vurur! ";
			arrMsgs[8] = "Look at the tabela";
			arrMsgs[9] = "Messi mübarek";
			arrMsgs[10] = "Hakeme oynama";
			arrMsgs[11] = "Hakeme gözlük eline sözlük";
			arrMsgs[12] = "Gelişine vur!";
		}
		
		public function ShowMsg() {
			visible = true;
			mMsg.text = arrMsgs[NumberUtil.Random(0, 12)];
			TweenLite.delayedCall(3, HideMsg);			
		}
		
		private function HideMsg():void
		{
			visible = false;
			TweenLite.delayedCall(12, ShowMsg);
		}
		
	}
	
}