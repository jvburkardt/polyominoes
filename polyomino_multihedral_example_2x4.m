function polyomino_multihedral_example_2x4 ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_2x4() solves 2x4 multihedral polyomino example.
%
%  Discussion:
%
%    A region R consists of the following arrangement of square cells:
%
%      1 1 1 1
%      1 1 1 1
%
%    We can assign an index to each cell, as follows:
%
%      1 2 3 4
%      5 6 7 8
%
%    We are given a set of 3 polyomino tiles, N, O, and P, and it is desired
%    to arrange these tiles in such a way that they exactly cover R, that is,
%    each cell of R is covered exactly once by a tile cell, and every tile 
%    cell is covering a cell of R.
%
%    The shapes of the 3 tiles are
%
%      N = 1 
% 
%      O = 1 1 1
%
%      P = 0 0 1
%          1 1 1
%
%    Allowing reflections and rotations, there are:
%
%      1 variant of N:
%
%        N1 = 1
%
%      2 variants of O:
%
%        O1 = 1 1 1
%
%        O2 = 1
%             1
%             1
%
%      8 variants of P:
%
%        P1 = 0 0 1
%             1 1 1
%
%        P2 = 1 1
%             0 1
%             0 1
%
%        P3 = 1 1 1
%             1 0 0
%
%        P4 = 1 0
%             1 0
%             1 1
%
%        P5 = 1 0 0
%             1 1 1
%
%        P6 = 0 1
%             0 1
%             1 1
%
%        P7 = 1 1 1
%             0 0 1
%
%        P8 = 1 1
%             1 0
%             1 0
%
%    There are 8 ways to place N1 on R:
%
%      n11: 1
%      n12: 2
%      n13: 3
%      n14: 4
%      n15: 5
%      n16: 6
%      n17: 7
%      n18: 8
%
%    There are 4 ways to place O1 and no ways to place O2 on R:
%
%      o11: 1 2 3
%      o12: 2 3 4
%      o13: 5 6 7
%      o14: 6 7 8
%
%    There are 2 ways to place each of P1, P3, P5, or P7 on R, and no ways
%    to place P2, P4, P6, or P8:.
%
%      p11: 3 5 6 7
%      p12: 4 6 7 8
%      p31: 1 2 3 5
%      p32: 2 3 4 6
%      p51: 1 5 6 7
%      p52: 2 6 7 8
%      p71: 1 2 3 7
%      p72: 2 3 4 8
%
%    We can only use N once:
%
%      n11 + n12 + n13 + n14 + n15 + n16 + n17 + n18 = 1
%
%    We can only use O once:
%
%      o11 + o12 + o13 + o14 = 1
%
%    We can only use P once:
%
%      p11 + p12 + p31 + p32 + p51 + p52 + p71 + p72 = 1
%
%    The requirement that each of the 8 cells of R be covered exactly once
%    using some choice of placement for P1, P2 and P3 can be expressed as the 
%    linear system for which only binary solutions (0 or 1 valued) are sought:
%
%    The linear system is a bit large to print out.   We present it in
%    three strips of columns: A = [ N | O | P ]:
%
%          <---------- N ---------------------->
%          x1   x2   x3   x4   x5   x6   x7   x8 
%        +--------------------------------------
%      R1: n11                            
%      R2:      n12                        
%      R3:           n13                    
%      R4:                n14                
%      R5:                     n15            
%      R6:                          n16        
%      R7:                               n17    
%      R8:                                    n18
%
%      N:  n11  n12  n13  n14  n15  n16  n17  n18
%      O:                                 
%      P:                                 
%
%          <------ O -------> 
%          x9   x10  x11  x12 
%        +-------------------
%      R1: o11            
%      R2: o11  o12        
%      R3: o11  o12        
%      R4:      o12        
%      R5:           o13    
%      R6:           o13  o14
%      R7:           o13  o14
%      R8:                o14
%
%      N:
%      O:  o11  o12  o13  o14
%      P:                  
%
%          <----------- P ----------------------> <-B-> 
%          x13  x14  x15  x16  x17  x18  x19  x20   b
%        +-------------------------------------------
%      R1:           p31       p51       p71      = 1
%      R2:           p31  p32       p52  p71  p72 = 1
%      R3: p11       p31  p32            p71  p72 = 1
%      R4:      p12       p32                 p72 = 1
%      R5: p11       p31       p51                = 1
%      R6: p11  p12       p32  p51  p52           = 1
%      R7: p11  p12            p51  p52  p71      = 1
%      R8:      p12                 p52       p72 = 1
%
%      N:                                         = 1
%      O:                                         = 1
%      P:  p11  p12  p31  p32  p51  p52  p71  p72 = 1
%
%
%    We regard this as a linear system of equations A*x=b, where
%      x = [ n11 n12 n13 n14 n15 n16 n17 n18 
%            o11 o12 o13 o14 
%            p11 p12 p31 p32 p51 p52 p71 p72 ].
%
%    In general, the system A*x=b will be underdetermined, and hence
%    infinite families of solutions may exist.  However, we are only
%    interested in solutions x in which every entry is 0 or 1.  Given, in 
%    this case, 20 variables, there can be of course no more than 2^20 possible
%    such vectors x, and we could simply try them all by brute force.
%
%    Instead, we consider the reduced row echelon form of the system,
%    identify the degrees of freedom, and consider just the solution
%    vectors x corresponding to setting those degrees of freedom to 0 or 1.
%
%    (At this point, we do not take one further efficiency step, and only
%    consider binary solutions x with exactly 3 nonzero entries.)
%
%    Note that the formation of the RREF matrix is highly subject to roundoff
%    error.  In particular, if an entry which should mathematically be zero
%    is instead nonzero, it may be taken for a pivot, and renormalized to 1,
%    completely changing the structure of the solution.  For this reason,
%    the RREF should be computed cautiously, and with a tolerance.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 November 2020
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_2x4:\n' );
  fprintf ( 1, '  Set up and solve the 2x4 rectangle polyomino tiling example.\n' );
