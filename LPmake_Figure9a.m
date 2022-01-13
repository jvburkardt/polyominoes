function [ p_shapes, r_shape ] = LPmake_Figure9a ( )

%*****************************************************************************80
%
%% lpmake_figure9a() sets up the tiling problem associated with Figure 9a.
%
%  Discussion:
%
%    30 copies of the L-triomino are used to tile the 18x5 rectangle.
%
%    This problem is depicted in figure 9a in the reference.
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
%    integer P_SHAPES(2,2): a binary matrix that describes the polyomino.
%
%    integer R_SHAPE(18,5): a binary matrix that describes the region.
%

%
%  Create the binary matrix defining the triomino:
%    1 0
%    1 1
%
  p_shapes = ones ( 2, 2 );
  p_shapes(1,2) = 0;
%
%  Create the binary matrix defining the region.
%
  r_shape = ones ( 18, 5 );
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b ] = polyomino_monohedral_matrix ( r_shape, p_shapes );
  [ m, n ] = size ( a );
%
%  Create the LP file for submission to an optimizer.
%
  filename = 'Figure9a.lp';
  polyomino_lp_write ( filename, '\ Figure9a', m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_Figure9a created the LP file "%s"\n', filename );

  return
end

