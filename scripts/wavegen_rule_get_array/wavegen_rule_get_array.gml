/// @param wavegen
/// @param adjacentType

var _wavegen  = argument0;
var _adjacent = argument1;

if (!wavegen_exists(_wavegen)) return [];

var _rules = _wavegen[__eWaveGen.Rules];
var _array = _rules[? _adjacent];
if (_array == undefined) return [];

return _array;