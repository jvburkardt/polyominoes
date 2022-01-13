function grid = grid_add ( p_m, p_n, p_cells, p_row, p_col, p_color_index, ...
  g_m, g_n, grid )

%*****************************************************************************80
%
%% grid_add() adds the region, or a polyomino tile, to the grid.
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
%  Input:
%
%    integer P_M, P_N, the number of rows and columns of the 
%    binary matrix representing the polyomino tile.
%
%    integer P_CELLS(P_M,P_N), the binary representation of the 
%    polyomino tile.
%
%    integer P_ROW, P_COL, the index of the row and column of the
%    grid in which row 1, column 1 of the polyomino tile will appear.
%    Row 1 is the top row, column 1 is the left column.
%
%    integer P_COLOR_INDEX, a number indicating the color to be used
%    for this tile.
%
%    integer G_M, G_N, the number of rows and columns in the grid.
%
%    integer GRID(G_M,G_N), the grid, which contains the 
%    representation of the rectangular grid, the region (which is a subset
%    of the rectangle), and the polyomino tiles that have been placed.
%
%  Output:
%
%    integer GRID(G_M,G_N), the grid, which contains the 
%    representation of the rectangular grid, the region (which is a subset
%    of the rectangle), and the polyomino tiles that have been placed.
%    
  for i = 1 : p_m
    for j = 1 : p_n
      if ( p_cells(i,j) == 1 )
        grid(p_row+i-1,p_col+j-1) = p_color_index;
      end
    end
  end

  return
end
