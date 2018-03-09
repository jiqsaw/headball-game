package 
{
	import com.App;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.media.Camera;
	
	/**
	$(CBI)* ...
	$(CBI)* @author 
	$(CBI)*/
	public class main extends MovieClip
	{
		var app:App;
		
		var TopScore:Number;
		var parentObj:*
		
		public function main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			Global.M = this;
			parentObj = this.parent.parent.parent;
			
			if (this.parent != this.stage)
			{
				app = new App(parentObj.GetStage());
				addChild(app);
				
				TopScore = parentObj.TopScore;
				
				//if (!Global.cam.muted) {
					//parentObj.HeadCameraAllow(null);
					//parent.dispatchEvent(new Event("HEADCAMERA_ALLOW"));
				//}
			}
			
			parent.addEventListener("HEADCAMERA_REMOVE", HeadCamRemove);
			parent.addEventListener("HEADCAMERA_OPENEDCAM", HeadCameraOpened);			
		}
		
		private function HeadCameraOpened(e:Event):void 
		{
			Global.counter.PointVisible(true);
		}
		
		private function HeadCamRemove(e:Event):void
		{
			app.scene.CloseCamera();
		}
		
		public function camStatus(e:StatusEvent):void
		{
			switch (e.code)
			{
				case "Camera.Muted": 
					parent.dispatchEvent(new Event("HEADCAMERA_DENY"));
					break;
					
				case "Camera.Unmuted":
					Global.counter.PointVisible(true);
					parent.dispatchEvent(new Event("HEADCAMERA_ALLOW"));
					break;
			}
		}
		
		public function ScoreUpdate(Score:Number) {			
			if (Score > TopScore) {
				parentObj.GameScore = Score
				parent.dispatchEvent(new Event("HEADCAMERA_HIGHSCORE"));
				app.scene.BallStop();
				HeadCamRemove(null);				
			}
		}
	}

}