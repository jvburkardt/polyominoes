function [p_shapes, r_shape, p_num, d, m, n, f] = LPmake_polyominoes_Figure11 ()

%*****************************************************************************80
%
%% LPmake_polyominoes_Figure11 () creates the LP file for Figure 11 in the reference below.
%
%  Discussion:
%
%    Copies (see below) of 10 different octominoes are used to tile an 8x16
%    rectangle. 
%
%    This problem is depicted in figure 11 in the reference given below.
%    Note that this problem does not use colouring techniques, i.e., we
%    tile with polyominoes (not pariominoes). The actual figure 11 in the
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
%    integer P_SHAPES(8,16,10): a binary matrix that describes each polyomino.
%
%    integer R_SHAPE(8,16): a binary matrix that describes the region.
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
  r_shape = ones(8,16);
%
%  How many free polyominoes are there?
%
  p_num = 10;  
%
%  Create binary matrices for the polyominoes and pack them into p_shapes
%
   for page = 1:p_num
      p_shapes(:,:,page) = zeros(8,16);
  end
  
  p_shapes(1:3,1:4,1) = [1 1 1 1; 1 0 0 1; 1 0 0 1]; 
  p_shapes(1:5,1:2,2) = [1 0;1 1;1 1;1 1;0 1]; 
  p_shapes(1:5,1:2,3) = [1 1; 1 0; 1 1; 0 1; 1 1]; 
  p_shapes(1:2,1:4,4) = [1 1 1 1; 1 1 1 1]; 
  p_shapes(1,1:8,5) = [1 1 1 1 1 1 1 1]; 
  p_shapes(1:4,1:3,6) = [1 1 0; 0 1 1; 0 1 1; 1 1 0]; 
  p_shapes(1:3,1:4,7) = [1 1 1 1; 0 1 1 0; 0 1 1 0]; 
  p_shapes(1:4,1:3,8) = [0 1 1; 0 0 1; 1 1 1; 1 0 1]; 
  p_shapes(1:4,1:4,9) = [1 1 1 1; 1 0 0 0; 1 1 0 0; 1 0 0 0]; 
  p_shapes(1:4,1:3,10) = [1 1 1; 0 1 0; 1 1 1; 0 1 0]; 
%
%  How many copies of each pariomino do we use?
%
  d = [1 2 1 2 2 1 2 2 2 1]; 
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b, ~ ]  = polyomino_multihedral_matrix ( r_shape, p_num, p_shapes, d );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure11_polyominoes.lp';
  label = '\ LP file for Figure11 in the pariomino paper (no colouring techniques).';
  polyomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_polyominoes_Figure11 created the LP file "%s"\n', filename );

  return 

end