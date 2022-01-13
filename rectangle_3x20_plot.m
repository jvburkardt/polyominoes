function rectangle_3x20_plot ( )

%*****************************************************************************80
%
%% rectangle_3x20_plot() plots a tiling of the 3x20 rectangle.
%
%  Discussion:
%
%    The region is represented by
%
%      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
%      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
%      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
%
%    and it is to be tiled by the 12 pentominoes, each of which 
%    is composed of 5 squares.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 April 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'rectangle_3x20_plot\n' );
  fprintf ( 1, '  An illustration of polyomino tiling.\n' );
  fprintf ( 1, '  In this example, a region of 3x20 squares is to be covered\n' );
  fprintf ( 1, '  by the 12 pentominoes.\n' );
%
%  Choose the colors.
%
  gray = [ 0.8, 0.8, 0.8 ];
  white = [ 1, 1, 1 ];
  colors = jet ( 12 );
  idx = randperm ( 12 );
  colors = colors(idx,1:3);
  colors = [ gray; white; colors ];
%
%  Define the background grid as a 3x20 gray rectangle.
%
  g_m = 3;
  g_n = 20;
  g_color_index = 1;
  grid = g_color_index * ones ( g_m, g_n );
  grid_display ( g_m, g_n, grid, colors, 'Grid' );
  pause
%
%  Define the region as a subset of the grid, drawn in white.
%
  r_m = 3;
  r_n = 20;
  r_cells = ones ( 3, 20 );
  r_row = 1;
  r_col = 1;
  r_color_index = 2;
  grid = grid_add ( r_m, r_n, r_cells, r_row, r_col, r_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'Region' );
  pause
%
%  We have 12 tiles to place in the cell.
%
  p_m = 3;
  p_n = 2;
  p_cells = [ ...
    1, 1; ...
    1, 0; ...
    1, 1 ];
  p_row = 1;
  p_col = 1;
  p_color_index = 3;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P1' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    0, 1, 0; ...
    1, 1, 1; ...
    0, 1, 0 ];
  p_row = 1;
  p_col = 2;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P2' );
  pause

  p_m = 2;
  p_n = 3;
  p_cells = [ ...
    1, 1, 1; ...
    0, 1, 1 ];
  p_row = 1;
  p_col = 4;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P3' );
  pause

  p_m = 1;
  p_n = 5;
  p_cells = [ ...
    1, 1, 1, 1, 1 ];
  p_row = 3;
  p_col = 4;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P4' );
  pause

  p_m = 2;
  p_n = 4;
  p_cells = [ ...
    1, 1, 1, 1; ...
    1, 0, 0, 0 ];
  p_row = 1;
  p_col = 7;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P5' );
  pause

  p_m = 2;
  p_n = 4;
  p_cells = [ ...
    1, 1, 0, 0; ...
    0, 1, 1, 1 ];
  p_row = 2;
  p_col = 8;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P6' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    0, 1, 0; ...
    1, 1, 1; ...
    0, 0, 1 ];
  p_row = 1;
  p_col = 10;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P7' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    1, 1, 1; ...
    0, 1, 0; ...
    0, 1, 0 ];
  p_row = 1;
  p_col = 12;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P8' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    0, 1, 1; ...
    1, 1, 0; ...
    1, 0, 0 ];
  p_row = 1;
  p_col = 14;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P9' );
  pause

  p_m = 2;
  p_n = 4;
  p_cells = [ ...
    0, 1, 0, 0; ...
    1, 1, 1, 1 ];
  p_row = 2;
  p_col = 15;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P10' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    1, 0, 0; ...
    1, 1, 1; ...
    0, 0, 1 ];
  p_row = 1;
  p_col = 17;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P11' );
  pause

  p_m = 3;
  p_n = 3;
  p_cells = [ ...
    1, 1, 1; ...
    0, 0, 1; ...
    0, 0, 1 ];
  p_row = 1;
  p_col = 18;
  p_color_index = p_color_index + 1;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P12' );
%
%  Plot the final configuration.
%
  print ( '-dpng', 'rectangle_3x20.png' );

  return
end
