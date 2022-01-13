function [ x_num, x ] = r8mat_rref_solve_binary_nz ( m, n, nz, a, b )

%*****************************************************************************80
%
%% r8mat_rref_solve_binary_nz() seeks binary solutions of an RREF system.
%
%  Discussion:
%
%    Any acceptable binary solution must have exactly NZ nonzero entries.
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
%    integer M, N, the rows and columns of the RREF matrix A.
%
%    integer NZ, the number of nonzeros required in any binary solution.
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
  verbose = true;
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

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  System has %d degrees of freedom.\n', klog );
  end
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
%  For debugging, print augmented system.
%
  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Augmented Row-Reduced Echelon Form system matrix A and right hand side B:\n' );
    fprintf ( 1, '  Columns associated with a free variable are headed with a "*"\n' );
    fprintf ( 1, '\n' );
    label(1:n) = ':';
    for k = 1 : klog
      j = freedom(k);
      label(j) = '*';
    end
    fprintf ( 1, '  ' );
    for j = 1 : n
      fprintf ( 1, ' %s', label(j) );
    end
    fprintf ( 1, '\n' );

    for i = 1 : m
      fprintf ( 1, '  ' );
      for j = 1 : n
        fprintf ( 1, '%2d', a(i,j) );
      end
      fprintf ( 1, '  %2d\n', b(i) );
    end
  end
%
%  Initialize to "empty" a list of binary soutions.
%
%  There are KLOG degrees of freedom, each of which could be set to 1.
%  There must be NZ variables set to 1.
%  Consider setting NZ2 degrees of freedom to 1, where NZ2 is between 0
%  and the minimum of NZ and KLOG.
%
%  Choose every possible selection of NZ2 degrees of freedom, and solve
%  the system.
%
%  If the resulting solution is binary, then add it to the list.
%
  x_num = 0;
  x = [];
  b_num = 0;

  for nz2 = 0 : min ( nz, klog )

    done = true;
    free_sub = [];

    while ( true )

      [ free_sub, done ] = ksub_next4 ( klog, nz2, free_sub, done );

      if ( done )
        break;
      end

      b2 = b;
      b2(freedom(free_sub(1:nz2))) = 1;
      b_num = b_num + 1;

      y = r8mat_u_solve ( n, a, b2 );

      if ( r8vec_is_binary ( n, y ) ) 
        x_num = x_num + 1;
        x(1:n,x_num) = y(1:n,1);
      end

    end

  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Tried %d right hands sides, found %d solutions.\n', b_num, x_num );
  end

  return
end
