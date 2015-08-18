package;

import core.TileMap;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Timer;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.events.TimerEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFieldType;

class Main extends Sprite 
{
	
	private var timeStarted:Int;
	private var _object:Bitmap;
	private var _planets:BitmapData;
	private var _render:BitmapData;
	private var _baseWidth:Int;
	private var _baseHeight:Int;
	private var _inited:Bool;
	private var _txtField:TextField;
	private var _map:TileMap;
	
	public function new() 
	{
		super();
		
		//_baseWidth = Lib.current.stage.stageWidth;
		//_baseHeight = Lib.current.stage.stageHeight;
		//
		//_planets = Assets.getBitmapData("img/Planets.png");
		//
		//_render = new BitmapData(_planets.width, _planets.height, true, 0xFF000000);
		//_render.copyPixels(_planets, new Rectangle(0, 0, _planets.width, _planets.height), new Point());
		//
		//_object = new Bitmap(_render);
		//
		//_object.scaleX = Lib.current.stage.stageWidth / _object.width;
		//_object.scaleY = Lib.current.stage.stageHeight / _object.height;
		//
		//_txtField = new TextField();
		//_txtField.defaultTextFormat = new TextFormat(Assets.getFont("font/OpenSans-Bold.ttf").fontName, 32, 0xFFFFFF);
		//_txtField.embedFonts = true;
		//_txtField.autoSize = TextFieldAutoSize.LEFT;
		//_txtField.selectable = false;
		//_txtField.text = "RPGFL Tutorial";
		//_txtField.x = _baseWidth / 2 - _txtField.width / 2;
		//_txtField.y = 10;
		//
		//addChild(_object);
		//addChild(_txtField);
		
		_map = new TileMap(Assets.getBitmapData("img/tilesets/32x32_ortho_dungeon_tile_Denzi110515-1.png"));
		_map.init("info/dungeonTiles.json");
		_map.drawMap("info/dungeonMap.json");
		
		addChild(_map);
		
		timeStarted = 0;
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var elapsed = Lib.getTimer();
			var deltaTime = elapsed - timeStarted;
			timeStarted = elapsed;
			
		});
		
		Lib.current.stage.addEventListener(Event.RESIZE, function(e)
		{
			//if (!_inited)
			//{
				//_inited	= true;
			//}
			//else 
			//{
				//scaleX = Lib.current.stage.stageWidth / _baseWidth;
				//scaleY = Lib.current.stage.stageHeight / _baseHeight;
			//}
		});
		
	}
	
}
