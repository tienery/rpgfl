package core;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.Assets;
import utils.CustomTimer;
import haxe.Json;

class Animation extends Bitmap
{
    
    private var _spritesheet:BitmapData;
    private var _indexes:Array<Point> = [];
    private var _bi:BitmapData;
    public var states:Map<String, Array<Int>>;
    private var _cellWidth:Int;
    private var _cellHeight:Int;
    private var _timer:CustomTimer;
    private var _currentIndex:Int;
    private var _currentStateName:String;
    private var _currentStateLength:Int;
    private var _goBack:Bool;
    private var _goingBack:Bool;

    public function new(bitmapData:BitmapData) 
    {
        super();
        
        _spritesheet        = bitmapData;
        _currentStateName   = "";
        _currentStateLength = 0;
        
        _timer = new CustomTimer(250);
    }
    
    public function init(path:String)
    {
        var contents:Dynamic = Json.parse(Assets.getText(path));
        
        _cellWidth = contents.cellWidth;
        _cellHeight = contents.cellHeight;
        
        _bi        = new BitmapData(_cellWidth, _cellHeight);
        _indexes   = [];
        bitmapData = _bi;
        states     = new Map<String, Array<Int>>();
        
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
            
        }
    }
    
    public function update(deltaTime:Float, stateName:String, ?startIndex:Int=0, ?goBack:Bool=false)
    {
        if (states.exists(stateName))
        {            
            
            if (_currentStateName != stateName)
            {
                getStateAnimate(stateName, startIndex);
                _currentIndex = startIndex;
            }
            _goBack = goBack;

            _timer.update(deltaTime);
            _timer.tick.add(nextAnimation);
            
            _currentStateName  = stateName;
        }
    }
    
    private function getStateAnimate(stateName:String, ?startIndex:Int=0)
    {
        var state = states.get(stateName);
        _currentStateLength = state.length;
        
        var index = state[startIndex];
        var point = _indexes[index];
        
        _bi.copyPixels(_spritesheet, new Rectangle(point.x, point.y, _cellWidth, _cellHeight), new Point(0, 0));
        bitmapData = _bi;
    }
    
    private function nextAnimation(ticks:Int)
    {
        if (_goingBack && _goBack)
        {
            if (_currentIndex - 1 < 0)
            {
                _goingBack = false;
                _currentIndex++;
            }
            else
                _currentIndex--;
        }
        else if (!_goingBack && _goBack)
        {
            if (_currentIndex + 1 > _currentStateLength - 1)
            {
                _goingBack = true;
                _currentIndex--;
            }
            else
                _currentIndex++;
        }
        else
        {
            if (_currentIndex + 1 > _currentStateLength - 1)
                return;
            else
                _currentIndex++;
        }
        
        getStateAnimate(_currentStateName, _currentIndex);
    }
    
}