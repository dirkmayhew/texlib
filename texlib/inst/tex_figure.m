function [h_fig] = tex_figure()
  # -- Function file function [h_fig] = tex_figure()
  #	creates a figure window with standarized settings
  #  returns a figure handle for further manipulation of that window
  # note: sets graphics toolkit to gnuplot

  # 21JUL2012 functionized for move to Chrysler
  # 5JUL2013 added delete(gcf)  - woo risky!  removed later
  # 5JUL2014 packaged
  # 14NOV2019 moved graphics_toolkit here & turned off tex interpreter - seems to help the legend border

  graphics_toolkit('fltk');
  # graphics_toolkit('gnuplot');

  h_fig = figure;
  clf;

  hold on;
end
