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
            anim.play("walk_up", 1, 0, true);
            anim.y -= speed * deltaTime;
        }
        else 
            anim.stop();
        
        if (KeyState.isKeyDown(Keyboard.A))
        {
            anim.play("walk_left", 1, 0, true);
            anim.x -= speed * deltaTime;
        }
        else 
            anim.stop();
        
        if (KeyState.isKeyDown(Keyboard.S))
        {
            anim.play("walk_down", 1, 0, true);
            anim.y += speed * deltaTime;
        }
        else 
            anim.stop();
            
        if (KeyState.isKeyDown(Keyboard.D))
        {
            anim.play("walk_right", 1, 0, true);
            anim.x += speed * deltaTime;
        }
        else
            anim.stop();
    }
    
}