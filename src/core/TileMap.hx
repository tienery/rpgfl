package core;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Tilesheet;
import haxe.Json;
import openfl.Assets;
import openfl.geom.Rectangle;

class TileMap extends Sprite
{
	
	private var _tilesheet:Tilesheet;
	private var _image:BitmapData;
	private var _table:Map<String, Int>;
	
	public var offsetX:Int;
	public var offsetY:Int;
	
	public function new(bitmapData:BitmapData = null) 
	{
		super();
		
		_image = bitmapData;
		
		_tilesheet = new Tilesheet(bitmapData);
	}
	
	public function init(dataPath:String)
	{
		var obj:Dynamic = Json.parse(Assets.getText(dataPath));
		
		offsetX = obj.width;
		offsetY = obj.height;
		
		_table = new Map<String, Int>();
		
		for (i in 0...obj.data.length)
		{
			var tileInfo:Dynamic = obj.data[i];
			_table.set(tileInfo.name, _tilesheet.addTileRect(new Rectangle(tileInfo.x, tileInfo.y, offsetX, offsetY)));
		}
	}
	
	public function drawMap(mapPath:String)
	{
		var obj:Dynamic = Json.parse(Assets.getText(mapPath));
		
		for (i in 0...obj.length)
		{
			var tile:Dynamic = obj[i];
			_tilesheet.drawTiles(graphics, [tile.x, tile.y, _table.get(tile.name)]);
		}
	}
	
}