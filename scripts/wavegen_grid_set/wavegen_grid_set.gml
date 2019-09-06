/// @param wavegen
/// @param x
/// @param y
/// @param value

var _wavegen = argument0;
var _x       = argument1;
var _y       = argument2;
var _value   = argument3;

if (!wavegen_exists(_wavegen)) return false;

var _grid = _wavegen[@ __eWaveGen.Grid];
_grid[# _x, _y] = _value;

return true;