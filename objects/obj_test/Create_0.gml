randomise();

x_offset = 0;
y_offset = 0;

cell_px_w = 4;
cell_px_h = 4;

var _width  = room_width div cell_px_w;
var _height = room_height div cell_px_h;
wavegen = wavegen_create(_width, _height, true);

wavegen_rule_add(wavegen, 0,   0,    80);
wavegen_rule_add(wavegen, 0,   1,     1);
wavegen_rule_add(wavegen, 0,   2, -9999);
wavegen_rule_add(wavegen, 0,   3,     0);

wavegen_rule_add(wavegen, 1,   0,     1);
wavegen_rule_add(wavegen, 1,   1,    40);
wavegen_rule_add(wavegen, 1,   2,     3);
wavegen_rule_add(wavegen, 1,   3,     5);

wavegen_rule_add(wavegen, 2,   0, -9999);
wavegen_rule_add(wavegen, 2,   1,     1);
wavegen_rule_add(wavegen, 2,   2,    15);
wavegen_rule_add(wavegen, 2,   3,     1);

wavegen_rule_add(wavegen, 3,   0,     0);
wavegen_rule_add(wavegen, 3,   1,     2);
wavegen_rule_add(wavegen, 3,   2,     0);
wavegen_rule_add(wavegen, 3,   3,    15);

wavegen_grid_set(wavegen,    _width div 4,     _height div 4 , 1);
wavegen_grid_set(wavegen, 3*(_width div 4),    _height div 4 , 1);
wavegen_grid_set(wavegen,    _width div 4 , 3*(_height div 4), 1);
wavegen_grid_set(wavegen, 3*(_width div 4), 3*(_height div 4), 1);
wavegen_generate_scatter(wavegen);