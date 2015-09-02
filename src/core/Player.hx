package core;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.ui.Keyboard;

class Player extends Unit
{
    
    public var anim:Animation;
    public var speed:Float = 0.1;
    public var mapRef:TileMap;
    
    private var x:Float;
    private var y:Float;
    
    private var _currentTileX:Int;
    public var currentTileX(get, null):Int;
    function get_currentTileX()
    {
        return _currentTileX = Math.ceil(x / mapRef.cellWidth);
    }
    
    private var _currentTileY:Int;
    public var currentTileY(get, null):Int;
    function get_currentTileY()
    {
        return _currentTileY = Math.ceil((y - 5) / mapRef.cellWidth);
    }
    
    public function new(imgSrc:String, spritesheetPath:String) 
    {
        super();
        
        anim = new Animation(Assets.getBitmapData(imgSrc));
        anim.init(spritesheetPath);
        
        anim.switchState("walk_up", 1);
    }
    
    public function draw(mapRef:TileMap, scene:Sprite, defaultX:Float, defaultY:Float)
    {
        anim.x = defaultX;
        anim.y = defaultY;
        
        x = anim.x;
        y = anim.y;
        
        this.mapRef = mapRef;
        
        scene.addChild(anim);
    }
    
    public function update(deltaTime:Float)
    {
        if (KeyState.isKeyDown(Keyboard.W))
        {
            anim.update(deltaTime, "walk_up", 1, true);
            
            y -= deltaTime * speed;
            
            anim.y = y;
        }
        else if (KeyState.isKeyDown(Keyboard.S))
        {
            anim.update(deltaTime, "walk_down", 1, true);
            
            y += deltaTime * speed;
            
            anim.y = y;
        }
        else if (KeyState.isKeyDown(Keyboard.A))
        {
            anim.update(deltaTime, "walk_left", 1, true);
            
            x -= deltaTime * speed;
            
            anim.x = x;
        }
        else if (KeyState.isKeyDown(Keyboard.D))
        {
            anim.update(deltaTime, "walk_right", 1, true);
            
            x += deltaTime * speed;
            
            anim.x = x;
        }
        
        trace(currentTileX, currentTileY);
    }
    
}