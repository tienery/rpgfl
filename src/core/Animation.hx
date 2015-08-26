package core;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;
import openfl.geom.Point;
import openfl.Assets;
import haxe.Json;

class Animation extends Sprite
{
	
	private var _spritesheet:BitmapData;
	private var _indexes:Array<Point> = [];
	private var _bitmap:Bitmap;
	public var states:Map<String, Array<Int>>;
	private var _cellWidth:Int;
	private var _cellHeight:Int;

	public function new(bitmapData:BitmapData) 
	{
		super();
		
		_spritesheet = bitmapData;
	}
	
	public function init(path:String)
	{
		var contents:Dynamic = Json.parse(Assets.getText(path));
		
		_cellWidth = contents.cellWidth;
		_cellHeight = contents.cellHeight;
		
		states = new Map<String, Array<Int>>();
		
		for (i in 0...contents.states.length)
		{
			var state:Dynamic = contents.states[i];
			
			states.set(state.name, state.animation);
		}
		
		for (i in 0...contents.sheet.length)
		{
			var item:Dynamic = contents.sheet[i];
			
			_indexes.push(new Point(item.x, item.y));
		}
	}
	
	public function switchState(stateName:String, ?startIndex:Int=0)
	{	
		if (states.exists(stateName))
		{
			var first = states.get(stateName)[startIndex];
			var bi = new BitmapData(_cellWidth, _cellHeight);
			var point = _indexes[first];
			
			bi.copyPixels(_spritesheet, new Rectangle(point.x, point.y, _cellWidth, _cellHeight), new Point(0, 0));
			_bitmap = new Bitmap(bi);
			addChild(_bitmap);
		}
	}
	
}