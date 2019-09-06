/// @param wavegen
/// @param adjacentType

var _wavegen  = argument0;
var _adjacent = argument1;

if (!wavegen_exists(_wavegen)) return false;

ds_map_delete(_wavegen[__eWaveGen.Rules], _adjacent);

return true;