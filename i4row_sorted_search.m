function indx = i4row_sorted_search ( a, b )

%*****************************************************************************80
%
%% i4row_sorted_search() searches an ascending sorted I4ROW.
%
%  Discussion:
%
%    Binary search is used.
%
%    The array may contain multiple occurrences of the search object,
%    but only one occurrence will be reported.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    17 April 2005
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Donald Kreher, Douglas Simpson,
%    Combinatorial Algorithms,
%    CRC Press, 1998, page 26.
%
%  Input:
%
%    integer A(M,N), the array to be searched.  A must
%    be sorted in ascending order.
%
%    integer B(1,N), the value to be searched for.
%
%  Output:
%
%    integer INDX, the result of the search.
%    -1, B does not occur in A.
%    I, A(I) = B.
%
  [ m, n ] = size ( a );

  indx = -1;

  low = 1;
  high = m;

  while ( low <= high )

    mid = floor ( ( low + high ) / 2 );

    isgn = i4vec_compare ( a(mid,1:n), b(1,1:n) );

    if ( isgn == 0 )
      indx = mid;
      break
    elseif ( isgn == -1 )
      low = mid + 1;
    elseif ( isgn == +1 )
      high = mid - 1;
    end

  end

  return
end
