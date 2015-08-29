package utils;

import msignal.Signal.Signal1;

class CustomTimer
{
    
    public var interval:Float;
    public var currentTime:Float;
    
    private var _ticks:Int;
    public var tick:Signal1<Int>;
    
    public function new(interval:Float)
    {
        currentTime   = 0;
        this.interval = interval;
        _ticks        = 0;
        
        tick = new Signal1<Int>();
    }
    
    public function update(deltaTime:Float)
    {
        currentTime += deltaTime;
        
        if (currentTime >= interval)
        {
            _ticks += 1;
            tick.dispatch(_ticks);
            currentTime = 0;
        }
    }
    
}