%
%  Define R.
%
  shape_r = [ ...
    1, 1, 1, 1; ...
    1, 1, 1, 1 ];

  [ m_r, n_r ] = size ( shape_r );
  polyomino_print ( shape_r, '  Region R:' );
%
%  Define N, O, P
%
  shape_n = [ ...
    1 ];
  [ m_n, n_n ] = size ( shape_n );
  polyomino_print ( shape_n, '  Polyomino N:' );

  shape_o = [ ...
    1, 1, 1 ];
  [ m_o, n_o ] = size ( shape_o );
  polyomino_print ( shape_o, '  Polyomino O:' );

  shape_p = [ ...
    0, 0, 1;
    1, 1, 1 ];
  [ m_p, n_p ] = size ( shape_p );
  polyomino_print ( shape_p, '  Polyomino P:' );
%
%  Get the system matrix and right hand side.
%
  [ a, b ] = polyomino_multihedral_example_2x4_system ( );
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
  filename = '2x4.lp';
  label = '\ LP file for the 2x4 example, created by POLYOMINO_LP_WRITE.';

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
  [ x_num, x ] = r8mat_rref_solve_binary ( m, n, a_rref, b_rref );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  %d binary solution vectors x:\n', x_num );
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
    xv = (1:20)' .* x(:,j);
    axv = a * xv;
    fprintf ( 1, '\n' );
    fprintf ( 1, '  Tiling based on solution %d\n', j );
    fprintf ( 1, '\n' );
    fprintf ( 1, '  %2d  %2d  %2d  %2d\n', axv(1:4));
    fprintf ( 1, '  %2d  %2d  %2d  %2d\n', axv(5:8) );
  end
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_2x4:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end

