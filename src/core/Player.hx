package core;
import openfl.Assets;
import openfl.display.Sprite;


class Player extends Unit
{
    
    public var anim:Animation;
    
    public function new(imgSrc:String, spritesheetPath:String) 
    {
        super();
        
        anim = new Animation(Assets.getBitmapData(imgSrc));
        anim.init(spritesheetPath);
        
        anim.switchState("walk_up", 1);
    }
    
    public function draw(scene:Sprite, defaultX:Float, defaultY:Float)
    {
        anim.x = defaultX;
        anim.y = defaultY;
        
        scene.addChild(anim);
    }
    
    public function update(deltaTime:Float)
    {
        
    }
    
}