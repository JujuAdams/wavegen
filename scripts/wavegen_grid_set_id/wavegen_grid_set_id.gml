/// @param wavegen
/// @param grid

var _wavegen = argument0;
var _grid    = argument1;

if (!wavegen_exists(_wavegen)) return false;

_wavegen[@ __eWaveGen.Grid] = _grid;

return true;