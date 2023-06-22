function [X] = tex_cell2TeXtable(varargin)
  # -- Function: tex_cell2TeXtable(cellTeXtbl [, title [, precision[, cull_empties]]])
  #    given a cell array, return a formatted TeX string
  #      to insert a table with an optional title
  #    cell array must be rectangular
  #    optional precision value will force the table numerical values to the given number of decimals
  #    the optional cull_empties (0 or 1) will strip rows that contain any blank values

  # 29OCT2012 cull rows with empty indices

	if (nargin < 1)
		error("need at least a cell array of table data");
	else
	  _title = '';
    _fmt = '%.1f';
	  cull_empties = 0;

	  v = 1;
		TeXtbl = [varargin{v}];  v++;
		if (nargin >= v)
			_title = varargin{v};  v++;
			_title = strrep(_title, '_', '\_');
      if (nargin >= v)
        _fmt = ['%.' num2str([varargin{v}]) 'f'];  v++;
				if (nargin >= v)
					cull_empties = varargin{v};  v++;
				end
      end
		end
	end

	[rows, cols] = size(TeXtbl);
	use_row = ones(rows, 1);
  if (cull_empties)  # cull rows based on empty indices
		for (r =1 :rows)
			for (c = 1:cols)
				if (isempty(TeXtbl{r, c}))
					use_row(r) = 0;
					break;
				end
			end
		end
	end

	_TeXtbl = cell();
	for (r = 1:rows)
	  if (use_row(r))
			[_rows, _cols] = size(_TeXtbl);
			for (c = 1:cols)
				_TeXtbl{_rows + 1, c} = TeXtbl{r, c};
			end
		end
	end	
	TeXtbl = _TeXtbl;

  # prefer use longer instead of wider tables
  if (rows < cols)
    TeXtbl = TeXtbl';
    [rows, cols] = size(TeXtbl);
  end

  _col_fmt = '';
	for (col = 1:cols)
		_col_fmt = [_col_fmt '  c'];
	end
	_col_fmt = [ '{' _col_fmt ' }'];

	TeXtbl_body = '';
	for (row = 1:rows)
		TeXtbl_body = [ TeXtbl_body  "\t\t" ];

	  for (col = 1:(cols - 1))
      _data = TeXtbl{row,col};

      if (ischar(_data))
        _data = strrep(_data, '_', '\_');
      elseif (isnan(_data) || isna(_data))
        _data = ' ';
      elseif (isinf(_data))
        _data = 'inf';
			elseif (isnumeric(_data))
        _data = sprintf(_fmt, _data);
			end

		  TeXtbl_body = [ TeXtbl_body ...
				_data ' & '  ...
				];
		end

    col = cols;
    _data = [TeXtbl{row,col}];
    if (ischar(_data))
      _data = strrep(_data, '_', '\_');
    elseif (isnan(_data) || isna(_data))
      _data = ' ';
    elseif (isinf(_data))
      _data = 'inf';
    elseif (isnumeric(_data))
      _data = sprintf(_fmt, _data);
    end
		TeXtbl_body = [ TeXtbl_body _data ' \\' "\r\n"];
	end

  # write out TeX formatted table
	X = [ ...
					"\r\n" '\begin{center}' ...
        "\r\n{" '\tiny' ...
					"\r\n\t" '\begin{tabular}[b]' _col_fmt ...
					"\r\n\t" '\toprule' ...
        "\r\n\t" '\multicolumn{' num2str(cols) '}{c}{ ' _title ' } \\' ...
        "\r\n\t" '\midrule' ...
        "\r\n" ...
					TeXtbl_body ...
					"\r\n\t" '\bottomrule' ...
					"\r\n\t" '\end{tabular}' ...
          "\r\n}" ...
					"\r\n" '\end{center}' ...
				];
end
