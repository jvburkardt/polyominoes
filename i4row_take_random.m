function [ g, c, index ] = i4row_take_random ( g )

%*****************************************************************************80
%
%% i4row_take_random() extracts a random row from an I4ROW.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    01 February 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer G(M1,N), the original row array.
%
%  Output:
%
%    integer G(M2,N), the modified row array.
%    All rows up to and including the randomly chosen row have
%    been deleted.
%
%    integer C(1,N), the row that was selected.
%
%    integer INDEX: the index of the row.
%
  [ m, n ] = size ( g );

  if ( m < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, '  i4row_take_random - Fatal error!\n' );
    fprintf ( 1, '  Input matrix has m = %d rows\n', m );
    error ( '  i4row_take_random - Fatal error!' )
  end

  if ( n < 1 )
    fprintf ( 1, '\n' );
    fprintf ( 1, '  i4row_take_random - Fatal error!\n' );
    fprintf ( 1, '  Input matrix has n = %d columns\n', n );
    error ( '  i4row_take_random - Fatal error!' )
  end

  index = randi ( m );

  c = g(index,1:n);
%
%  First try simply removed row index.
%
% g = [ g(1:index-1,1:n); ...
%       g(i+1:m,1:n) ];
%
%  Second try removed rows 1:index.
%
  g = [ g(index+1:m,1:n) ];

  return
end

