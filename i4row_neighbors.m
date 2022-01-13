function cn = i4row_neighbors ( c )

%*****************************************************************************80
%
%% i4row_neighbors() returns the four neighbors of a grid point.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 January 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer C(1,2), the coordinates of a grid point.
%
%  Output:
%
%    integer CN(4,2), the coordinates of neighboring grid points.
%
  [ m, n ] = size ( c );

  if ( m ~= 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'i4row_neighbors - Fatal error!\n' );
    fprintf ( 1, '  First dimension of C must be 1.\n' );
    error ( 'i4row_neighbors - Fatal error!' );
  end

  if ( n ~= 2 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'i4row_neighbors - Fatal error!\n' );
    fprintf ( 1, '  Second dimension of C must be 2.\n' );
    error ( 'i4row_neighbors - Fatal error!' );
  end

  cn = [ ...
    c(1,1) - 1, c(1,2); ...
    c(1,1),     c(1,2) - 1; ...
    c(1,1),     c(1,2) + 1; ...
    c(1,1) + 1, c(1,2) ];

  return
end

