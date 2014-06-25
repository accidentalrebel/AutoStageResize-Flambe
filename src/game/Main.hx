package game;

import flambe.Entity;
import flambe.input.TouchPoint;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;

class Main
{
    private static function main ()
    {
        System.init();
		
		// We setup the mainstage
		MainStage.init(960, 560);
		
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
		setupBackgroundImage();
		setupPlane(pack);
		setupTouchListeners();
    }
	
	// ============================================= SETUP ============================================= //
	static private function setupBackgroundImage() 
	{
		// Notice that instead of using System.stage.width and System.stage.height
		// We are using MainStage.width and MainStage.height
		// This is actually, 960x560 which we passed to MainStage.init
        var background = new FillSprite(0x202020, MainStage.width, MainStage.height);
        System.root.addChild(new Entity().add(background));
	}
	
	static private function setupPlane(pack : AssetPack) 
	{
		var plane = new ImageSprite(pack.getTexture("plane"));
        System.root.addChild(new Entity().add(plane));
	}
	
	static private function setupTouchListeners() 
	{
		System.touch.down.connect(onTouchDown);
	}
	
	// ============================================= EVENTS ============================================= //
	static private function onTouchDown(touchPoint : TouchPoint) 
	{
		trace("Touch detected!");
	}
}
