function [ p_shapes, d, r_shape, p_num ] = LPmake_Figure9b ( )

%*****************************************************************************80
%
%% lpmake_figure9b() sets up the tiling problem associated with Figure 9b.
%
%  Discussion:
%
%    1 copy of each of the 12 pentominoes is to be used to tile a region
%    which is a 6x10 rectangle.
%
%    This problem is depicted in figure 9b in the reference.
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
%    integer P_SHAPES(6,10,12): a binary matrix that describes each polyomino.
%
%    integer D(1,12): how many times each polyomino is to be used.
%
%    integer R_SHAPE(6,10): a binary matrix that describes the region.
%
%    integer P_NUM: the number of polyominoes.
%

%
%  Create the binary matrix that defines the polyomino shapes.
%  Here, we call a function which sets up all 12 pentominoes.
%
  p_shapes = pentomino_pack ( 6, 10 );
%
%  Create the binary matrix defining the region.
%
  r_shape = ones ( 6, 10 );
%
%  P_NUM counts the polyominoes to be used.
%  D defines how often each polyomino may be used.
%
  p_num = 12;
  d = ones ( 1, p_num );
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b, var_p ] = polyomino_multihedral_matrix ( r_shape, p_num, ...
    p_shapes, d );
  [ m, n ] = size ( a );
%
%  Create the LP file for submission to an optimizer.
%
  filename = 'Figure9b.lp';
  polyomino_lp_write ( filename, '\ Figure9b', m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_Figure9b created the LP file "%s"\n', filename );

  return
end
