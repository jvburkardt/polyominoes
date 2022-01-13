function cell_ij_fill ( m, i, j, color )

%*****************************************************************************80
%
%% cell_ij_fill() plots a filled (I,J) cell.
%
%  Discussion:
%
%    We assume the data is represented in a matrix.
%
%    In order to convert between the matrix coordinates and picture
%    coordinates, the (I,J) cell will be drawn with the following corners:
%
%    (j-1,m-i+1), (j,m-i+1), (j,m-i), (j-1,m-1).
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    28 October 2017
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, the maximum row index.
%
%    integer I, J, the index of the cell.
%
%    MATLAB color COLOR, can be any of the 8 abbreviated color terms
%    'r', 'g', 'b', 'c', 'm', 'y', 'w', 'k', or an RGB triple such as 
%    [1.0,0.4,0.0].  The square is filled with this color.
%
  a = j - 1;
  b = j;
  c = m - ( i - 1 );
  d = m - i;

  fill ( [ a, b, b, a ], [ c, c, d, d ], color );

  return
end
