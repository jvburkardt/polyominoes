function polyomino_monohedral_example_reid ( )

%*****************************************************************************80
%
%% polyomino_monohedral_example_reid() solves the Reid polyomino example.
%
%  Discussion:
%
%    A region R consists of the following arrangement of square cells,
%    (numbered row first):
%
%      1 2
%      3 4 5
%      6 7 8
%
%    We are given a polyomino P, also composed of square cells, and also
%    numbered row first (although in this case it doesn't matter):
%
%      1 2
%
%    It is desired to use a set of 4 copies of P to cover the region R, so that 
%    each cell is covered exactly once by a tile cell, and every tile cell 
%    covers some cell of R.
%
%    There are two versions of the polyomino:
%
%      P1: no reflection, no rotation:
%
%        1 2
%
%      P2: no reflection, rotation of 90 degrees:
%
%        1
%        2
%
%    There are 5 distinct ways to place a single copy of P1 onto R, and
%    5 ways to use P2 in this way.  We will index each way as a separate
%    "variable" called X, and we can describe each X by the squares of R
%    that it covers.  Again, we traverse R rowwise as we search:
%
%      x1: P1 on 1 3
%      x2: P1 on 3 6
%      x3: P1 on 2 4
%      x4: P1 on 4 7
%      x5: P1 on 5 8
%      x6: P2 on 1 2
%      x7: P2 on 3 4
%      x8: P2 on 4 5
%      x9: P2 on 6 7
%     x10: P2 on 7 8
%
%    The requirement that each of the cells of R be covered exactly once
%    results in a linear system:
%
%         <--------- P1 -------->   <-------- P2 --------->
%          x1   x2   x3   x4   x5   x6   x7   x8   x9   x10   b
%        +-----------------------------------------------------
%      R1: x1                     + x6                      = 1
%      R2:           x3           + x6                      = 1
%      R3: x1 + x2                     + x7                 = 1
%      R4:           x3 + x4           + x7 + x8            = 1
%      R5:                     x5           + x8            = 1
%      R6:      x2                               + x9       = 1
%      R7:                x4                     + x9 + x10 = 1
%      R8:                     x5                     + x10 = 1
%
%    The system A*x=b is underdetermined, and hence
%    infinite families of solutions may exist.  However, we are only
%    interested in solutions in which every entry of x is an integer
%    and in fact, every entry of x is 0 or 1.  Given, in this case,
%    10 variables, there can be of course no more than 2^10 possible
%    such vectors x, and we could simply try them all by brute force.
%
%    We can significantly reduce the work involved by computing the
%    reduced row echelon form of the system.  This allows us to determine
%    the number of degrees of freedom in the solution.  Our search for
%    acceptable binary solutions can then be carried out by considering
%    every possible binary assignment of the degrees of freedom in which 
%    no more than 4 degrees of freedom are set to 1.
%
%    Note that the formation of the RREF matrix is highly subject to roundoff
%    error.  In particular, if an entry which should mathematically be zero
%    is instead nonzero, it may be taken for a pivot, and renormalized to 1,
%    completely changing the structure of the solution.  For this reason,
%    the RREF should be computed cautiously, and with a tolerance.
%
%     For this example, there are only 3 degrees of freedom.  So the cases
%     we need to check are can be counted by the number of nonzero variables
%     that are free or constrained:
%       C(3,0) = 1, choose 0 free out of 3, solve for 4 constrained out of 7;
%       C(3,1) = 3, choose 1 free out of 3, solve for 3 constrained out of 7;
%       C(3,2) = 3, choose 2 free out of 3, solve for 2 constrained out of 7;
%       C(3,3) = 1, choose 3 free out of 3, solve for 1 constrained out of 7;
%     for a total of 8 cases to check, rather than 2^10=1024.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_monohedral_example_reid():\n' );
  fprintf ( 1, '  MATLAB/Octave version %s\n', version ( ) );
  fprintf ( 1, '  Set up and solve the Reid polyomino tiling example.\n' );
%
%  Define R.
%
  shape_r = [ ...
    1, 1, 0;
    1, 1, 1;
    1, 1, 1 ];

  [ m_r, n_r ] = size ( shape_r );
  polyomino_print ( shape_r, '  Region R:' );
%
%  Define P.
%
  shape_p = [ ...
    1, 1 ];

  [ m_p, n_p ] = size ( shape_p );
  polyomino_print ( shape_p, '  Polyomino P:' );
%
%  Get the system matrix and right hand side.
%
%  Because this is a simple example, we supply the linear system directly.
%  The general code constructs the linear system implicitly, from R and P.
%
  [ a, b ] = polyomino_monohedral_example_reid_system ( );
  [ m, n ] = size ( a );
%
%  Print the linear system.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  System matrix A and right hand side B:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, '  ' );
    for j = 1 : n
      fprintf ( 1, '%2d', a(i,j) );
    end
    fprintf ( 1, '  %2d\n', b(i) );
  end
%
%  Write the linear system to an LP file.
%
  filename = 'reid.lp';
  label = '\ LP file for the Reid example, created by POLYOMINO_LP_WRITE.';

  polyomino_lp_write ( filename, label, m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Wrote the LP file "%s"\n', filename );
%
%  Compute the RREF form of the system.
%
  ab = [ a, b ];
  [ ab_rref, det ] = r8mat_rref ( m, n + 1, ab );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  RREF has determinant %g\n', det );

  a_rref = round ( ab_rref(1:m,1:n) );
  b_rref = round ( ab_rref(1:m,n+1) );
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Reduced Row Echelon Form system matrix A and right hand side B:\n' );
  fprintf ( 1, '\n' );
  for i = 1 : m
    fprintf ( 1, '  ' );
    for j = 1 : n
      fprintf ( 1, '%2d', a_rref(i,j) );
    end
    fprintf ( 1, '  %2d\n', b_rref(i) );
  end
%
%  Augment the RREF system, and look for binary solutions.
%
%  The function R8MAT_RREF_SOLVE_BINARY considers ALL binary assignments to
%  the free variables.  This turns out to be a bad, and unnecessary, idea when 
%  there are many free variables, and so in the general code, a more 
%  efficient method is used to select the binary assignments.
%
  [ x_num, x ] = r8mat_rref_solve_binary ( m, n, a_rref, b_rref );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  Found %d binary solution vectors x:\n', x_num );
  fprintf ( 1, '\n' );
  for i = 1 : n
    fprintf ( 1, '  ' );
    for j = 1 : x_num
      fprintf ( 1, '%2d', x(i,j) );
    end
    fprintf ( 1, '\n' );
  end
%
%  Print solutions as patterns.
%
%  Because this is a simple problem, it is possible to use a simple
%  approach to get a printout of the tiling.  The general code can also
%  produce such printouts, but it takes more work.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, '  Translate each correct solution into a tiling:\n' );
  for j = 1 : x_num
    xv = (1:10)' .* x(:,j);
    axv = a * xv;
    fprintf ( 1, '\n' );
    fprintf ( 1, '  Tiling based on solution %d\n', j );
    fprintf ( 1, '\n' );
    fprintf ( 1, '  %2d  %2d\n',      axv(1:2));
    fprintf ( 1, '  %2d  %2d  %2d\n', axv(3:5) );
    fprintf ( 1, '  %2d  %2d  %2d\n', axv(6:8) );
  end
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_monohedral_example_reid():\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end

