function [ m, n, k, a, b, x ] = polyomino_monohedral ( r, p, filename, comment )

%*****************************************************************************80
%
%% polyomino_monohedral() analyzes tiling a region with a single polyomino type.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 May 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R(M_R,N_R), the binary matrix describing the region.
%
%    integer P(M_P,N_P), the binary matrix describing the polyomino.
%
%    string FILENAME, a name for the LP file that will contain the
%    definition of the problem.
%
%    string COMMENT, a comment that will be the first line of the 
%    LP file.
%
%  Output:
%
%    integer M, N, K, the number of equations, the number of variables,
%    and the number of binary solutions found.
%
%    integer A(M,N), the matrix of equation coefficients, which should
%    all be 0 or 1.
%
%    integer B(M), the right hand sides, which should all be 1.
%
%    integer X(N,K), a set of K solutions to the problem, each
%    consisting of a binary value (0 or 1) for every possible placement
%    of a copy of P onto R.
%
  verbose = true;

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  The internal variable "verbose" is set to "true";\n' );
    fprintf ( 1, '  Print statements marked "VERBOSE" can be suppressed\n' );
    fprintf ( 1, '  by setting "verbose" to "false".\n' );
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, 'polyomino_monohedral:\n' );
    fprintf ( 1, '  Analyze the problem of tiling a region R using copies,\n' );
    fprintf ( 1, '  possibly rotated or reflected, of a single polyomino P.\n' );
  end
%
%  A: Check the binary matrix describing the region.
%  Make sure it is binary.
%  Make sure it is "tight".
%
  [ m_r, n_r ] = size ( r );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input R has shape (%d,%d).\n', m_r, n_r );
  end

  if ( ~ i4mat_is_binary ( m_r, n_r, r ) )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Fatal error!\n' );
    fprintf ( 1, '  The matrix R has entries that are not 0 and not 1.\n' );
    error ( 'polyomino_monohedral - Fatal error!\n' );
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input R is a binary matrix.\n' );
  end

  [ m_r, n_r, r ] = polyomino_condense ( m_r, n_r, r );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Condensed R has shape (%d,%d).\n', m_r, n_r );
  end
%
%  B: Check the binary matrix describing the polyomino.
%  Make sure it is binary.
%  Make sure it is "tight".
%
  [ m_p, n_p ] = size ( p );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input P has shape (%d,%d).\n', m_p, n_p );
  end

  if ( ~ i4mat_is_binary ( m_p, n_p, p ) )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Fatal error!\n' );
    fprintf ( 1, '  The matrix P has entries that are not 0 and not 1.\n' );
    error ( 'polyomino_monohedral - Fatal error!\n' );
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Input P is a binary matrix.\n' );
  end

  [ m_p, n_p, p ] = polyomino_condense ( m_p, n_p, p );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Condensed P has shape (%d,%d).\n', m_p, n_p );
  end
