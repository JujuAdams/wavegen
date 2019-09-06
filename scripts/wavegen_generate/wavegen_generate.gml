/// @param wavegen
/// @param [emptyType]

var _wavegen    = argument[0];
var _empty_type = (argument_count > 1)? argument[1] : 0;

if (!wavegen_exists(_wavegen)) return false;

var _wrap  = _wavegen[__eWaveGen.Wrap ];
var _seed  = _wavegen[__eWaveGen.Seed ];
var _rules = _wavegen[__eWaveGen.Rules];
var _grid  = _wavegen[__eWaveGen.Grid ];

var _width        = ds_grid_width(_grid);
var _height       = ds_grid_height(_grid);
var _visited_grid = ds_grid_create(_width, _height);

var _open_list = ds_list_create();
var _cell_y = 0;
repeat(_height)
{
    var _cell_x = 0;
    repeat(_width)
    {
        if (_grid[# _cell_x, _cell_y] != _empty_type)
        {
            _visited_grid[# _cell_x, _cell_y] = true;
            
            var _d = 0;
            repeat(4)
            {
                var _x = _cell_x;
                var _y = _cell_y;
                
                switch(_d)
                {
                    case 0: ++_x; break;
                    case 1: --_y; break;
                    case 2: --_x; break;
                    case 3: ++_y; break;
                }
                
                if (_wrap)
                {
                    _x = (_x + _width ) mod _width;
                    _y = (_y + _height) mod _height;
                }
                else
                {
                    if ((_x < 0) || (_y < 0) || (_x >= _width) || (_y >= _height))
                    {
                        ++_d;
                        continue;
                    }
                }
                
                if (!_visited_grid[# _x, _y] && (_grid[# _x, _y] == _empty_type)) ds_list_add(_open_list, [_x, _y]);
                
                ++_d;
            }
        }
        ++_cell_x;
    }
    ++_cell_y;
}

if (ds_list_empty(_open_list))
{
    show_error("Wavegen:\nNo non-empty cells found. Set a cell to non-empty value using wavegen_grid_set().\n ", false);
    return false;
}

var _old_seed = random_get_seed();
random_set_seed(_seed);

var _cell_list = ds_list_create();
var _cell_map  = ds_map_create();

var _error_no_rules_found = false;
repeat(_width*_height)
{
    do
    {
        if (ds_list_empty(_open_list))
        {
            _cell_x = undefined;
            break;
        }
        
        var _c = irandom(ds_list_size(_open_list)-1);
        var _coord = _open_list[| _c];
        ds_list_delete(_open_list, _c);
        var _cell_x = _coord[0];
        var _cell_y = _coord[1];
    }
    until !_visited_grid[# _cell_x, _cell_y];
    
    if (_cell_x == undefined) break;
    
    _visited_grid[# _cell_x, _cell_y] = true;
    
    ds_list_clear(_cell_list);
    ds_map_clear(_cell_map);
    
    var _d = 0;
    repeat(4)
    {
        var _x = _cell_x;
        var _y = _cell_y;
                
        switch(_d)
        {
            case 0: ++_x; break;
            case 1: --_y; break;
            case 2: --_x; break;
            case 3: ++_y; break;
        }
        
        if (_wrap)
        {
            _x = (_x + _width ) mod _width;
            _y = (_y + _height) mod _height;
        }
        else
        {
            if ((_x < 0) || (_y < 0) || (_x >= _width) || (_y >= _height))
            {
                ++_d;
                continue;
            }
        }
        
        var _adjacent = _grid[# _x, _y];
        if (!_visited_grid[# _x, _y])
        {
            ds_list_add(_open_list, [_x, _y]);
            ++_d;
            continue;
        }
        
        if (ds_map_exists(_rules, _adjacent))
        {
            var _rule_array = _rules[? _adjacent];
            
            var _r = 0;
            repeat(array_length_1d(_rule_array) div 2)
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
                
                _r += 2;
            }
        }
        
        ++_d;
    }
    
    var _total_weight = 0;
    var _r = ds_list_size(_cell_list)-1;
    repeat(_r+1)
    {
        _type = _cell_list[| _r];
        _weight = _cell_map[? _type];
        
        if (_weight <= 0)
        {
            ds_list_delete(_cell_list, _r);
            ds_map_delete(_cell_map, _type);
        }
        else
        {
            _total_weight += _weight;
        }
        
        --_r;
    }
    
    
    if (_total_weight > 0)
    {
        var _random = random(_total_weight);
        
        var _r = 0;
        var _counter = 0;
        var _type = undefined;
        repeat(ds_list_size(_cell_list))
        {
            _type = _cell_list[| _r];
            _counter += _cell_map[? _type];
            if (_random < _counter) break;
            ++_r;
        }
        
        _grid[# _cell_x, _cell_y] = _type;
        //show_debug_message(string(_cell_x) + "," + string(_cell_y) + ", random=" + string(_random) + ", chose " + string(_r) + "->" + string(_type) + "        " + json_encode(_cell_map));
    }
    else
    {
        ++_error_no_rules_found;
        _grid[# _cell_x, _cell_y] = _empty_type;
        //show_debug_message(string(_cell_x) + "," + string(_cell_y) + ", no adjacent rules found, setting to " + string(_empty_type));
    }
}

if (_error_no_rules_found > 0)
{
    show_error("Wavegen:\n" + string(_error_no_rules_found) + " cell" + ((_error_no_rules_found == 1)? "" : "s") + " had no rules and have been set to empty (" + string(_empty_type) + ").\nThis is usually caused by missing rules for certain cell types.\n ", false);
}

ds_list_destroy(_open_list);
ds_list_destroy(_cell_list);
ds_map_destroy(_cell_map);
ds_grid_destroy(_visited_grid);

random_set_seed(_old_seed);
return true;