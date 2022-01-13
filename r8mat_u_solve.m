function x = r8mat_u_solve ( n, a, b )

%*****************************************************************************80
%
%% r8mat_u_solve() solves an upper triangular linear system.
%
%  Discussion:
%
%    An R8MAT is an MxN array of R8's, stored by (I,J) -> [I+J*M].
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    15 January 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer N, the number of rows and columns of the matrix A.
%
%    real A(N,N), the N by N upper triangular matrix.
%
%    real B(N,:), the right hand side of the linear system.
%
%  Output:
%
%    real X(N,:), the solution of the linear system.
%

%
%  Solve U * x = b.
%
  x = b;

  for i = n : -1 : 1
    for j = i + 1 : n
      x(i) = x(i) - a(i,j) * x(j);
    end
    x(i) = x(i) / a(i,i);
  end

  return
end
