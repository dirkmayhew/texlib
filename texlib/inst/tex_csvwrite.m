function [CSV_filename] = tex_csvwrite(varargin)
  # -- function [CSV_filename] = tex_csvwrite(CSV_filename, DATA)
  #	given a .CSV file name and a data matrix
  #	writes a .CSV containing the data into the ./CSV subdirectory of the pwd

  if (nargin < 2)
    error('not enough inputs')
  else
    v = 1;
    CSV_filename = [varargin{v}]; v++;
    DATA = [varargin{v}]; v++;
  endif

  [base, ext] = strtok(CSV_filename, '.');
  if strcmp(toupper(ext), "CSV")
  else
    CSV_filename = [ CSV_filename ".csv" ];
  endif

  if not(exist("CSV", "dir"))
    [status, output] = system('mkdir CSV');
  endif

  cd CSV
  # CSV_filename
  csvwrite(CSV_filename, DATA);
  cd ..
endfunction
