var _grid = wavegen_grid_get_id(wavegen);
var _width  = ds_grid_width(_grid);
var _height = ds_grid_height(_grid);

var _dx = floor(x_offset);
var _dy = floor(y_offset);

var _y = 0;
repeat(_height)
{
    var _x = 0;
    repeat(_width)
    {
        var _type = _grid[# (_x + _dx) mod _width, (_y + _dy) mod _height];
        
        var _colour = c_white;
        switch(_type)
        {
            case 0: _colour = c_blue;   break;
            case 1: _colour = c_lime;   break;
            case 2: _colour = c_dkgray; break;
            case 3: _colour = c_green;  break;
        }
        draw_set_colour(_colour);
        
        draw_rectangle(cell_px_w*_x, cell_px_h*_y, cell_px_w*_x + cell_px_w-1, cell_px_h*_y + cell_px_h-1, false);
        
        ++_x;
    }
    ++_y;
}