package core;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.Lib;

class Camera extends Sprite
{

	
	private var _currentScene:Sprite;
	public var renderWidth:Int;
	public var renderHeight:Int;
	
	public function new(showScene:Sprite, renderWidth:Int, renderHeight:Int) 
	{
		super();
		
		_currentScene = showScene;
		
		this.renderWidth = renderWidth;
		this.renderHeight = renderHeight;
		
		scrollRect = new Rectangle(0, 0, renderWidth, renderHeight);
		
		addChild(_currentScene);
	}
	
	public function changeScene(scene:Sprite):Void
	{
		_currentScene = scene;
	}
	
	public function move(x:Float, y:Float):Void
	{
		scrollRect = new Rectangle(x, y, renderWidth, renderHeight);
	}
	
	
}