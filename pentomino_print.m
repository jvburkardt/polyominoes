function pentomino_print ( m, n, p, label )

%*****************************************************************************80
%
%% pentomino_print() prints a pentomino.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns in the representation.
%
%    integer P(MP,NP), a matrix representing the polyomino.  
%
%    string LABEL, a label to be printed first.  
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '%s\n', label );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, ' ' );
    for j = 1 : n
      fprintf ( 1, ' %d', p(i,j) );
    end
    fprintf ( 1, '\n' );
  end

  return
end
