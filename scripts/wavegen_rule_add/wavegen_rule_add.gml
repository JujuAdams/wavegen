/// @param wavegen
/// @param adjacentType
/// @param newType
/// @param probabilityWeight

var _wavegen  = argument0;
var _adjacent = argument1;
var _type     = argument2;
var _weight   = argument3;

var _rules = _wavegen[__eWaveGen.Rules];

var _array = _rules[? _adjacent];
if (_array == undefined)
{
    _array = [_type, _weight];
    _rules[? _adjacent] = _array;
}
else
{
    var _size = array_length_1d(_array);
    _array[@ _size+1] = _weight;
    _array[@ _size  ] = _type;
}

return _array;