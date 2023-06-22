function [X] = tex_cell2TeXsection(varargin)
  # -- Function: tex_cell2TeXsection(title [, text])
	#			given 
  #       a  title and an [optional] text string,
  #      returns a formatted TeX string for a section'
  #

  # 21OCT2012 dirk reworked
  
	if (nargin < 1)
		error("need at least a string of title text ");
	else
    Title = [];
    Text = [];
    
    count = 1;
    
    TeX = [  ...
      "\r\n" '%' ...
      "\r\n" '% auto-generated TeX  --------------------' ...
      "\r\n" '%' ...
      "\r\n" '\newpage \rule{0.9\columnwidth}{1pt}' ...
    ];
    
    Title = [varargin{count}];  count++;
    idx = regexp(Title, '[%_$]');  Title(idx) = '_';
    Title = strrep(Title, '_', '\_');
    TeX = [  TeX ...
      "\r\n" '\section{'  Title '}' ...
    ];
    if (nargin >= count)
      Text = [varargin{count}];  count++;
      TeX = [  ...
        "\r\n\t"  Text ...
      ];
    end
  end

	X = TeX;
end
