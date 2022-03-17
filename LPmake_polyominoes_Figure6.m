function [p_shapes, r_shape, m, n, f] = LPmake_polyominoes_Figure6 ()

%*****************************************************************************80
%
%% LPmake_polyominoes_Figure6 () creates the LP file for Figure 6 in the reference below.
%
%  Discussion:
%
%    28 copies of an L-shaped trimino are used to tile a triangular shaped 
%    region with a single ‘hole’ in the middle.
%
%    This problem is depicted in figure 6 in the reference given below.
%    Note that this problem does not use colouring techniques, i.e., we
%    tile with polyominoes (not pariominoes). The actual figure 6 in the
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
%    integer P_SHAPES(2,2): a binary matrix that describes the polyomino.
%
%    integer R_SHAPE(13,13): a binary matrix that describes the region.
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
  r_shape = diamondshapes(6);
  r_shape(7,7) = 0;
%
%  Create binary matrix for the polyomino
%
  p_shapes = [1 0; 1 1]; 
%
%  Create the linear system A*x=b for the tiling problem and output some data.
%
  [ a, b ] = polyomino_monohedral_matrix ( r_shape, p_shapes );
  [m,n] = size(a); 
  f = n - rank([a,b]);
%
%  Write the linear system to an LP file.
%
  filename ='Figure6_polyominoes.lp';
  label = '\ LP file for Figure6 in the pariomino paper (no colouring techniques).';
  polyomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_polyominoes_Figure6 created the LP file "%s"\n', filename );

  return 

end