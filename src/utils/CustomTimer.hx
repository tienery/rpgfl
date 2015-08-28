package utils;

import msignal.Signal.Signal1;

class CustomTimer
{
    
    public var timeStarted:Float;
    public var interval:Float;
    public var currentTime:Float;
    
    private var _seconds:Int;
    public var tick:Signal1<Int>;
    
    public function new(interval:Float)
    {
        timeStarted   = 0;
        currentTime   = 0;
        this.interval = interval;
        
        tick = new Signal1<Int>();
    }
    
    public function update(deltaTime:Float)
    {
        currentTime += deltaTime;
        
        if (currentTime % interval >= 1)
        {
            tick.dispatch(++_seconds);
            currentTime = 0;
        }
    }
    
}