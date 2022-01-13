function p = pentomino_matrix ( name )

%*****************************************************************************80
%
%% pentomino_matrix() returns a 0/1 matrix defining a particular pentomino.
%
%  Discussion:
%
%    The pentomino matrices are arranged in such a way that the row dimension
%    is never greater than 3.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    character NAME, is 'F', 'I', 'L', 'N', 'P', 'T', 'U', 'V', 
%    'W', 'X', 'Y', or 'Z'.
%
%  Output:
%
%    integer P(P_M,P_N), a matrix of 0's and 1's that indicates
%    the shape of the pentomino.
%
  if ( lower ( name ) == 'f' )

    p = [ 0, 1, 1; ...
          1, 1, 0; ...
          0, 1, 0 ];

  elseif ( lower ( name ) == 'i' )

    p = [ 1, 1, 1, 1, 1 ];

  elseif ( lower ( name ) == 'l' )

    p = [ 0, 0, 0, 1; ...
          1, 1, 1, 1 ];

  elseif ( lower ( name ) == 'n' )

    p = [ 1, 1, 0, 0; ...
          0, 1, 1, 1 ];

  elseif ( lower ( name ) == 'p' )

    p = [ 1, 1; ...
          1, 1; ...
          1, 0 ];

  elseif ( lower ( name ) == 't' )

    p = [ 1, 1, 1; ...
          0, 1, 0; ...
          0, 1, 0 ];

  elseif ( lower ( name ) == 'u' )

    p = [ 1, 0, 1; ...
          1, 1, 1 ];

  elseif ( lower ( name ) == 'v' )

    p = [ 1, 0, 0; ...
          1, 0, 0; ...
          1, 1, 1 ];

  elseif ( lower ( name ) == 'w' )

    p = [ 1, 0, 0; ...
          1, 1, 0; ...
          0, 1, 1 ];

  elseif ( lower ( name ) == 'x' )

    p = [ 0, 1, 0; ...
          1, 1, 1; ...
          0, 1, 0 ];

  elseif ( lower ( name ) == 'y' )

    p = [ 0, 0, 1, 0; ...
          1, 1, 1, 1 ];

  elseif ( lower ( name ) == 'z' )

    p = [ 1, 1, 0; ...
          0, 1, 0; ...
          0, 1, 1 ];

  else

    fprintf ( 1, '\n' );
    fprintf ( 1, 'pentomino_matrix(): Fatal error!\n' );
    fprintf ( 1, '  Illegal name = "%s"\n', name );
    fprintf ( 1, '  Legal names: F, I, L, N, P, T, U, V, W, X, Y, Z.\n' );
    error ( 'pentomino_matrix(): Fatal error!\n' );

  end

  return
end

