randomise();

x_offset = 0;
y_offset = 0;

cell_px_w = 4;
cell_px_h = 4;

var _width  = room_width div cell_px_w;
var _height = room_height div cell_px_h;
wavegen = wavegen_create(_width, _height, true);

enum eTerrain
{
    Water,
    Land,
    Mountain,
    Forest
}

wavegen_rule_add(wavegen, eTerrain.Water   ,   eTerrain.Water   ,   100);
wavegen_rule_add(wavegen, eTerrain.Water   ,   eTerrain.Land    ,     1);
wavegen_rule_add(wavegen, eTerrain.Water   ,   eTerrain.Mountain, -9999);
wavegen_rule_add(wavegen, eTerrain.Water   ,   eTerrain.Forest  ,     0);

wavegen_rule_add(wavegen, eTerrain.Land    ,   eTerrain.Water   ,     1);
wavegen_rule_add(wavegen, eTerrain.Land    ,   eTerrain.Land    ,    40);
wavegen_rule_add(wavegen, eTerrain.Land    ,   eTerrain.Mountain,     3);
wavegen_rule_add(wavegen, eTerrain.Land    ,   eTerrain.Forest  ,     5);

wavegen_rule_add(wavegen, eTerrain.Mountain,   eTerrain.Water   , -9999);
wavegen_rule_add(wavegen, eTerrain.Mountain,   eTerrain.Land    ,     1);
wavegen_rule_add(wavegen, eTerrain.Mountain,   eTerrain.Mountain,    15);
wavegen_rule_add(wavegen, eTerrain.Mountain,   eTerrain.Forest  ,     0);

wavegen_rule_add(wavegen, eTerrain.Forest  ,   eTerrain.Water   ,     0);
wavegen_rule_add(wavegen, eTerrain.Forest  ,   eTerrain.Land    ,     1);
wavegen_rule_add(wavegen, eTerrain.Forest  ,   eTerrain.Mountain,     0);
wavegen_rule_add(wavegen, eTerrain.Forest  ,   eTerrain.Forest  ,    15);

wavegen_grid_set(wavegen,    _width div 4,     _height div 4 , 1);
wavegen_grid_set(wavegen, 3*(_width div 4),    _height div 4 , 1);
wavegen_grid_set(wavegen,    _width div 4 , 3*(_height div 4), 1);
wavegen_grid_set(wavegen, 3*(_width div 4), 3*(_height div 4), 1);
wavegen_generate(wavegen);