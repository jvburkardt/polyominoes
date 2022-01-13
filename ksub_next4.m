function [ a, done ] = ksub_next4 ( n, k, a, done )

%*****************************************************************************80
%
%% ksub_next4() generates subsets of size K from a set of size N, one at a time.
%
%  Discussion:
%
%    The subsets are generated one at a time.
%
%    The routine should be used by setting DONE to TRUE, and then calling
%    repeatedly.  Each call returns with DONE equal to FALSE, the array
%    A contains information defining a new subset.  When DONE returns
%    equal to TRUE, there are no more subsets.
%
%    There are ( N*(N-1)*...*(N+K-1)) / ( K*(K-1)*...*2*1) such subsets.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 May 2018
%
%  Author:
%
%    John Burkardt.
%
%  Input:
%
%    integer N, the size of the entire set.
%    K <= N.
%
%    integer K, the size of the desired subset.
%    0 <= K <= N.
%
%    integer A(K), is not needed on the first call, with DONE = TRUE.
%    On subsequent calls, it should be the output value of A from the
%    previous call.
%
%    logical DONE, should be TRUE on the first call, to force 
%    initialization, and then FALSE on subsequent calls.
%
%  Output:
%
%    integer A(K), as long as DONE is returned FALSE, A 
%    is the next K subset.
%
%    logical DONE, is TRUE if the routine is returning the
%    next K subset, and FALSE if there are no more subsets to return.
%  
  if ( k < 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'ksub_next4 - Fatal error!\n' );
    fprintf ( 1, '  K = %d\n', k );
    fprintf ( 1, '  but 0 <= K is required!\n' );
    error ( 'ksub_next4 - Fatal error!' );
  end

  if ( n < k )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'ksub_next4 - Fatal error!\n' );
    fprintf ( 1, '  N = %d\n', n );
    fprintf ( 1, '  K = %d\n', k );
    fprintf ( 1, '  but K <= N is required!\n' );
    error ( 'ksub_next4 - Fatal error!' );
  end
%
%  First call:
%
  if ( done )

    a(1:k) = ( 1 : k )';
    done = false;
%
%  Empty set returned on previous call?
%
  elseif ( k == 0 || n == 0 )

    done = true;
%
%  Next call.
%
  elseif ( a(1) < n - k + 1 )

    jsave = k;

    for j = 1 : k - 1
       if ( a(j) + 1 < a(j+1) )
        jsave = j;
        break
      end
    end

    a(1:jsave-1) = ( 1 : ( jsave - 1 ) )';
    a(jsave) = a(jsave) + 1;
    done = false;

  else

    done = true;

  end

  return
end
