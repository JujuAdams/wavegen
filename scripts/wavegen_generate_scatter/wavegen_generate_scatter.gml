/// @param wavegen
/// @param [emptyType]

var _wavegen    = argument[0];
var _empty_type = (argument_count > 1)? argument[1] : 0;

if (!wavegen_exists(_wavegen)) return false;

var _rules = _wavegen[__eWaveGen.Rules];
var _empty_rules = _rules[? _empty_type];
if (_empty_rules == undefined)
{
    show_error("Wavegen:\nNo rule exists for adjacent to empty type (" + string(_empty_type) + ").\nAdd a rule for the empty type using wavegen_rule_add().\n ", false);
    return false;
}
var _empty_rule_size = array_length_1d(_empty_rules);

var _grid   = _wavegen[__eWaveGen.Grid];
var _width  = ds_grid_width(_grid);
var _height = ds_grid_height(_grid);

var _open_list = ds_list_create();

var _y = 0;
repeat(_height)
{
    var _x = 0;
    repeat(_width)
    {
        if (_grid[# _x, _y] == _empty_type) ds_list_add(_open_list, [_x, _y]);
        ++_x;
    }
    ++_y;
}

var _open_size = ds_list_size(_open_list);
if (_open_size <= 0)
{
    show_debug_message("Wavegen: No empty cells!");
    ds_list_destroy(_open_list);
    return true;
}

var _old_seed = random_get_seed();
random_set_seed(_wavegen[__eWaveGen.Seed]);
ds_list_shuffle(_open_list);

var _cell_list         = ds_list_create();
var _cell_map          = ds_map_create();
var _cell_weight_total = 0;

var _c = 0;
repeat(_open_size)
{
    var _coord = _open_list[| _c];
    var _cell_x = _coord[0];
    var _cell_y = _coord[1];
    
    ds_list_clear(_cell_list);
    ds_map_clear(_cell_map);
    _cell_weight_total = 0;
    
    var _d = 0;
    repeat(4)
    {
        var _x = _cell_x;
        var _y = _cell_y;
        switch(_d)
        {
            case 0: ++_x; if (_x >= _width ) {++_d; continue;} break;
            case 1: --_y; if (_y <  0      ) {++_d; continue;} break;
            case 2: --_x; if (_x <  0      ) {++_d; continue;} break;
            case 3: ++_y; if (_y >= _height) {++_d; continue;} break;
        }
        
        var _adjacent = _grid[# _x, _y];
        var _rule_array = _rules[? _adjacent];
        if (_rule_array == undefined)
        {
            _rule_array = _empty_rules;
            var _rule_size = _empty_rule_size;
        }
        else
        {
            var _rule_size = array_length_1d(_rule_array);
        }
        
        var _r = 0;
        repeat(_rule_size div 2)
        {
            var _type   = _rule_array[_r  ];
            var _weight = _rule_array[_r+1];
            
            if (!ds_map_exists(_cell_map, _type))
            {
                _cell_map[? _type] = _weight;
                ds_list_add(_cell_list, _type);
            }
            else
            {
                _cell_map[? _type] += _weight;
            }
            
            _cell_weight_total += _weight;
            
            _r += 2;
        }
        
        ++_d;
    }
    
    var _random = random(_cell_weight_total);
    
    var _r = 0;
    var _counter = 0;
    var _type = _empty_type;
    repeat(ds_list_size(_cell_list))
    {
        _type = _cell_list[| _r];
        _counter += _cell_map[? _type];
        if (_random < _counter) break;
        ++_r;
    }
    
    _grid[# _cell_x, _cell_y] = _type;
    
    ++_c;
}

ds_list_destroy(_open_list);
ds_list_destroy(_cell_list);
ds_map_destroy(_cell_map);

random_set_seed(_old_seed);
return true;