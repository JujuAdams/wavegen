/// @param wavegen

var _wavegen = argument0;

if (!wavegen_exists(_wavegen)) return false;

_wavegen[__eWaveGen.Freed] = true;

ds_grid_destroy(_wavegen[__eWaveGen.Grid]);
ds_map_destroy(_wavegen[__eWaveGen.Rules]);

return true;