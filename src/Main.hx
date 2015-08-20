package;

import core.Camera;
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
	private var _camera:Camera;
	private var _cX:Float;
	private var _cY:Float;
	
	public function new() 
	{
		super();
		
		_baseWidth = Lib.current.stage.stageWidth;
		_baseHeight = Lib.current.stage.stageHeight;
		
		_map = new TileMap(Assets.getBitmapData("img/tilesets/32x32_ortho_dungeon_tile_Denzi110515-1.png"));
		_map.init("info/dungeonTiles.json");
		_map.drawMapFromCsv("info/dungeonMap.json");
		
		var maxWidth = _map.offsetX * 15;
		var maxHeight = _map.offsetY * 12;
		
		_camera = new Camera(_map, maxWidth, maxHeight);
		_cX = _camera.x = _baseWidth / 2 - _camera.renderWidth / 2;
		_cY = _camera.y = _baseHeight / 2 - _camera.renderHeight / 2;
		
		addChild(_camera);
		
		timeStarted = 0;
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var elapsed = Lib.getTimer();
			var deltaTime = elapsed - timeStarted;
			timeStarted = elapsed;
			
			var speed = 0.05;
			
			//_camera.move(speed * deltaTime + _camera.scrollRect.x, speed * deltaTime + _camera.scrollRect.y);
			
		});
		
		Lib.current.stage.addEventListener(Event.RESIZE, function(e)
		{
			if (!_inited)
			{
				_inited	= true;
			}
			else 
			{
				_camera.scaleX = Lib.current.stage.stageWidth / _baseWidth;
				_camera.scaleY = Lib.current.stage.stageHeight / _baseHeight;
				
				_camera.x = _cX;
				_camera.y = _cY;
				
			}
		});
		
	}
	
}
