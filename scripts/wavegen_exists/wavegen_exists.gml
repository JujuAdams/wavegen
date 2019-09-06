/// @param wavegen

var _wavegen = argument0;

if (!is_array(_wavegen)) return false;
if (_wavegen[__eWaveGen.Version] != WAVEGEN_VERSION) return false;
if (_wavegen[__eWaveGen.Freed]) return false;

return true;