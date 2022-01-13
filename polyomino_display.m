function polyomino_display ( p, label, filename )

%*****************************************************************************80
%
%% polyomino_display() displays a polyomino on a grid of squares.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    20 June 2021
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(P_M,P_N), a matrix of 0's and 1's.
%
%    string LABEL, a title for the plot.
%
%    string FILENAME, a name for the plotfile.
%

%
%  Determine the size of the polyomino array.
%
  [ p_m, p_n ] = size ( p );
%
%  Determine the size of the background grid.
%
  p_max = max ( p_m, p_n );
  g_m = p_max + 2;
  g_n = p_max + 2;
  g = zeros ( g_m, g_n );
%
%  Copy the polyomino into the grid.
%
  g_m2 = floor ( ( g_m - p_m ) / 2 ) + 1;
  g_n2 = floor ( ( g_m - p_n ) / 2 ) + 1;

  g(g_m2:g_m2+p_m-1,g_n2:g_n2+p_n-1) = p(1:p_m,1:p_n);
%
%  Display each square of the grid.
%
  clf ( );
  hold ( 'on' );

  for i = 1 : g_m
    for j = 1 : g_n

      k = g(i,j);

      if ( k == 0 )
        color = [ 1.0, 1.0, 1.0 ];
      elseif ( k == 1 )
        color = [ 0.5, 0.5, 0.5 ];
      end

      a = j - 1;
      b = j;
      c = g_m - ( i - 1 );
      d = g_m - i;

      fill ( [ a, b, b, a ], [ c, c, d, d ], color );

    end
  end

  title ( label );
  axis ( 'equal' );
  axis ( 'off' );
  hold ( 'off' );

  print ( '-dpng', filename );
  fprintf ( 1, '  Graphics saved as "%s"\n', filename );

  return
end
