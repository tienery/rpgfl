package core;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.Assets;
import openfl.utils.Timer;
import openfl.events.TimerEvent;
import haxe.Json;

class Animation extends Bitmap
{
    
    private var _spritesheet:BitmapData;
    private var _indexes:Array<Point> = [];
    private var _bitmap:Bitmap;
    public var states:Map<String, Array<Int>>;
    private var _cellWidth:Int;
    private var _cellHeight:Int;
    private var _timer:Timer;
    private var _currentIndex:Int;
    private var _currentStateName:String;
    private var _currentStateLength:Int;
    private var _goBack:Bool;
    private var _goingBack:Bool;

    public function new(bitmapData:BitmapData) 
    {
        super();
        
        _spritesheet = bitmapData;
        
        _timer = new Timer(500);
    }
    
    public function init(path:String)
    {
        var contents:Dynamic = Json.parse(Assets.getText(path));
        
        _cellWidth = contents.cellWidth;
        _cellHeight = contents.cellHeight;
        
        states = new Map<String, Array<Int>>();
        
        for (i in 0...contents.states.length)
        {
            var state:Dynamic = contents.states[i];
            
            states.set(state.name, state.animation);
        }
        
        for (i in 0...contents.sheet.length)
        {
            var item:Dynamic = contents.sheet[i];
            
            _indexes.push(new Point(item.x, item.y));
        }
    }
    
    public function switchState(stateName:String, ?startIndex:Int=0)
    {   
        if (states.exists(stateName))
        {
            getStateAnimate(stateName, startIndex);
            
            bi.copyPixels(_spritesheet, new Rectangle(point.x, point.y, _cellWidth, _cellHeight), new Point(0, 0));
            bitmapData = bi;
        }
    }
    
    public function play(stateName:String, ?startIndex:Int=0, ?repeat:Int=0, ?goBack:Bool=false)
    {
        if (states.exists(stateName))
        {
            getStateAnimate(stateName, startIndex);
            
            _currentStateName = stateName;
            
            _timer.repeatCount = repeat;
            _timer.start();
            _timer.addEventListener(TimerEvent.TICK, nextAnimation);
        }
    }
    
    public function stop()
    {
        _timer.reset();
    }
    
    private function getStateAnimate(stateName:String, ?startIndex:Int=0)
    {
        var state = states.get(stateName);
        _currentStateLength = state.length;
        
        var first = state[startIndex];
        var bi = new BitmapData();
        var point = _indexes[first];
        _currentIndex = startIndex;
        
        bi.copyPixels(_spritesheet, new Rectangle(point.x, point.y, _cellWidth, _cellHeight), new Point(0, 0));
        bitmapData = bi;
    }
    
    private function nextAnimation(e:TimerEvent)
    {
        if (_currentIndex + 1 > _indexes.length - 1)
        {
            if (_goBack)
                _goingBack = !_goingBack;
            else
                _currentIndex = 0;
        }
        else if (_currentIndex - 1 < 0)
        {
            if (_goBack)
                _goingBack = !_goingBack;
            else
                _currentIndex = 0;
        }
        else
        {
            if (_goingBack && _goBack)
                _currentIndex--;
                else
                _currentIndex++;
        }
            
        getStateAnimate(_currentStateName, _currentIndex);
    }
    
}