function [ x_num, x ] = r8mat_rref_solve_binary ( m, n, a, b )

%*****************************************************************************80
%
%% r8mat_rref_solve_binary() seeks binary solutions of an RREF system.
%
%  Discussion:
%
%    An MxN linear system Ax = b is considered, in which only binary
%    solutions are allowed; that is, each entry of x is either 0 or 1.
%
%    The matrix A and right hand side B are assumed to have been converted
%    to row-reduced echelon form.  Therefore, the matrix A satisfies:
%
%    * The first nonzero entry in each row is 1.
%
%    * The leading 1 in a given row occurs in a column to
%      the right of the leading 1 in the previous row.
%
%    * Rows which are entirely zero must occur last.
%
%    The matrix is in reduced row echelon form if, in addition to
%    the first three conditions, it also satisfies:
%
%    * Each column containing a leading 1 has no other nonzero entries.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 May 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns of
%    the RREF matrix A.
%
%    real A(M,N), the RREF matrix to be analyzed. 
%
%    real B(M), the RREF right hand side.
%
%  Output:
%
%    integer X_NUM, the number of binary solutions.
%    Note that there may be no binary solutions at all.
%
%    real X(N,X_NUM), the solutions.
%

%
%  Remove the zero rows of A.
%
  while ( 0 < m )
    if ( sum ( abs ( a(m,1:n) ) ) == 0.0 )
      a = a(1:m-1,1:n);
      m = m - 1;
    else
      break
    end
  end
%
%  Number of dimensions of freedom is n - m.
%
  klog = n - m;
%
%  Determine the indeterminate variables.
%  Insert corresponding data in A and B.
%
  freedom = [];
  if ( 0 < klog )
    for j = 1 : n
      if ( j <= m )
        if ( a(j,j) ~= 1 )
          a = [ a(1:j-1,1:n); r8vec_identity_row(n,j); a(j:m,1:n) ];
          b = [ b(1:j-1); 0; b(j:m) ];
          freedom = [ freedom; j ];
          m = m + 1;
        end
      else
        a = [ a; r8vec_identity_row(n,j) ];
        b = [ b; 0 ];
        freedom = [ freedom; j ];
        m = m + 1;
      end
    end
  end
%
%  The indeterminate variables have a simple equation 
%    x(i) = b(i) = 0 or 1
%  Set up and solve every variation of this system.
%  If a solution is binary, accept it.
%
  x_num = 0;
  x = [];

  binary = zeros ( klog, 1 );

  while ( true )

    b2 = b;
    for k = 1 : klog
      i = freedom(k);
      b2(i) = binary(k);
    end

    y = r8mat_u_solve ( n, a, b2 );

    if ( r8vec_is_binary ( n, y ) ) 
      x_num = x_num + 1;
      x(1:n,x_num) = y(1:n,1);
    end

    binary = r8vec_binary_next ( klog, binary );

    if ( sum ( binary ) == 0 )
      break
    end

  end

  return
end
