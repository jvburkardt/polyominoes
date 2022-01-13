function i4mat_print ( m, n, a, label )

%*****************************************************************************80
%
%% i4mat_print() prints an I4MAT.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    10 September 2009
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns of the matrix.
%
%    integer A(M,N), an M by N matrix to be printed.
%
%    string LABEL, a title.
%
  i4mat_print_some ( m, n, a, 1, 1, m, n, label );

  return
end
