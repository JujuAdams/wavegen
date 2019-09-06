/// @param width
/// @param height
/// @param wrap
/// @param [seed]

var _width  = argument[0];
var _height = argument[1];
var _wrap   = argument[2];
if ((argument_count > 3) && is_real(argument[3]))
{
    var _seed = argument[3];
}
else
{
    var _seed = irandom($FFFFFFFF);
    show_debug_message("Wavegen: Chose seed " + string(_seed));
}

enum __eWaveGen
{
    Seed,
    Wrap,
    Rules,
    Grid,
    Version,
    Freed,
    __Size
}

#macro WAVEGEN_VERSION  "Wavegen 0.0.0"

var _array = array_create(__eWaveGen.__Size);
_array[@ __eWaveGen.Seed   ] = _seed;
_array[@ __eWaveGen.Wrap   ] = _wrap;
_array[@ __eWaveGen.Rules  ] = ds_map_create();
_array[@ __eWaveGen.Grid   ] = ds_grid_create(_width, _height);
_array[@ __eWaveGen.Version] = WAVEGEN_VERSION;
_array[@ __eWaveGen.Freed  ] = false;
return _array;