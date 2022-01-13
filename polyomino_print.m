function polyomino_print ( p, label )

%*****************************************************************************80
%
%% polyomino_print() prints a polyomino.
%
%  Discussion:
%
%    A polyomino is represented as a subset of an MxN grid.
%    The MxN matrix P has Pij=1 if the polyomino includes the (i,j) square,
%    and 0 otherwise.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    21 June 2021
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(M,N), a matrix representing the polyomino.  
%
%    string LABEL, a label to be printed.  
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '%s\n', label );
  fprintf ( 1, '\n' );

  [ m, n ] = size ( p );

  if ( m <= 0 || n <= 0 )
    fprintf ( 1, '  [ Null matrix ]\n' );
  else
    for i = 1 : m
      fprintf ( 1, ' ' );
      for j = 1 : n
        fprintf ( 1, ' %d', p(i,j) );
      end
      fprintf ( 1, '\n' );
    end
  end

  return
end
