function [result] = tex_alphanumericize(text_string)
  # -- Function: [result] = tex_alphanumericize(text_string)
  # given a text string,
  # returns a text string with mods
  # given the flag option, removes underscores

  text_string = strrep(text_string, ' ', '\_');
  text_string = strrep(text_string, '%', 'x');
  # generic subsitutions
  # idx = not(isalnum([text_string]));
  # text_string(idx) = '_'

  text_string = strrep(text_string, '_', '\_');
  result = text_string;
end
