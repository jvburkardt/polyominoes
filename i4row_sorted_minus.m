function t = i4row_sorted_minus ( s, c )

%*****************************************************************************80
%
%% i4row_sorted_minus() deletes from S any rows occurring also in C.
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
%    09 January 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer S(MS,N), an array of rows.
%
%    integer C(MC,N), a sorted array of rows.
%
%  Output:
%
%    integer T(MT,N), an array of the rows of S that do not occur in C.
%
%
  [ m, n ] = size ( s );

  t = [];

  for i = 1 : m
    
    if ( i4row_sorted_search ( c, s(i,1:n) ) == -1 )
      t = [ t; s(i,1:n) ];
    end

  end

  return
end

