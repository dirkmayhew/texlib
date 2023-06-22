function [X] = tex_printfigure(varargin)
  # -- Function file: result = tex_printfigure(figure_name, [sub_directory])
  #      given a file name, prints & closes the current figure
  #      size of the figure is appropriate for ASME formatted report
  #      figure is printed in color
  #      given an (optional) 2nd string input sub_directory
  #       create the output file in a subdirectory graphics/sub_directory

  h = findall(gca, "-property", "fontname");
    set (h, "fontname", "Times", 'fontsize', 16);
  h = get(gca, 'title');  set(h, 'fontsize', 20);
  h = get(gca, 'xlabel');  set(h, 'fontsize', 18);
  h = get(gca, 'ylabel');  set(h, 'fontsize', 18);

  if (nargin > 0)
    figID = [varargin{1}];
    [folder, basename, ext] = fileparts(figID);
    figID = regexprep(basename, '\W+', '');
    if (not(strcmp('.png', ext))) figID = [ figID '.png' ]; end
  else
    figID = [ 'ANON' pdfdate '.png' ];
  endif

  # legend("boxoff");
  if (1)
    xgrid = get(gca, 'xgrid');
    ygrid = get(gca, 'ygrid');
    if (strcmp(xgrid, 'on') && strcmp(ygrid, 'on'))
      set(gca, 'gridcolor', 0.777*[1 1 1]);
    endif
    xminorgrid = get(gca, 'xminorgrid');
    if (strcmp(xminorgrid, 'on'))
      set(gca, 'minorgridcolor', 0.777*[1 1 1]);
    endif
    yminorgrid = get(gca, 'yminorgrid');
    if (strcmp(yminorgrid, 'on'))
      set(gca, 'minorgridcolor', 0.777*[1 1 1]);
    endif
  endif

  h = get(legend);
  if (strcmp(h.string{1}, 'data1'))
    legend('off');
  else
    set(legend, 'fontname', 'Times', 'fontsize', 14);
  endif

  hold off;
  box on;

  if (0 == exist("graphics", "dir"))
    [status, output] = system('mkdir graphics');
  endif
  local_path_to_file_ext = [ './graphics/' figID ];
  print(local_path_to_file_ext, '-color', '-dpng', '-S700,600', '-r600');
  delete(gcf);
endfunction
