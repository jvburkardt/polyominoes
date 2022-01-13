function i4vec2_print ( n, a, b, title )

%*****************************************************************************80
%
%% i4vec2_print() prints an I4VEC2.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    06 November 2005
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer N, the number of components of the vector.
%
%    integer A(N), B(N), the vectors to be printed.
%
%    string TITLE, a title.
%
  if ( 0 < length ( title ) )
    fprintf ( 1, '\n' );
    fprintf ( 1, '%s\n', title );
  end
  fprintf ( 1, '\n' );

  for i = 1 : n
    fprintf ( 1, '  %4d: %8d  %8d\n', i, a(i), b(i) );
  end

  return
end
