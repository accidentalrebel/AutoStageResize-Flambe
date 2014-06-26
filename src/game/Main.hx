package game;

import flambe.Entity;
import flambe.input.PointerEvent;
import flambe.input.TouchPoint;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;

class Main
{
	static private var _planeSprite:ImageSprite;
	
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
		_planeSprite = new ImageSprite(pack.getTexture("plane"));
		_planeSprite.centerAnchor();
		
        System.root.addChild(new Entity().add(_planeSprite));
	}
	
	static private function setupTouchListeners() 
	{
		System.pointer.down.connect(onTouchDown);
	}
	
	// ============================================= EVENTS ============================================= //
	static private function onTouchDown(pointerEvent : PointerEvent) 
	{
		var xPos : Float = pointerEvent.viewX;
		var yPos : Float = pointerEvent.viewY;
		_planeSprite.setXY(xPos, yPos);
	}
}
