function [color_map] = tex_colormap(varargin)
  # -- Function file: [color_map] = tex_colormap(n_levels, direction)
  #      given a number of levels and a direction ('RYG', 'GYR', 'RGR', or 'GRG')
  #      returns a red-yellow-green color scale suitable for use with the "colormap()" function,e.g.
  #     octave:> colormap(color_map)
  #     will do something meaningful
  #     default direction is GYR, low to high
  #     see also:  caxis, colorbar

  n_levels = 10;
  direction = 'GYR';
  if (nargin < 1)
    # error("no no inputs");
  else
    n_levels = [varargin{1}];

    if ((nargin == 2) && ischar(varargin{2}));
      direction = toupper(varargin{2});
    endif
  endif

  _n = floor(n_levels/2);
  _ones = ones(1, _n);
  _zeros = zeros(1, _n);

  _fallings = linspace(1, 0, _n + 1);
  _fallings = _fallings(2:length(_fallings));
  _risings = fliplr(_fallings);

  if (strcmp(direction, "RYG"))
    if (0 == mod(n_levels, 2))
      _chRed = [ _ones _fallings ]';
      _chGreen = [ _risings _ones ]';
      _chBlue = [ _zeros _zeros ]';
    else
      _chRed = [ _ones 1 _fallings ]';
      _chGreen = [ _risings 1 _ones ]';
      _chBlue = [ _zeros 0 _zeros ]';
    endif
  elseif (strcmp(direction, "RGR"))
    if (0 == mod(n_levels, 2))
      _chRed = [ _fallings  _risings ]';
      _chGreen = [ _risings _fallings ]';
      _chBlue = [ _zeros _zeros ]';
    else
      _chRed = [ _fallings 0  _risings ]';
      _chGreen = [ _risings 1 _fallings ]';
      _chBlue = [ _zeros 0 _zeros ]';
    endif
  elseif (strcmp(direction, "GRG"))
    if (0 == mod(n_levels, 2))
      _chRed = [ _risings  _fallings ]';
      _chGreen = [ _fallings _risings ]';
      _chBlue = [ _zeros _zeros ]';
    else
      _chRed = [ _risings 1  _fallings ]';
      _chGreen = [ _fallings 0 _risings ]';
      _chBlue = [ _zeros 0 _zeros ]';
    endif
  elseif (strcmp(direction, 'GYR'))
    if (0 == mod(n_levels, 2))
      _chRed = [ _risings  _ones ]';
      _chGreen = [ _ones _fallings ]';
      _chBlue = [ _zeros _zeros ]';
    else
      _chRed = [ _risings 1 _ones ]';
      _chGreen = [ _ones 1 _fallings ]';
      _chBlue = [ _zeros 0 _zeros ]';
    endif
  elseif (strcmp(direction, 'WB'))
    if (0 == mod(n_levels, 2))
      _chRed = [ _fallings  ]';
      _chGreen = [ _fallings  ]';
      _chBlue = [ _ones ]';
    else
      _chRed = [ _fallings 0 ]';
      _chGreen = [ _fallings 0 ]';
      _chBlue = [ _ones 1 ]';
    endif
  elseif (strcmp(direction, 'WR'))
    if (0 == mod(n_levels, 2))
      _chRed = [ _ones  ]';
      _chGreen = [ _fallings  ]';
      _chBlue = [ _fallings ]';
    else
      _chRed = [ _ones 1 ]';
      _chGreen = [ _fallings 0 ]';
      _chBlue = [ _fallings 0 ]';
    endif
  elseif (strcmp(direction, 'BWR'))
    if (0 == mod(n_levels, 2))
      _chRed = [ _fallings  ]';
      _chGreen = [ _fallings  ]';
      _chBlue = [ _fallings _zeros ]';
    else
      _chRed = [ _fallings 0 ]';
      _chGreen = [ _fallings 0 ]';
      _chBlue = [ _ones 1 ]';
    endif

  if (0 == mod(n_levels, 2))
      _chRed = [ _ones  ]';
      _chGreen = [ _fallings  ]';
      _chBlue = [ _fallings ]';
    else
      _chRed = [ _ones 1 ]';
      _chGreen = [ _fallings 0 ]';
      _chBlue = [ _fallings 0 ]';
    endif
  else
    _chRed = [ _fallings 0 ]';
    _chGreen = [ _fallings 0 ]';
    _chBlue = [ _fallings 0 ]';
  endif

  color_map = [ _chRed  _chGreen _chBlue];
endfunction
