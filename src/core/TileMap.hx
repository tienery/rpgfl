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
    
    public var cellWidth:Int;
    public var cellHeight:Int;
    
    public function new(bitmapData:BitmapData = null) 
    {
        super();
        
        _image = bitmapData;
        
        _tilesheet = new Tilesheet(bitmapData);
    }
    
    public function init(dataPath:String)
    {
        var obj:Dynamic = Json.parse(Assets.getText(dataPath));
        
        cellWidth = obj.width;
        cellHeight = obj.height;
        
        _table = new Map<String, Int>();
        
        for (i in 0...obj.data.length)
        {
            var tileInfo:Dynamic = obj.data[i];
            _table.set(tileInfo.name, _tilesheet.addTileRect(new Rectangle(tileInfo.x, tileInfo.y, cellWidth, cellHeight)));
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
    
    public function drawMapFromCsv(mapPath:String)
    {
        var contents = Assets.getText(mapPath);
        
        var rows:Array<String> = contents.split("\n");
        for (i in 0...rows.length)
        {
            var columns:Array<String> = rows[i].split(",");
            for (j in 0...columns.length)
            {
                var value = Std.parseFloat(columns[j]);
                if (value > -1)
                {
                    _tilesheet.drawTiles(graphics, [j * cellHeight, i * cellWidth, value]);
                }
            }
        }
    }
    
}