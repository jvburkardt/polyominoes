function [p_shapes, r_shape, m, n, f] = LPmake_polyominoes_Figure5 ()

%*****************************************************************************80
%
%% LPmake_polyominoes_Figure5 () creates the LP file for Figure 5 in the reference below.
%
%  Discussion:
%
%    56 copies of an L-shaped trimino are used to tile a triangular shaped region with ‘holes’.
%
%    This problem is depicted in figure 5 in the reference given below.
%    Note that this problem does not use colouring techniques, i.e., we
%    tile with polyominoes (not pariominoes). The actual figure 5 in the
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
%    integer R_SHAPE(21,21): a binary matrix that describes the region.
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
    r = diamondshapes(10);
    cross = zeros(3);
    cross(1,1) = 1;
    cross(1,3) = 1;
    cross(3,1) = 1;
    cross(3,3) = 1;
    r(4:6,10:12) = cross;
    r(7:9,7:9) = cross;
    r(7:9,13:15) = cross;
    r(10:12,4:6) = cross;
    r(10:12,10:12) = cross;
    r(10:12,16:18) = cross;
    r(13:15,7:9) = cross;
    r(13:15,13:15) = cross;
    r(16:18,10:12) = cross;
    r(7,10) = 0;
    r(7,12) = 0;
    r(10,7) = 0;
    r(10,15) = 0;
    r(12,7) = 0;
    r(12,15) = 0;
    r(15,10) = 0;
    r(15,12) = 0;
    r_shape = r;
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
  filename ='Figure5_polyominoes.lp';
  label = '\ LP file for Figure5 in the pariomino paper (no colouring techniques).';
  polyomino_lp_write ( filename, label, m, n, a, b );
  
  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_polyominoes_Figure5 created the LP file "%s"\n', filename );

  return 

end