%
%  C: Make simple checks.
%
%  Problem has NO solution if any of:
%  * maximum dimension of p is greater than maximum dimension of R;
%  * minimum dimension of p is greater than minimum dimension of R;
%  * area of R is zero;
%  * area of P is zero;
%  * area of R is not a multiple of area of P;
%
  max_r = max ( m_r, n_r );
  min_r = min ( m_r, n_r );
  max_p = max ( m_p, n_p );
  min_p = min ( m_p, n_p );
  area_r = polyomino_area ( r );
  area_p = polyomino_area ( p );

  if ( max_r < max_p )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Warning!\n' );
    fprintf ( 1, '  The maximum dimension of R is less than that of P.\n' );
    fprintf ( 1, '  No solution is possible.\n' );
    return
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  MAX_P = %d <= MAX_R = %d.\n', max_p, max_r );
  end

  if ( min_r < min_p )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Warning!\n' );
    fprintf ( 1, '  The minimum dimension of R is less than that of P.\n' );
    fprintf ( 1, '  No solution is possible.\n' );
    return
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  MIN_P = %d <= MIN_R = %d.\n', min_p, min_r );
  end

  if ( area_r == 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Warning!\n' );
    fprintf ( 1, '  The area of R is zero.\n' );
    fprintf ( 1, '  No solution is possible.\n' );
    return
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  AREA_R = %d ~= 0.\n', area_r );
  end

  if ( area_p == 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Warning!\n' );
    fprintf ( 1, '  The area of P is zero.\n' );
    fprintf ( 1, '  No solution is possible.\n' );
    return
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  AREA_P = %d ~= 0.\n', area_p );
  end

  if ( mod ( area_r, area_p ) ~= 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral - Warning!\n' );
    fprintf ( 1, '  The area of R is not a multiple of that of P.\n' );
    fprintf ( 1, '  No solution is possible.\n' );
    return
  end

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  AREA_R = %d is an exact multiple of AREA_P = %d\n', ...
      area_r, area_p );
  end
%
%  D: Construct the (usually underdetermined) linear system A*x=b.
%
  [ a, b ] = polyomino_monohedral_matrix ( r, p );
  [ m, n ] = size ( a );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  %dx%d system matrix A and right hand side B:\n', m, n );
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
%  E: Write the linear system out as LP file.
%
  comment = [ '\ ', comment ];
  polyomino_lp_write ( filename, comment, m, n, a, b );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Linear system saved in LP file "%s"\n', filename );
%
%  F: Solve linear system
%
  ab = [ a, b ];
  [ ab_rref, det ] = r8mat_rref ( m, n + 1, ab );
  a_rref = round ( ab_rref(1:m,1:n) );
  b_rref = round ( ab_rref(1:m,n+1) );

  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  RREF has determinant = %g\n', det );
    fprintf ( 1, '\n' );
    fprintf ( 1, '  %dx%d Row-Reduced Echelon Form system matrix A and right hand side B:\n', m + 1, n );
    fprintf ( 1, '\n' );
    for i = 1 : m
      fprintf ( 1, '  ' );
      for j = 1 : n
        fprintf ( 1, '%2d', a_rref(i,j) );
      end
      fprintf ( 1, '  %2d\n', b_rref(i) );
    end
  end
%
%  Augment the RREF system, and look for binary solutions.
%
  nz = area_r / area_p;
  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'VERBOSE:\n' );
    fprintf ( 1, '  Seek binary solutions with exactly %d nonzeros\n', nz );
  end

  [ k, x ] = r8mat_rref_solve_binary_nz ( m, n, nz, a_rref, b_rref );
%
%  G: Print solution vectors.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d binary solutions were found.\n', k );

  if ( k == 0 )
    return
  end

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Binary solution vectors x:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : n
    fprintf ( 1, '  ' );
    for j = 1 : k
      fprintf ( 1, '%2d', x(i,j) );
    end
    fprintf ( 1, '\n' );
  end
%
%  H: Verify that solutions are correct.
%
  check = zeros ( k, 1 );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Check residuals ||Ax-b||:\n' );
  fprintf ( 1, '\n' );
  ax = a * x;
  resid_max = 0.0;
  for j = 1 : k
    resid = max ( abs ( ax(:,j) - b(:) ) );
    check(j) = ( resid == 0 );
    resid_max = max ( resid_max, resid );
    if ( ~ check(j) )
      fprintf ( 1, '  Solution vector %d has a nonzero residual of %g\n', j, resid );
    end
  end

  if ( resid_max == 0.0 )
    fprintf ( 1, '  All solutions had zero residual.\n' );
  end

  if ( sum ( check ) == 0 )
    return
  end
%
%  I: Print solutions as patterns.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Translate each correct solution into a tiling:\n' );
  for j = 1 : k
    if ( check(j) )
      label = sprintf ( '  Tiling based on solution %d', j );
      polyomino_monohedral_tiling_print ( r, p, x(:,j), label );
    end
  end
%
%  Terminate.
%
  if ( verbose )
    fprintf ( 1, '\n' );
    fprintf ( 1, 'polyomino_monohedral:\n' );
    fprintf ( 1, '  Normal end of execution.\n' );
  end

  return;
end
