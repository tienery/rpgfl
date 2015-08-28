package core;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.ui.Keyboard;

class Player extends Unit
{
    
    public var anim:Animation;
    private var speed:Float = 0.1;
    
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
        if (KeyState.isKeyDown(Keyboard.W))
        {
            anim.update(deltaTime, "walk_up", 1, true);
            anim.y -= speed * deltaTime;
        }
        else if (KeyState.isKeyDown(Keyboard.A))
        {
            anim.update(deltaTime, "walk_left", 1, true);
            anim.x -= speed * deltaTime;
        }
        else if (KeyState.isKeyDown(Keyboard.S))
        {
            anim.update(deltaTime, "walk_down", 1, true);
            anim.y += speed * deltaTime;
        }
        else if (KeyState.isKeyDown(Keyboard.D))
        {
            anim.update(deltaTime, "walk_right", 1, true);
            anim.x += speed * deltaTime;
        }
    }
    
}