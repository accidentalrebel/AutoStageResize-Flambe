package game;

import flambe.display.Font;
import flambe.display.TextSprite;
import flambe.Entity;
import flambe.input.PointerEvent;
import flambe.input.TouchPoint;
import flambe.math.Point;
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
		
		// We setup the mainstage here
		MainStage.init(960, 560);
		
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
		setupBackgroundImage();
		setupTextSprite(pack);
		setupPlane(pack);
		setupTouchListeners();
    }
	
	// ============================================= SETUP ============================================= //
	static private function setupBackgroundImage() 
	{
		// Notice that instead of using System.stage.width and System.stage.height
		// We are using MainStage.width and MainStage.height
		// This is actually, 960x560 which we passed to MainStage.init
        var backgroundSprite : FillSprite = new FillSprite(0xFFFFFF, MainStage.width, MainStage.height);
        System.root.addChild(new Entity().add(backgroundSprite));
	}
	
	static private function setupTextSprite(pack : AssetPack) 
	{
		var stringToShow : String = "Flambe AutoStageResize Test\nby AccidentalRebel.\n\n"
			+ "Resize your browser to see the stage resizing in action.\n\n"
			+ "Click anywhere to change the position of the plane.";
		
		var arialFont : Font = new Font(pack, "arial");
		var textSprite : TextSprite = new TextSprite(arialFont, stringToShow);
		textSprite.align = TextAlign.Center;
		textSprite.anchorY._ = textSprite.getNaturalHeight() / 2;
		textSprite.setXY(MainStage.width / 2, MainStage.height / 2);
		
		System.root.addChild(new Entity().add(textSprite));
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
		// Since pointerEvent.viewX and viewY are positions relative to the screen
		// we need to convert these values so that it is in relation to the MainStage
		var adjustedPosition : Point = MainStage.convertToMainStageCoordinates(new Point(pointerEvent.viewX, pointerEvent.viewY));
		_planeSprite.setXY(adjustedPosition.x, adjustedPosition.y);
	}
}
