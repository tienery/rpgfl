package;

import openfl.ui.Keyboard;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;

class KeyState
{
    
    private static var stage:Stage;
    private static var _keys:Array<Bool> = [];
    
    public static function init()
    {
        for (i in 0...200) _keys.push(false);
        
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }
    
    private static function onKeyUp(e)
    {
        _keys[e.keyCode] = false;
    }
    
    private static function onKeyDown(e)
    {
        _keys[e.keyCode] = true;
    }
    
    public static function isKeyUp(keyCode:Int):Bool
    {
        return _keys[keyCode];
    }
    
}