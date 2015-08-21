package core;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.Lib;

class Camera extends Sprite
{

	private var _currentScene:Sprite;
	public var renderWidth:Int;
	public var renderHeight:Int;
	private var _currentScrollX:Float;
	private var _currentScrollY:Float;
	
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
		_currentScrollX = x;
		_currentScrollY = y;
		scrollRect = new Rectangle(x, y, renderWidth, renderHeight);
	}
	
	public function resize(ratioWidth:Float, ratioHeight:Float):Void
	{
		scrollRect = new Rectangle(_currentScrollX, _currentScrollY, ratioWidth * stage.stageWidth, ratioHeight * stage.stageHeight);
		
		_currentScene.scaleX = ratioWidth > renderWidth / stage.stageWidth ? 1 + ratioWidth : 1;
		_currentScene.scaleY = ratioHeight > renderHeight / stage.stageHeight ? 1 + ratioHeight : 1;
	}
	
}