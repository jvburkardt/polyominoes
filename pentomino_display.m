function pentomino_display ( p, label )

%*****************************************************************************80
%
%% pentomino_display() displays a particular pentomino in a 5x5 grid.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 April 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(P_M,P_N), a matrix of 0's and 1's.
%    1 <= P_M, P_N <= 5.  There should be exactly 5 values of one.
%
%    string LABEL, a title for the plot.
%

%
%  The background grid.
%
  grid_m = 5;
  grid_n = 5;
  grid = zeros ( grid_m, grid_n );
%
%  Place the pentomino on the grid, so that it is "snug" in the upper left corner.
%
  [ p_m, p_n ] = size ( p );

  grid(1:p_m,1:p_n) = p(1:p_m,1:p_n);
%
%  Display each square of the grid.
%
  clf ( );
  hold ( 'on' );

  for i = 1 : grid_m
    for j = 1 : grid_n

      k = grid(i,j);

      if ( k == 0 )
        color = [ 1.0, 1.0, 1.0 ];
%
%  For some MORONIC reason, color [ 0, 0, 0 ] becomes WHITE, not BLACK!
%
      elseif ( k == 1 )
        color = [ 0.1, 0.1, 0.1 ];
      elseif ( k == 2 )
        color = [ 1.0, 0.0, 0.0 ];
      elseif ( k == 3 )
        color = [ 0.0, 0.0, 1.0 ];
      elseif ( k == 4 )
        color = [ 1.0, 1.0, 0.0 ];
      elseif ( k == 5 )
        color = [ 1.0, 0.8, 0.6 ];
      elseif ( k == 6 )
        color = [ 0.8, 0.4, 0.0 ];
      end

      a = j - 1;
      b = j;
      c = grid_m - ( i - 1 );
      d = grid_m - i;

      fill ( [ a, b, b, a ], [ c, c, d, d ], color );

    end
  end

  title ( label );
  axis ( 'equal' );
  axis ( 'off' );
  hold ( 'off' );

  filename = sprintf ( '%s.png', label );
  print ( '-dpng', filename );
  fprintf ( 1, '  Graphics saved as "%s"\n', filename );

  return
end
