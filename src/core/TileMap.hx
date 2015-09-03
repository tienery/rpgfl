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
    private var _passableTiles:Array<Bool>;
    private var _passableCells:Array<Array<Bool>>;
    
    public var cellWidth:Int;
    public var cellHeight:Int;
    
    public function new(bitmapData:BitmapData = null) 
    {
        super();
        
        _image = bitmapData;
        
        _tilesheet     = new Tilesheet(bitmapData);
        _passableTiles = [];
        _passableCells = [];
    }
    
    public function init(dataPath:String)
    {
        var obj:Dynamic = Json.parse(Assets.getText(dataPath));
        
        cellWidth = obj.width;
        cellHeight = obj.height;
        
        _table = new Map<String, Int>();
        
        _passableTiles.push(false);
        for (i in 0...obj.data.length)
        {
            var tileInfo:Dynamic = obj.data[i];
            _passableTiles.push(tileInfo.passable);
            _table.set(tileInfo.name, _tilesheet.addTileRect(new Rectangle(tileInfo.x, tileInfo.y, cellWidth, cellHeight)));
        }
    }
    
    public function canGoUp(tileX:Int, tileY:Int):Bool  
    {
        if (tileY <= 0)
            return false;
        
        return _passableCells[tileY - 1][tileX];
    }
    
    public function canGoLeft(tileX:Int, tileY:Int):Bool
    {
        if (tileX <= 0)
            return false;
        
        return _passableCells[tileY][tileX - 1];
    }
    
    public function canGoRight(tileX:Int, tileY:Int):Bool
    {
        if (tileX > _passableCells[tileY].length)
            return false;
        
        return _passableCells[tileY][tileX];
    }
    
    public function canGoDown(tileX:Int, tileY:Int):Bool
    {
        if (tileY > _passableCells.length)
            return false;
        
        return _passableCells[tileY][tileX];
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
            var values:Array<Bool> = [];
            var columns:Array<String> = rows[i].split(",");
            for (j in 0...columns.length)
            {
                var value = Std.parseFloat(columns[j]);
                if (value > -1)
                {
                    _tilesheet.drawTiles(graphics, [j * cellHeight, i * cellWidth, value]);
                    values.push(_passableTiles[Std.int(value) + 1]);
                    continue;
                }
                values.push(false);
            }
            _passableCells.push(values);
        }
    }
    
}