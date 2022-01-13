function A = i4row_sorted_insert ( A, r )

%*****************************************************************************80
%
%% i4row_sorted_insert() inserts an i4row into a sorted i4row array.
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
%    integer A(m,n), an ascending sorted array of rows.
%
%    integer r(m2,n), a new row.
%
%  Output:
%
%    integer A(m+1,n), the ascending sorted array of rows, with r inserted.
%
  [ m, n ] = size ( A );
  
  if ( m < 1 )
    A = r;
  elseif ( i4vec_compare ( r, A(1,1:n) ) == -1 )
    A = [ r; A ];
  elseif ( i4vec_compare ( A(m,1:n), r ) == -1 )
    A = [ A; r ];
  else
    low = 1;
    high = m;

    while ( true )

      mid = floor ( ( low + high ) / 2 );

      if ( i4vec_compare ( r, A(mid,1:n) ) == -1 )
        high = mid;
      elseif ( i4vec_compare ( A(mid,1:n), r ) == -1 )
        low = mid;
      else
        break;
      end

      if ( high == low + 1 )
        A = [ A(1:low,1:n); ...
              r; ...
              A(low+1:m,1:n) ];
        break;
      end
        
    end

  end

  return
end

