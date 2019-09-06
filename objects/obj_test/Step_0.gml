var _grid = wavegen_grid_get_id(wavegen);
var _width  = ds_grid_width(_grid);
var _height = ds_grid_height(_grid);

x_offset += 0.5*(keyboard_check(vk_right) - keyboard_check(vk_left));
y_offset += 0.5*(keyboard_check(vk_down) - keyboard_check(vk_up));

x_offset = (x_offset + _width) mod _width;
y_offset = (y_offset + _height) mod _height;