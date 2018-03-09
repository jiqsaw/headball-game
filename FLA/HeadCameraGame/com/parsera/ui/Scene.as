package com.parsera.ui 
{
	import com.App;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.EventDispatcher;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Microphone;
	import com.parsera.ui.FaceTracker;
	
	
	import com.parsera.ui.Ball;
	import com.parsera.ui.Counter;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Parsera
	$(CBI)*/
	public class Scene extends Sprite
	{
		private var scene_main:SceneMain;
		
		private var scene_sp:Sprite;
	
		
		private var ball:Ball;
		private var counter:Counter = new Counter();
		public function Scene() 
		{
			init();
		}
		
		var faceDetect:FaceTracker
		private function init():void {
			
			
			
			scene_sp = new scene_symbol();
			addChild(scene_sp);
			
			scene_main = new SceneMain(this);
			addChild(scene_main);
			
			ball = new Ball(App.appWidth, App.appHeight, true);
			
			
			faceDetect = new FaceTracker(ball);
			addChild(faceDetect);		
			
			addChild(ball);
			ball.start();
			App.appStage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			showMain();
			
			addEventListener(Ball.ON_BALL_KICK, ball_kick);
			addEventListener(Ball.ON_BALL_OUT, ball_out);
			
			addChild(counter);
			counter.x = App.appWidth;
			counter.y = 0;
		}
		
		private function keyHandler(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) {
				if (ball.isRun) {
					ball.stop();
				} else {
					ball.start();
				}
			} else if (e.keyCode == Keyboard.RIGHT) {
				ball.kick(new Point(3, -20));
			} else if (e.keyCode == Keyboard.LEFT) {
				ball.kick(new Point(-6, -12));
			} else if (e.keyCode == 80) {
				ball.stop();
			}else if (e.keyCode == 83) {
				ball.start();
			}
		}
		
		public function showMain():void {
			hideAll();
			scene_main.show();
		}
		
		private function hideAll():void {
			scene_main.hide();
		}
		
		private function ball_kick(e:Event) 
		{
			counter.update("score");
		}
		
		private function ball_out(e:Event) {
			counter.update("reset");
		}
		
		
		
		//**
		public function CloseCamera() {
			faceDetect.CloseCamera();
		}
		
		public function BallStop() {
			ball.stop();
		}
	}
	
}