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
    
    public var right(get, null):Float;
    function get_right() return x + anim.width;
    
    public var bottom(get, null):Float;
    function get_bottom() return y + anim.height;
    
    private var _currentTileX:Int;
    public var currentTileX(get, null):Int;
    function get_currentTileX()
    {
        var xPos = x / mapRef.cellWidth;
        if (Math.round(xPos) < Math.ceil(xPos))
            return _currentTileX = Math.floor(xPos);
        else
            return _currentTileX = Math.ceil(xPos);
    }
    
    private var _currentTileY:Int;
    public var currentTileY(get, null):Int;
    function get_currentTileY()
    {
       return _currentTileY = Math.ceil((y - 5) / mapRef.cellHeight);
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
            if (mapRef.canGoUp(currentTileX, currentTileY))
                anim.y = y;
            else
            {
                if (!(y + 5 <= currentTileY * mapRef.cellHeight))
                    anim.y = y;
                else
                    y = anim.y;
            }
        }
        else if (KeyState.isKeyDown(Keyboard.S))
        {
            anim.update(deltaTime, "walk_down", 1, true);
            
            y += deltaTime * speed;
            
            
            if (mapRef.canGoDown(currentTileX, currentTileY))
                anim.y = y;
            else
            {
                if (!(bottom >= currentTileY * mapRef.cellHeight - mapRef.cellHeight))
                    anim.y = y;
                else
                    y = anim.y;
            }
        }
        else if (KeyState.isKeyDown(Keyboard.A))
        {
            anim.update(deltaTime, "walk_left", 1, true);
            
            x -= deltaTime * speed;
            
            if (mapRef.canGoLeft(currentTileX, currentTileY))
                anim.x = x;
            else
            {
                if (!(anim.x <= currentTileX * mapRef.cellWidth))
                    anim.x = x;
                else
                    x = anim.x;
            }
        }
        else if (KeyState.isKeyDown(Keyboard.D))
        {
            anim.update(deltaTime, "walk_right", 1, true);
            
            x += deltaTime * speed;
            
            if (mapRef.canGoRight(currentTileX, currentTileY))
                anim.x = x;
            else
            {
                if (!(right >= currentTileX * mapRef.cellWidth - mapRef.cellWidth))
                    anim.x = x;
                else
                    x = anim.x;
            }
        }
        
        trace(currentTileX, currentTileY);
    }
    
}