package com.parsera.ui
{
	import com.quasimondo.bitmapdata.CameraBitmap;
	import fl.motion.Color;
	import fl.motion.easing.Circular;
	import flash.external.ExternalInterface;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import jp.maaash.ObjectDetection.ObjectDetector;
	import jp.maaash.ObjectDetection.ObjectDetectorEvent;
	import jp.maaash.ObjectDetection.ObjectDetectorOptions;
	import com.App;
	import flash.display.BlendMode;
	import com.parsera.ui.Ball;
	import com.parsera.utils.Circle;
	
	public class FaceTracker extends Sprite
	{
		
		private var detector    :ObjectDetector;
		private var options     :ObjectDetectorOptions;
		
		private var view :Sprite;
		private var faceRectContainer :Sprite;
		private var tf :TextField;
		
		private var camera:CameraBitmap;
		private var detectionMap:BitmapData;
		private var detectionMapPre:BitmapData;
		
		private var motion_bmd:BitmapData;
		private var lastFace:BitmapData;
		private var detectionMapMerge:BitmapData;
		private var background_bmd:BitmapData;
		private var drawMatrix:Matrix;
		private var scaleFactor:int = 4;
		private var w:int = 640;
		private var h:int = 480;
		
		private var lastTimer:int = 0;
		private var faceColor:uint = 0;
		private var faceColorPre:uint = 0;
		private var faceColorArray:Array ;
		
		private var faceColorMin:uint ;
		private var faceColorMax:uint;
		private var lastRect:Rectangle;
		private var motion_bm:Bitmap;
		private var background_bm:Bitmap;
		private var lastMotion:Rectangle;
		private var rectArray:Array;
		
		
		private var preMotion_rect:Rectangle;
		
		private var LEFT:Number = 1;
		private var DOWN:Number = 2;
		private var RIGHT:Number = 3;
		private var UP:Number; 4;
		private var ball:Ball;
		
		private var head:Circle;
		private var speedY:Number = 0;
		private var mirrorMatrix:Matrix;
		public function FaceTracker(_ball:Ball) {
			initUI();
			initDetector();
			ball = _ball;
			
		}

		private function initUI():void{
			App.appStage.scaleMode = StageScaleMode.NO_SCALE;
			App.appStage.align = StageAlign.TOP_LEFT;

			view = new Sprite;
			addChild(view);
			
			camera = new CameraBitmap( w, h, 15 );
			camera.addEventListener( Event.RENDER, cameraReadyHandler );
			
			view.addChild( new Bitmap( camera.bitmapData ));
			
			view.scaleX = App.appWidth / this.w;
			view.scaleY = App.appHeight / this.h;
			
			detectionMap = new BitmapData( w / scaleFactor, h / scaleFactor, false, 0 );
			drawMatrix = new Matrix( 1/ scaleFactor, 0, 0, 1 / scaleFactor );
			
			
			mirrorMatrix = new Matrix();
			
			//mirrorMatrix.tx=detectionMap.width;
			mirrorMatrix.scale( -1, 1);
			mirrorMatrix.translate(detectionMap.width,0);
			
			faceRectContainer = new Sprite;
			view.addChild( faceRectContainer );
			
			
			motion_bmd = new BitmapData(detectionMap.width,detectionMap.height,true,0x00000000);
			
			motion_bm= new Bitmap(motion_bmd);
			motion_bm.x = 000;
			motion_bm.y = 100;
			//view.addChild(motion_bm);
			
			background_bmd = new BitmapData(detectionMap.width,detectionMap.height,true,0x00000000);
			background_bm= new Bitmap(background_bmd);
			background_bm.x = 100;
			background_bm.y = 0;
			//view.addChild(background_bm);
			rectArray = new Array();
			
			
			
		}

		private function cameraReadyHandler( event:Event ):void
		{
			detectionMap.draw(camera.bitmapData, drawMatrix, null, "normal", null, true);
			//detectionMap.draw(detectionMap, mirrorMatrix);
			
			motion_bmd.merge(detectionMap, detectionMap.rect, new Point(), 0xFF, 0xFF, 0xFF, 0xFF);
			background_bmd.merge(detectionMap, detectionMap.rect, new Point(), 0x30, 0x30, 0x30, 0x30);
			
			detector.detect( detectionMap );
		}

		private function initDetector():void
		{
			detector = new ObjectDetector();
			
			var options:ObjectDetectorOptions = new ObjectDetectorOptions();
			options.min_size  = 30;
			detector.options = options;
			detector.addEventListener(ObjectDetectorEvent.DETECTION_COMPLETE, detectionHandler );
		}
		
		
		
		private function detectionHandler( e :ObjectDetectorEvent ):void
		{
			
			var g :Graphics = faceRectContainer.graphics;
			
			
			g.clear();
			g.lineStyle( 2 );
			
			//trace("faceColorPre " + faceColorPre);
			/*
			if (detectionMapMerge == undefined) {
					trace("detectionMapMerge Empty");
					detectionMapMerge = detectionMap.clone();
			}else {
					detectionMapMerge.merge(detectionMap, detectionMap.rect, new Point(0, 0), 0x80, 0x80, 0x80, 0xFF);
			}
			*/
			
			
			if ( e.rects.length > 0 && e.rects[0].width * e.rects[0].height>0) {
				
				
			
				
				
				
				lastFace = detectionMap.clone();
				lastRect = e.rects[0];
				head = new Circle(new Point((lastRect.x +lastRect.width / 2 )*scaleFactor*view.scaleX, (lastRect.y + lastRect.height / 2 )*scaleFactor*view.scaleY), Math.sqrt(Math.pow(lastRect.width*view.scaleX, 2) + Math.pow(lastRect.height*view.scaleY, 2))*scaleFactor/2 );
				faceColor=centerColor(detectionMap, e.rects[0]);
				//faceColor = minColor(detectionMap, e.rects[0]);
				//faceColor = histoColor(detectionMap, e.rects[0]);
				//faceColorArray = get5Sample(detectionMap, e.rects[0]);
				
				//faceColorMin = minColor(detectionMap , e.rects[0]);
				//faceColorMax = maxColor(detectionMap , e.rects[0]);
				
				// black 2pix
				
				//if (faceColorPre == 0) {
				///		faceColorPre = faceColor;
				//}
				//faceColorPre = 0xFF000000 | (faceColor >> 16 & 0xFF + faceColorPre >> 16 & 0xFF) / 2  | (faceColor >> 8 & 0xFF + faceColorPre >> 8 & 0xFF) / 2 | (faceColor & 0xFF + faceColorPre  & 0xFF) / 2;
				
				/*
				e.rects.forEach( function( r :Rectangle, idx :int, arr :Array ) :void {
					g.drawRect( r.x * scaleFactor, r.y * scaleFactor, r.width * scaleFactor, r.height * scaleFactor );
				});
				*/
				//g.drawCircle(head.p.x, head.p.y, head.r);
				//g.drawCircle(ball.getPosition().p.x, ball.getPosition().p.y, ball.getPosition().r);
				
				
				
				
			}
			//if (faceColorArray!=null && faceColorArray.length>0  && lastRect!=null) {
				//
				//find5Color(detectionMap, faceColorArray, 3 , lastRect);
			//}
			
			if (e.rects.length==0 && lastRect!=null  && lastRect.width * lastRect.height>0) {
					//trace("lastFace here");
					var rectMotion:Rectangle = motionTrack();
					
					var direction:int = LEFT;
					
					if (rectMotion.width * rectMotion.height > 0) {
							
							direction = findMotionDirection(lastMotion, rectMotion);
							lastMotion=rectMotion;
					}
					
					//trace("lastRect " + lastRect + " lastMotion" + lastMotion );
				    rectMotion = getAverageRect(lastRect, lastMotion , direction, 10);
					head = new Circle(new Point((rectMotion.x +rectMotion.width / 2 )*scaleFactor *view.scaleX, (rectMotion.y + rectMotion.height / 2 )*scaleFactor*view.scaleY), Math.sqrt(Math.pow(rectMotion.width *view.scaleX, 2) + Math.pow(rectMotion.height *view.scaleY, 2))*scaleFactor/2 );
					//trace(rectMotion);
					//g.drawRect( rectMotion.x * scaleFactor, rectMotion.y * scaleFactor, rectMotion.width * scaleFactor, rectMotion.height * scaleFactor );
					
			}
			
			var hitPoint:Point = ball.getPosition().hitTest(head);
			var hitVector:Point = ball.getPosition().hitVector(head,20);
			//trace("hit Point" + hitPoint);
			if (head != null) {
				//trace(head.p);
				//faceRectContainer.graphics.moveTo(head.p.x, head.p.y);
				//faceRectContainer.graphics.lineTo(ball.getPosition().p.x, ball.getPosition().p.y);
			}
			
			if (hitPoint != null) {
				faceRectContainer.graphics.beginFill(0xFFFF0000);
				//g.drawRect( hitPoint.x , hitPoint.y, 10, 10 );
				faceRectContainer.graphics.endFill();
				ball.kick(hitVector);
				
			}
		
			
			if (faceColor != 0 && lastRect!=null) {
				
				//findColor(detectionMap, faceColor, 10,lastRect);
				//findMinMaxColor(detectionMap, faceColorMin, faceColorMax,10, lastRect);
				
			}	
			
			detectionMapPre = detectionMap.clone();
			
			
			
		}

		private function histoColor(source:BitmapData, rect:Rectangle):uint {
		
			var histo:Vector.<Vector.<Number>> ;
			histo = source.histogram(rect);
			var channel:Vector.<Number>;
			var maxValue:Number, value:Number;
			var j:int, i:int;
			var r:int, g:int, b:int;
			var color:uint;
			for (var c:int = 0; c < 3; c++) {
				
				channel = histo[c];
				maxValue =0.0;
				i = 256;
				while ( i > 0 ) {
					value = channel[--i];
					if ( value > maxValue )  
					{
						maxValue = value;
						if (c == 0) {
							r = i;						
						}
						if (c == 1) {
							g = i;						
						}
						if (c == 2) {
							b = i ;						
						}
					}
				}
				
				
			}
			color = (0xFF000000 | r << 16 |  g << 8 | b);
				//trace (color);
				return 0xFF000000 | r << 16 |  g << 8 | b; 
			
		}
		
		private function centerColor(source:BitmapData , rect:Rectangle) :uint {
			
			var r :int = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height*3/4) >> 16 &0xFF;
			var g: int = source.getPixel(rect.x + rect.width*3/4,rect.y + rect.height*3/4) >> 8 & 0xFF;
			var b:int = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height*3/4) & 0xFF;
			
			return 0xFF000000 | r << 16 |  g << 8 | b; 
			
		}
		private function get5Sample(source:BitmapData , rect:Rectangle):Array {
			
			var colorArray:Array = new Array();
			var r :int = source.getPixel(rect.x + rect.width/2, rect.y + rect.height/2) >> 16 &0xFF;
			var g: int = source.getPixel(rect.x + rect.width/2,rect.y + rect.height/2) >> 8 & 0xFF;
			var b:int = source.getPixel(rect.x + rect.width/2, rect.y + rect.height/2) & 0xFF;
			
			colorArray[0] =  0xFF000000 | r << 16 |  g << 8 | b; 
			
			
			r = source.getPixel(rect.x + rect.width/4, rect.y + rect.height/4) >> 16 &0xFF;
			g = source.getPixel(rect.x + rect.width/4,rect.y + rect.height/4) >> 8 & 0xFF;
			b = source.getPixel(rect.x + rect.width / 4, rect.y + rect.height / 4) & 0xFF;
			colorArray[1] =  0xFF000000 | r << 16 |  g << 8 | b;
			
			r = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height/4) >> 16 &0xFF;
			g = source.getPixel(rect.x + rect.width*3/4,rect.y + rect.height/4) >> 8 & 0xFF;
			b = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height / 4) & 0xFF;
			colorArray[2] =  0xFF000000 | r << 16 |  g << 8 | b;
			
			r = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height*3/4) >> 16 &0xFF;
			g = source.getPixel(rect.x + rect.width*3/4,rect.y + rect.height*3/4) >> 8 & 0xFF;
			b = source.getPixel(rect.x + rect.width*3/4, rect.y + rect.height*3/4) & 0xFF;
			colorArray[3] =  0xFF000000 | r << 16 |  g << 8 | b;
			
			r = source.getPixel(rect.x + rect.width/4, rect.y + rect.height*3/4) >> 16 &0xFF;
			g = source.getPixel(rect.x + rect.width/4,rect.y + rect.height*3/4) >> 8 & 0xFF;
			b = source.getPixel(rect.x + rect.width/4, rect.y + rect.height*3/4) & 0xFF;
			colorArray[4] =  0xFF000000 | r << 16 |  g << 8 | b;
			
			return colorArray;
		}
		
		function maxColor(source:BitmapData , rect:Rectangle) :uint {
			var max:uint =0;
			var maxColor:uint = 0;
			var px :uint;
			var rn:int, gn:int, bn:int;
			
			var i = rect.x + rect.width/2;
			for (var j = 0; j <  rect.height; j = j + 8)
			{

					px = source.getPixel(i,rect.height + j);
				
					rn = px >> 16 & 0xFF;
					gn = px >> 8 & 0xFF;
					bn = px & 0xFF;
				
					if (max < (rn + gn + bn) / 3) {
							max = (rn + gn + bn) / 3;
							maxColor = px;
					}
					source.setPixel(i,rect.y+ j, 0xFFFF0000);
					
			} 
			return 0xFF000000 | maxColor;	
		}
		
		function minColor(source:BitmapData , rect:Rectangle) :uint {
			var min:uint =255;
			var minColor:uint = 0;
			var px :uint;
			var rn:int, gn:int, bn:int;
			var i = rect.x  + rect.width / 4;
			for (var j = rect.height/5; j < rect.height*4/5; j = j + 1)
			{

					px = source.getPixel(i, rect.y +j);
				
					rn = px >> 16 & 0xFF;
					gn = px >> 8 & 0xFF;
					bn = px & 0xFF;
				
					if (min > (rn + gn + bn) / 3) {
							min = (rn + gn + bn) / 3;
							minColor = px;
					}
					faceRectContainer.graphics.beginFill(0xFFFF0000);
					faceRectContainer.graphics.drawCircle(i * scaleFactor, (rect.y  +j) * scaleFactor, 1);
					faceRectContainer.graphics.endFill();
					
			} 
			return 0xFF000000 | minColor;	
		}
		
		
		private function findMinMaxColor(source:BitmapData , minColor:uint , maxColor:uint, sts:int, rect:Rectangle) {
			var g :Graphics = faceRectContainer.graphics;
			
			g.lineStyle(2);
			var px;
			var rn:int, gn:int, bn:int;
			var ptDict:Dictionary = new Dictionary();
			var minArray:Array = new Array();
			var it:int = 0;
			var minX:int = source.width;
			var maxX:int = 0;
			var minY:int = source.height;
			var maxY:int = 0;
			
			var center:Point = new Point(rect.x + rect.width / 2 , rect.y + rect.height);
			
				for (var i = 0; i < source.width; i = i + 8)
				{
					for (var j = 0; j < source.height; j = j + 8)
					{

							px = source.getPixel(i, j);
						
							rn = px >> 16;
							gn = px >> 8 & 255;
							bn = px & 255;
						
							if ((    rn < ((minColor >> 16 & 0xFF) + sts) && 
									rn > ((minColor >> 16 & 0xFF) - sts) && 
									gn < ((minColor >> 8 & 0xFF) + sts) && 
									gn > ((minColor >> 8 & 0xFF) - sts) && 
									bn < ((minColor & 0xFF) + sts) && 
									bn > ((minColor & 0xFF) - sts))
									||
									
									(    rn < ((maxColor >> 16 & 0xFF) + sts) && 
									rn > ((maxColor >> 16 & 0xFF) - sts) && 
									gn < ((maxColor >> 8 & 0xFF) + sts) && 
									gn > ((maxColor >> 8 & 0xFF) - sts) && 
									bn < ((maxColor & 0xFF) + sts) && 
									bn > ((maxColor & 0xFF) - sts))
									)
							{
								//source.fillRect(new Rectangle(i, j, 5, 5), 0xFFFF0000);
								
								//g.drawRect( i * scaleFactor, j*scaleFactor, 3, 3 );
								
								
								
							
								
								
							}

					} 
				}
					
				
		}
		
		private function findColor(source:BitmapData, color:uint , sts:int,rect:Rectangle) {
			var g :Graphics = faceRectContainer.graphics;
			
			g.lineStyle(2);
			var px;
			var rn:int, gn:int, bn:int;
			var ptDict:Dictionary = new Dictionary();
			var minArray:Array = new Array();
			var it:int = 0;
			var minX:int = source.width;
			var maxX:int = 0;
			var minY:int = source.height;
			var maxY:int = 0;
			
			var center:Point = new Point(rect.x + rect.width / 2 , rect.y + rect.height);
			
			for (var i = 0; i < source.width; i = i + 8)
			{
				for (var j = 0; j < source.height; j = j + 8)
				{

						px = source.getPixel(i, j);
					
						rn = px >> 16;
						gn = px >> 8 & 255;
						bn = px & 255;
					
						if (    rn < ((color >> 16 & 0xFF) + sts) && 
								rn > ((color >> 16 & 0xFF) - sts) && 
								gn < ((color >> 8 & 0xFF) + sts) && 
								gn > ((color >> 8 & 0xFF) - sts) && 
								bn < ((color & 0xFF) + sts) && 
								bn > ((color & 0xFF) - sts))
						{
							//source.fillRect(new Rectangle(i, j, 5, 5), 0xFFFF0000);
							
							//g.drawRect( i * scaleFactor, j*scaleFactor, 3, 3 );
							
							
							
						
							
							
						}
						
						
						
									
						
				
				} 
			} 
			
			
		}
		
		private function find5Color(source:BitmapData, colorArray:Array , sts:int,rect:Rectangle) {
			var g :Graphics = faceRectContainer.graphics;
			
			g.lineStyle(2);
			var px;
			var rn:int, gn:int, bn:int;
			var ptDict:Dictionary = new Dictionary();
			var minArray:Array = new Array();
			var it:int = 0;
			var minX:int = source.width;
			var maxX:int = 0;
			var minY:int = source.height;
			var maxY:int = 0;
			
			var center:Point = new Point(rect.x + rect.width / 2 , rect.y + rect.height);
			
			for (var i = 0; i < source.width; i = i + 4)
			{
				for (var j = 0; j < source.height; j = j + 4)
				{

						px = source.getPixel(i, j);
					
						rn = px >> 16;
						gn = px >> 8 & 255;
						bn = px & 255;
					
						if ((    rn < ((colorArray[0] >> 16 & 0xFF) + sts) && 
								rn > ((colorArray[0] >> 16 & 0xFF) - sts) && 
								gn < ((colorArray[0] >> 8 & 0xFF) + sts) && 
								gn > ((colorArray[0] >> 8 & 0xFF) - sts) && 
								bn < ((colorArray[0] & 0xFF) + sts) && 
								bn > ((colorArray[0] & 0xFF) - sts))
							|| 
								( rn < ((colorArray[1] >> 16 & 0xFF) + sts) && 
								rn > ((colorArray[1] >> 16 & 0xFF) - sts) && 
								gn < ((colorArray[1] >> 8 & 0xFF) + sts) && 
								gn > ((colorArray[1] >> 8 & 0xFF) - sts) && 
								bn < ((colorArray[1] & 0xFF) + sts) && 
								bn > ((colorArray[1] & 0xFF) - sts))
								||
								(    rn < ((colorArray[2] >> 16 & 0xFF) + sts) && 
								rn > ((colorArray[2] >> 16 & 0xFF) - sts) && 
								gn < ((colorArray[2] >> 8 & 0xFF) + sts) && 
								gn > ((colorArray[2] >> 8 & 0xFF) - sts) && 
								bn < ((colorArray[2] & 0xFF) + sts) && 
								bn > ((colorArray[2] & 0xFF) - sts))
								||
								(    rn < ((colorArray[3] >> 16 & 0xFF) + sts) && 
								rn > ((colorArray[3] >> 16 & 0xFF) - sts) && 
								gn < ((colorArray[3] >> 8 & 0xFF) + sts) && 
								gn > ((colorArray[3] >> 8 & 0xFF) - sts) && 
								bn < ((colorArray[3] & 0xFF) + sts) && 
								bn > ((colorArray[3] & 0xFF) - sts))
								||
								(    rn < ((colorArray[4] >> 16 & 0xFF) + sts) && 
								rn > ((colorArray[4] >> 16 & 0xFF) - sts) && 
								gn < ((colorArray[4] >> 8 & 0xFF) + sts) && 
								gn > ((colorArray[4] >> 8 & 0xFF) - sts) && 
								bn < ((colorArray[4] & 0xFF) + sts) && 
								bn > ((colorArray[4] & 0xFF) - sts))
								)
						{
							//source.fillRect(new Rectangle(i, j, 5, 5), 0xFFFF0000);
							
							//g.drawRect( i * scaleFactor, j*scaleFactor, 3, 3 );

							
						}
						
				} 
			} 
			
			
		}
		
		function motionTrack():Rectangle {
			//motion_bmd.draw(background_bmd, null, null, BlendMode.DIFFERENCE);
			motion_bmd.draw(detectionMapPre, null, null, BlendMode.DIFFERENCE);
			motion_bmd.threshold(motion_bmd, motion_bmd.rect, new Point(), '>', 0xFF333333, 0xFFFFFFFF);
			var area : Rectangle = motion_bmd.getColorBoundsRect(0xFFFFFFFF, 0xFFFFFFFF, true);
			motion_bmd.fillRect(area, 0xFFFF0000);
			return area;
		}
		
		
		function getAverageRect(r1:Rectangle, r2:Rectangle,direction:int, ratio:int):Rectangle {
			
				
				if(r2!=null && r2.width*r2.height>0){
					
					var width:int = r1.width;
					var heigth:int = r1.height;
					var x, y;
					if (direction == RIGHT) {
						
						 x = r2.x + r2.width - r1.width;
						 y = r2.y;
						//trace("x " + x  + "y " +  y);
					}else {
						x  = r2.x ;
						y = r2.y ;
					}
					
					
					//var x :int = r2.x +r2.width- r1.width;
					//var y :int = r2.y +r2.width -r1.height;
					
					return new Rectangle(x, y, width, heigth);
				}
				
				return r1;
		}
		
		function findMotionDirection(motion1:Rectangle, motion2:Rectangle) :int {
			
			
			if (motion1 == null || motion1.x*motion1.y==0) {
					return LEFT;
			}
			/*
			if (Math.abs(motion1.width - motion2.height) < 5) {
				return	LEFT;	
			}*/
			
			if ( motion1.width < motion2.width && motion1.x + motion1.width < motion2.x + motion2.width ) {
					//trace("RIGHT");
					return RIGHT;
			}
			else if (motion1.width < motion2.width && motion1.x + motion1.width > motion2.x + motion2.width) {
					//trace("LEFT");
					return LEFT;
			}else if (motion1.width > motion2.width && motion1.x + motion1.width > motion2.x + motion2.width) {
					//trace("LEFT");
					return LEFT;
			}else if (motion1.width > motion2.width && motion1.x + motion1.width < motion2.x + motion2.width) {
					//trace("RIGHT");
					return RIGHT;
			}
			
			return LEFT;
		}
		
		function calcHitVector(xSpeed:Number,alpha:Number) {
			
			
		}
		
		public function CloseCamera() {
			camera.close();
		}
		
	}
}
