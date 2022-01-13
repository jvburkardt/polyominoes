function grid_display ( m, n, grid, colors, label )

%*****************************************************************************80
%
%% grid_display() displays a rectangular grid of squares with colors.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 April 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns.
%
%    integer GRID(M,N), contains, for the (I,J) cell, a color index.
%
%    real COLORS(*,3), a list of RGB color values.
%
%    string LABEL, a label to display with the plot.
%
  clf
  hold on

  for i = 1 : m
    for j = 1 : n
      k = grid(i,j);
      cell_ij_fill ( m, i, j, colors(k,:) );
    end
  end
  title ( label, 'FontSize', 24 );
  axis equal
  axis off
  hold off

  return
end
