/// @param wavegen
/// @param x
/// @param y

var _wavegen = argument0;
var _x       = argument1;
var _y       = argument2;

if (!wavegen_exists(_wavegen)) return undefined;

var _grid = _wavegen[@ __eWaveGen.Grid];
return _grid[# _x, _y];