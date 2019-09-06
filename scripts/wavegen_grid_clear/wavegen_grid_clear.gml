/// @param wavegen
/// @param value

var _wavegen = argument0;
var _value   = argument1;

if (!wavegen_exists(_wavegen)) return false;

ds_grid_clear(_wavegen[__eWaveGen.Grid], _value);

return true;