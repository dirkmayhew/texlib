function [X] = tex_create_filename(varargin)
  # -- Function file: [file_name] = tex_create_filename([string])
  #    Given no inputs, returns pdfdate
  #    Given one input, prepends the pdfdate and returns the alphanumericized result

  switch (nargin)
    case 1
      name = [varargin{1}];
      name = tex_alphanumericize(name);
      name = ['_' name];
    otherwise
      name = '_';
  end

  X = [pdfdate name];
end
