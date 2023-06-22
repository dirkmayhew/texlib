function [X] = tex_log(varargin)
  # -- Function: [output] = tex_log(text[, log file name])
  # updates (or creates) a text file  tex_log.log in a ~/log subdirectory,
  #  creating the subdirectory if needed.
  #  if given a text string, appends the string to the file,
  #  prepended with a date & time stamp
  #  usage example:  tex_log('this is text');
  # given no input, creates the file as empty (destroys previous versions, if they exist)
  # returns 0.
  #
  #  see also pdfdate

  # dirk copied from ATm some time in 2016 (I think)

  if (0 == exist("log", "dir"))
    [status, output] = system('mkdir log');
  endif
  cd log;

  log_file_name = 'tex_log.txt';

  if (0 == nargin)
    log_text = 'initialize log file';
    [fid, msg] = fopen([ log_file_name ], "w");
    fclose(fid);
  else
    v = 1;
    log_text = [varargin{v}]; v++;
    if (nargin > 1)
      log_file_name = [varargin{v}]; v++;
    endif
  endif

  [fid, msg] = fopen(log_file_name, "a");
  fputs(fid, ["\r\n" pdfdate ': ' log_text]);
  fclose(fid);

  disp(log_text);
  cd ..

  X = 0;
endfunction # function [X] = tex_log(varargin)
