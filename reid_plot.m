function reid_plot ( )

%*****************************************************************************80
%
%% reid_plot() plots a tiling of the Reid region.
%
%  Discussion:
%
%    The region is represented by
%
%      1 1 0
%      1 1 1
%      1 1 1
%
%    and it is to be tiled by 4 polyominoes, all of which can be
%    represented by 
%
%      1 1
%    or
%      1
%      1
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
  fprintf ( 1, 'reid_plot\n' );
  fprintf ( 1, '  A simple illustration of polyomino tiling.n' );
  fprintf ( 1, '  In this example, a region of 8 squares is to be covered\n' );
  fprintf ( 1, '  by 4 tiles, each of which is a pair of squares.\n' );
%
%  Choose the colors.
%
  gray = [ 0.8, 0.8, 0.8 ];
  white = [ 1, 1, 1 ];
  colors = hsv ( 4 );
  colors = [ gray; white; colors ];
%
%  Define the background grid as a 3x2 gray rectangle.
%
  g_m = 3;
  g_n = 3;
  g_color_index = 1;
  grid = g_color_index * ones ( g_m, g_n );
  grid_display ( g_m, g_n, grid, colors, 'Grid' );
  pause
%
%  Define the region as a subset of the grid, drawn in white.
%
  r_m = 3;
  r_n = 3;
  r_cells = [ ...
    1, 1, 0;
    1, 1, 1;
    1, 1, 1 ];
  r_row = 1;
  r_col = 1;
  r_color_index = 2;
  grid = grid_add ( r_m, r_n, r_cells, r_row, r_col, r_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'Region' );
  pause
%
%  We have 4 tiles to place in the cell.
%
  p_m = 1;
  p_n = 2;
  p_cells = [ ...
    1, 1 ];
  p_row = 1;
  p_col = 1;
  p_color_index = 3;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P1' );
  pause

  p_m = 2;
  p_n = 1;
  p_cells = [ ...
    1;
    1 ];
  p_row = 2;
  p_col = 1;
  p_color_index = 4;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P2' );
  pause

  p_m = 1;
  p_n = 2;
  p_cells = [ ...
    1, 1 ];
  p_row = 2;
  p_col = 2;
  p_color_index = 5;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P3' );
  pause

  p_m = 1;
  p_n = 2;
  p_cells = [ ...
    1, 1 ];
  p_row = 3;
  p_col = 2;
  p_color_index = 6;
  grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, g_m, g_n, grid );
  grid_display ( g_m, g_n, grid, colors, 'P4' );
%
%  Plot the final configuration.
%
  print ( '-dpng', 'reid.png' );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'reid_plot:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
