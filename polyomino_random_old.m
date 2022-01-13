function s = polyomino_random_old ( m )

%*****************************************************************************80
%
%% polyomino_random_old() creates a random polyomino of M squares.
%
%  Discussion:
%
%    The function uses Redelmeier's algorithm.
%
%    This function returns a "sparse" representation of the polyomino.
%
%    This function was an incomplete implementation of the algorithm.
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
%    integer M, the number of squares.
%
%  Output:
%
%    integer S(M,2), grid points forming the polyomino.
%
%  Local:
%
%    integer G(*,2): grid points defining squares that neighbor the
%    polyomino.
%
  for i = 1 : m

    if ( i == 1 )

      s = [  0,  0 ];

      g = [  0, -1; ...
             0, +1; ...
            -1,  0; ...
            +1,  0 ];

    else
%
%  Select row c at random, and delete rows 1:c from g.
%
      [ g, c, c_index ] = i4row_take_random ( g );
%
%  Collect the neighbors of c.
%
      cn = i4row_neighbors ( c );
%
%  Discard any neighbors of c that already occur in s or g.
%
      cn = i4row_sorted_minus ( cn, s );
      cn = i4row_sorted_minus ( cn, g );
%
%  Add c to s.
%
      mc = size ( c, 1 );
      for k = 1 : mc
        s = i4row_sorted_insert ( s, c(k,1:2) );
      end
%
%  Add remaining neighbors of c to g.
%
      mcn = size ( cn, 1 );
      for k = 1 : mcn
        g = i4row_sorted_insert ( g, cn(k,1:2) );
      end

    end

  end

  return
end

