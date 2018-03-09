package com.parsera.ui 
{
	
	import fl.motion.easing.Circular;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.ContextMenuEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.ui.ContextMenuBuiltInItems;
	import com.parsera.utils.Circle;
	public class Ball extends Sprite
	{
		
		public static var ON_BALL_KICK:String = "on_ball_kick";
		public static var ON_BALL_OUT:String = "on_ball_out";
		private var ball_mc:Sprite;
		
		private var ticker:Timer;
		
		private var innerBall_mc:Sprite = null;
		private var back_mc:Sprite = null;
		
		private var speedY:Number = 1;
		private var speedX:Number = 0;
		
		private var stageWidth:Number;
		private var stageHeight:Number;
		private var hasMouse:Boolean;
		
		public var isRun:Boolean = false;
		
		private var gravity:Number = .8;
		private var counter:int;
		public function Ball(stageWidth:Number, stageHeight:Number, hasMouse:Boolean = false) 
		{
			this.stageHeight = stageHeight;
			this.stageWidth = stageWidth;
			this.hasMouse = hasMouse;
			init();
			
		}
		
		private function init() {
			
			visible = false;
			
			x = 0;
			y = 0;
			
			ball_mc = new ball_symbol() as Sprite;
			addChild(ball_mc);

			innerBall_mc = ball_mc.getChildByName("innerBall_mc") as Sprite;
			back_mc = ball_mc.getChildByName("back_mc") as Sprite;
			
			ball_mc.y = 0;
			ball_mc.x = Math.random() * (stageWidth  - 2*back_mc.width) + back_mc.width;
			
			back_mc.useHandCursor = true;
			back_mc.buttonMode = true;
			
			if(hasMouse) {
				back_mc.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			}
			
			
        	ticker = new Timer(30);         	
            ticker.addEventListener(TimerEvent.TIMER, onTick);            
            
		}
		
		private function onTick(evt:TimerEvent):void 
        {
			counter++;
			if(ball_mc.y < stageHeight - back_mc.height / 2) {
				speedY += gravity;
				ball_mc.y += speedY;			
				ball_mc.x += speedX;
				
				/*
				if(ball_mc.y >= stageHeight - back_mc.height / 2 ) {
					ball_mc.y = stageHeight - back_mc.height / 2;
					speedY = -speedY * 3 / 4 ;				
					speedX = speedX * 3 / 4;
					if(speedY >= -2) {
						//ticker.stop();
						ball_mc.y = stageHeight - back_mc.height / 2;
						speedX = 0;
					} else {
						ball_mc.y--;
					}
				}
				*/
				
				if(ball_mc.y >= stageHeight - back_mc.height / 2 ) {
					ball_mc.y = -back_mc.height;
					speedY = 1;	
					dispatchEvent(new Event(ON_BALL_OUT, true));
				}
				
			}
			if(ball_mc.x < back_mc.width / 2) {
				ball_mc.x = back_mc.width / 2;
				speedX *= -1;
			} else if(ball_mc.x > stageWidth - back_mc.width / 2) {
				ball_mc.x = stageWidth - back_mc.width / 2;
				speedX *= -1;
			}
			
			
			if(speedX != 0) {
				innerBall_mc.rotation += speedX;
			}
				
        	
			
        }
        
        private function onClick(e:MouseEvent):void {
			kick(new Point( -(e.localX) / 5, -16));
		}
		
		public function start():void {
			ticker.start();
			visible = true;
			isRun = true;
			counter = 100;
		}
		
		public function stop():void {
			trace("ball stop");
			ticker.stop();
			//visible = false;
			isRun = false;
		}
		
		public function kick(vector:Point):void {
			//trace(vector);
			if(isRun && counter >20){
				speedX = vector.x;
				speedY = vector.y;;
				ball_mc.y--;
				counter = 0;			
				dispatchEvent(new Event(ON_BALL_KICK, true));
			}
		}
		public function getPosition():Circle {
			return new Circle(new Point(ball_mc.x, ball_mc.y), ball_mc.width / 2);
		}
	}

}