function [ p_shapes, r_shape ] = LPmake_Figure11 ( )

%*****************************************************************************80
%
%% lpmake_figure11() sets up the tiling problem associated with Figure 11.
%
%  Discussion:
%
%    600 copies of a single hexomino are used to tile the 60x60 square.
%
%    This problem is depicted in figure 11 in the reference.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    23 July 2020
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Reference:
%
%    Marcus Garvie, John Burkardt,
%    A new mathematical model for tiling finite regions of the plane
%    with polyominoes,
%    Contributions to Discrete Mathematics,
%    Accepted, June 2020.
%
%  Output:
%
%    integer P_SHAPES(3,3): a binary matrix that describes the polyomino.
%
%    integer R_SHAPE(60,60): a binary matrix that describes the region.
%

%
%  Create the binary matrix for the hexomino:
%    0 1 0
%    1 1 0
%    1 1 1
%
  p_shapes = zeros ( 3, 3 );
  p_shapes(1,2)   = 1;
  p_shapes(2,1:2) = 1;
  p_shapes(3,1:3) = 1;
%
%  Create the binary matrix for the region
%
  r_shape = ones ( 60, 60 );
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b ] = polyomino_monohedral_matrix ( r_shape, p_shapes );
  [ m, n ] = size ( a );
%
%  Create the LP file for submission to an optimizer.
%
  filename = 'Figure11.lp';
  polyomino_lp_write ( filename, '\ Figure11', m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_Figure11 created the LP file "%s"\n', filename );

  return
end
