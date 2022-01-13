function p = polyomino_random ( squares )

%*****************************************************************************80
%
%% polyomino_random() creates a random polyomino of M squares.
%
%  Discussion:
%
%    The function uses Redelmeier's algorithm.
%
%    This function returns a "sparse" representation of the polyomino.
%
%    In some cases, the algorithm can reach a dead end before M
%    squares have been assembled.
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
%    integer SQUARES, the number of squares to use.
%
%  Output:
%
%    integer P(M,N), a rectangle containing 1's for polyomino squares
%    and 0's for voids.
%
%  Local:
%
%    integer G(*,3): each row contains (x,y,z).
%    x and y are the center of a square.
%    z is +1 if the square:
%    +1: the square is part of the polyomino.
%     0: the square is not part of the polyomino, but available.
%    -1: the square is not part of the polyomino, and unavailable.
%
  u = [ 1, -1, 0,  0 ];
  v = [ 0,  0, 1, -1 ];

  for k = 1 : squares

    if ( k == 1 )

      g = [  0,  0,  1; ...
             0, -1,  0; ...
             0, +1,  0; ...
            -1,  0,  0; ...
            +1,  0,  0 ];
      row_num = 5;

      p = [ 0, 0 ];

    else
%
%  Select a random available row representing square C.
%
      c_row = -1;
      candidate_num = 0;

      for row = 1 : row_num

        if ( g(row,3) == 0 )
          candidate_num = candidate_num + 1;
          if ( candidate_num == 1 )
            c_row = row;
          else
            r = rand ( );
            if ( r * candidate_num <= 1.0 )
              c_row = row;
            end
          end

        end

      end

      if ( c_row == -1 )
        fprintf ( 1, '\n' );
        fprintf ( 1, 'polyomino_random(): Error!\n' );
        fprintf ( 1, '  No candidates available for next square.\n' );
        s = [];
        return    
      end
%
%  Promote the random available row into the polyomino.
%
      g(c_row,3) = +1;
      p = [ p; g(c_row,1), g(c_row,2) ];
%
%  Disqualify all available rows of lower index.
%
      for row = 1 : c_row - 1
        if ( g(row,3) == 0 )
          g(row,3) = -1;
        end
      end
%
%  If available, insert the neighbors of C into G.
%
      for k2 = 1 : 4
        d = [ g(c_row,1) + u(k2), g(c_row,2) + v(k2), 0 ];
        if ( ~ ismember ( d(1:2), g(:,1:2), 'rows' ) )
          g = [ g; d ];
          row_num = row_num + 1;
        end
      end

    end

    if ( false )
      disp ( g );
      disp ( p )
      pause ( );
    end

  end
%
%  Create the P array.
%
  imin = Inf;
  imax = -Inf;
  jmin = Inf;
  jmax = -Inf;

  for row = 1 : row_num
    if ( g(row,3) == 1 )
      imin = min ( imin, g(row,1) );
      imax = max ( imax, g(row,1) );
      jmin = min ( jmin, g(row,2) );
      jmax = max ( jmax, g(row,2) );
    end
  end

  m = imax + 1 - imin;
  n = jmax + 1 - jmin;

  p = zeros ( m, n );
  for row = 1 : row_num
    if ( g(row,3) == 1 )
      i = g(row,1) + 1 - imin;
      j = g(row,2) + 1 - jmin;
      p(i,j) = 1;
    end
  end

  return
end

