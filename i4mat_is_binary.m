function value = i4mat_is_binary ( m, n, x )

%*****************************************************************************80
%
%% i4mat_is_binary() is true if an I4MAT only contains 0 and 1 entries.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the dimension of the array.
%
%    integer X(M,N), the array to be checked.
%
%  Output:
%
%    logical VALUE, is true if X only contains 0 or 1 entries.
%
  t = x .* ( x - 1 );
  value = ( all ( all ( t ) ) == 0 );

  return
end
