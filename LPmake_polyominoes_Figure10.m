function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_polyominoes_Figure10 ()

%*****************************************************************************80
%
%% LPmake_polyominoes_Figure10 () creates the LP file for Figure 10 in the reference below.
%
%  Discussion:
%
%    26 copies of the domino, 3 copies of the P-shaped pentomino, 1 copy of the 
%    cross-shaped pentomino, and 1 copy of the octomino are used to tile 
%    an irregular shaped region with holes.
%
%    This problem is depicted in figure 10 in the reference given below.
%    Note that this problem does not use colouring techniques, i.e., we
%    tile with polyominoes (not pariominoes). The actual figure 10 in the
%    cited paper uses checkerboard colouring techniques.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    15 March 2022
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
%    integer P_SHAPES(13,13,4): a binary matrix that describes each polyomino.
%
%    integer R_SHAPE(13,13): a binary matrix that describes the region.
%
%    integer P_NUM, how many free polyominoes are used.
%
%    integer D(P_NUM), tells us how many copies of each polyomino
%    we must use in the tiling.
%
%    integer M: the number of constraints of the LP problem.
%
%    integer N: the number of variables in the LP problem.
%
%    integer F: the number of free variables associated with the linear
%    system Ax = b of the LP problem
%
%   Note: the LP file is saved to file.

%
%  Define the target region R
%
  r_shape = zeros(13,13);
  r_shape(1:2,6:8) = 1;
  r_shape(3:4,5:9) = 1;
  r_shape(4,4) = 1;
  r_shape(4,10) = 1;
  r_shape(5,3:6) = 1;
  r_shape(5,8:11) = 1;
  r_shape(6,1:5) = 1;
  r_shape(6,9:13) = 1;
  r_shape(7,1:4) = 1;
  r_shape(7,10:13) = 1;
  r_shape(8,1:5) = 1;
  r_shape(8,9:13) = 1;
  r_shape(9,3:6) = 1;
  r_shape(9,8:11) = 1;
  r_shape(10,4:10) = 1;
  r_shape(11,5:9) = 1;
  r_shape(12:13,6:8) = 1;
  r_shape(4,7) = 0;
  r_shape(10,7) = 0;
  r_shape(7,5) = 1;
  r_shape(7,9) = 1;  
%
%  How many free polyominoes are there?
%
  p_num = 4;  
%
%  Create binary matrices for the polyominoes and pack them into p_shapes
%
  for page = 1:p_num
      p_shapes(:,:,page) = zeros(13,13);
  end
  
  p_shapes(1:2,1,1) = [1;1];
  p_shapes(1:3,1:2,2) = [1 1; 1 1; 1 0];
  p_shapes(1:3,1:3,3) = [0 1 0; 1 1 1; 0 1 0];
  p_shapes(1:3,1:4,4) = [0 1 0 1; 1 1 1 1; 0 1 0 1];
%
%  How many copies of each pariomino do we use?
%
  d = [26 3 1 1];
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ]  = polyomino_multihedral_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure10_polyominoes.lp';
  label = '\ LP file for Figure10 in the pariomino paper (no colouring techniques).';
  polyomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_polyominoes_Figure10 created the LP file "%s"\n', filename );

  return 

end