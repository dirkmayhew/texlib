function [TeX] = tex_cell2TeXsubsection(varargin)
  # -- Function: [TeX] = tex_cell2subsection(title, [description, [,figure_ID [, table]]])
  #    this function expects at least one string to be used as the subsection title,
  #    and accepts:
  #      (optionally) another string, expected to be descriptive text
  #      (optionally) a file name of a graphic in the directory pwd/graphics (ie generated by printfigure)
  #      (optionally) a cell array of table data, which can contain mixed numbers and strings
  #

  # 4Mar2021 dirk

  subsection = ' ';
  comment = ' ';
  figID = ' ';
  table = ' ';
  footnote = ' ';

	if (nargin < 1)
		error("need at least a string of subsection text");
	else
    v = 1;
    subsection = [varargin{v}];  v++;
    idx = regexp(subsection, '[%_$]');  subsection(idx) = '_';
    subsection = strrep(subsection, '_', '\_');

    if (nargin >= v) comment = [varargin{v}]; v++; end
    idx = regexp(comment, '[%_$]');  comment(idx) = '_';
    comment = strrep(comment, '_', '\_');

    if (nargin >= v) figID = [varargin{v}]; v++; end
    idx = regexp(figID, '[%_$]');  figID(idx) = '_';
    figID = strrep(figID, '_', '\_');

    if (nargin >= v) table = [varargin{v}]; v++; end
    idx = regexp(table, '[%_$]');  table(idx) = '_';
    table = strrep(table, '_', '\_');
  end

  TeX = [  ...
    "\r\n" '%' ...
    "\r\n" '\newpage \rule{0.9\columnwidth}{1pt}' ...
    "\r\n" '\subsection{ ' subsection '}' ...
    "\r\n\t"  comment ...
  ];

  if isempty(figID)
  else
    TeX = [ TeX  ...
      "\r\n\t" '\begin{center}' ...
      "\r\n\t" '\begin{figure}[!ht]' ...
      "\r\n\t" '\includegraphics[width=\columnwidth]{graphics/' figID '.png}' ...
      "\r\n\t" '\end{figure}' ...
      "\r\n\t" '\end{center}' ...
    ];
  end

  TeX = [ TeX ...
    "\r\n\t" table ...
    "\r\n\t" footnote ...
    "\r\n" '\stepcounter{ReportSectionNumber}' ...
    ];
end
