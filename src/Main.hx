package;

import core.Camera;
import core.Player;
import core.TileMap;
import core.Unit;
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
    private var _render:BitmapData;
    private var _baseWidth:Int;
    private var _baseHeight:Int;
    private var _inited:Bool;
    private var _txtField:TextField;
    private var _map:TileMap;
    private var _camera:Camera;
    private var _ratioX:Float;
    private var _ratioY:Float;
    private var _ratioWidth:Float;
    private var _ratioHeight:Float;
    private var _player:Player;
    
    public function new() 
    {
        super();
        
        _baseWidth = Lib.current.stage.stageWidth;
        _baseHeight = Lib.current.stage.stageHeight;
        
        _map = new TileMap(Assets.getBitmapData("img/tilesets/32x32_ortho_dungeon_tile_Denzi110515-1.png"));
        _map.init("info/dungeonTiles.json");
        _map.drawMapFromCsv("info/dungeonMap.json");
        
        _player = new Player("img/spritesheets/healer_f.png", "info/playerAnimation.json");
        _player.draw(_map, 64, 64);
        
        var maxWidth = _map.offsetX * 15;
        var maxHeight = _map.offsetY * 12;
        
        _camera = new Camera(_map, maxWidth, maxHeight);
        _camera.x = _baseWidth / 2 - maxWidth / 2;
        _camera.y = _baseHeight / 2 - maxHeight / 2;
        _ratioX = _camera.x / _baseWidth;
        _ratioY = _camera.y / _baseHeight;
        _ratioWidth = maxWidth / _baseWidth;
        _ratioHeight = maxHeight / _baseHeight;
        
        addChild(_camera);
        
        timeStarted = 0;
        
        Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(e:Event)
        {
            var elapsed = Lib.getTimer();
            var deltaTime = elapsed - timeStarted;
            timeStarted = elapsed;
        });
        
        Lib.current.stage.addEventListener(Event.RESIZE, function(e)
        {
            if (!_inited)
            {
                _inited = true;
            }
            else 
            {
                _camera.x = _ratioX * stage.stageWidth;
                _camera.y = _ratioY * stage.stageHeight;
                _camera.resize(_ratioWidth, _ratioHeight);
            }
        });
        
    }
    
}
