package com.parsera.ui 
{
	import com.App;
	
	import com.parsera.utils.Utils;
	import flash.display.Sprite;
	
	/**
	$(CBI)* ...
	$(CBI)* @author Parsera
	$(CBI)*/
	public class SceneMain extends Sprite
	{
		
		private var scene:Scene;
		
		private var scene_main_sp:Sprite;
		
		public function SceneMain(scene:Scene) 
		{
			this.scene = scene;
			init();
		}
		
		private function init():void {
			
			trace("SceneMain init");
			
			scene_main_sp = new scene_main_symbol();
			addChild(scene_main_sp);
			
			hide();
		}
		
		public function show():void {
			visible = true;
			//scene.showAlert("Hasan");
		}
		
		public function hide():void {
			visible = false;
		}
		
	}
	
}