function [p_shapes, r_shape, m, n, f] = LPmake_polyominoes_Figure4 ()

%*****************************************************************************80
%
%% LPmake_polyominoes_Figure4 () creates the LP file for Figure 4 in the reference below.
%
%  Discussion:
%
%    144 copies of an L-shaped tetromino are used to tile an irregularly shaped region.
%
%    This problem is depicted in figure 4 in the reference given below.
%    Note that this problem does not use colouring techniques, i.e., we
%    tile with polyominoes (not pariominoes). The actual figure 4 in the
%    cited paper uses checkerboard colouring techniques.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    14 March 2022
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Reference:
%
%    Marcus Garvie, John Burkardt,
%    A `divide-and-conquer' approach for tiling finite regions of the plane with polyominoes. 
%    Part II: Numerical solution.
%    Algorithms,
%    Submitted, 2022.
%
%  Output:
%
%    integer P_SHAPES(3,2): a binary matrix that describes the polyomino.
%
%    integer R_SHAPE(38,29): a binary matrix that describes the region.
%
%    integer m: the number of constraints of the LP problem.
%
%    integer n: the number of variables in the LP problem.
%
%    integer f: the number of free variables associated with the linear
%    system Ax = b of the LP problem
%
%   Note: the LP file is saved to file.

%
%  Define the target region R
%
  R = ones(19,14);
  R(1,1:8) = 0;
  R(1,10:14) = 0;
  R(2,1:7) = 0;
  R(2,10:14) = 0;
  R(3,1:6) = 0;
  R(3,11:14) = 0;
  R(4,1:5) = 0;
  R(4,12:14) = 0;
  R(5,1:4) = 0;
  R(5,12:14) = 0;
  R(6,1:3) = 0;
  R(6,13:14) = 0;
  R(7,1:2) = 0;
  R(7,13:14) = 0;
  R(8,1) = 0;
  R(8,14) = 0;
  R(12,1) = 0;
  R(12,14) = 0;
  R(13,1:2) = 0;
  R(13,13:14) = 0;
  R(14,1:2) = 0;
  R(14,12:14) = 0;
  R(15,1:3) = 0;
  R(15,11:14) = 0;
  R(16,1:3) = 0;
  R(16,10:14) = 0;
  R(17,1:4) = 0;
  R(17,9:14) = 0;
  R(18,1:5) = 0;
  R(18,8:14) = 0;
  R(19,1:5) = 0;
  R(19,7:14) = 0;
  % Double region
  R1 = zeros(28,23);
  R2 = zeros(28,23);
  R1(10:28,1:14) = R;
  R2(1:19,10:23) = R;
  RR = R1+R2;
  % Double region again
  R3 = zeros(38,29);
  R4 = zeros(38,29);
  R3(1:28,1:23) = RR;
  R4(11:38,7:29) = RR;
  RRR = R3+R4;
  r_shape = RRR;
%
%  Create binary matrix for the polyomino
%
  p_shapes = [1 0; 1 0; 1 1]; 
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b ] = polyomino_monohedral_matrix ( r_shape, p_shapes );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure4_polyominoes.lp';
  label = '\ LP file for Figure4 in the pariomino paper (no colouring techniques).';
  polyomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_polyominoes_Figure4 created the LP file "%s"\n', filename );

  return 

end