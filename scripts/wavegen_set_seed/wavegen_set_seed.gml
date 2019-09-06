/// @param wavegen
/// @param seed

var _wavegen = argument0;
var _seed    = argument1;

if (!wavegen_exists(_wavegen)) return false;

_wavegen[@ __eWaveGen.Seed] = _seed;

return true;