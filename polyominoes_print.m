function polyominoes_print ( mp, np, p_num, p, label )

%*****************************************************************************80
%
%% polyominoes_print() prints polyominoes packed in an array.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    27 May 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer MP, NP, the number of rows and columns in the representation.
%
%    integer P_NUM, the number of polyominoes.
%
%    integer P(MP,NP,P_NUM), a matrix representing the polyominoes.  
%
%    string LABEL, a label to be printed first.  
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '%s\n', label );
  fprintf ( 1, '\n' );

  if ( mp <= 0 || np <= 0 || p_num <= 0 )
    fprintf ( 1, '  [ Null matrix ]\n' );
  else
    fprintf ( 1, '  %dx%d array of %d polyominoes:\n', mp, np, p_num );
    for k = 1 : p_num
      [ mq, nq, q ] = polyomino_condense ( mp, np, p(1:mp,1:np,k) );
      label2 = sprintf ( '  Polyomino #%d', k );
      polyomino_print ( q, label2 );
    end
  end

  return
end
