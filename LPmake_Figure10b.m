function [ p_shapes, d, r_shape, p_num ] = LPmake_Figure10b ( )

%*****************************************************************************80
%
%% lpmake_figure10b() sets up the tiling problem associated with Figure 10b.
%
%  Discussion:
%
%    1 or 2 copies of each of the 12 pentominoes is to be used to tile a region
%    which is an 11x11 square with 4 2x2 holes.
%
%    This problem is depicted in figure 10b in the reference.
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
%    integer P_SHAPES(11,11,12): a binary matrix that describes each polyomino.
%
%    integer D(1,12): how many times each polyomino is to be used.
%
%    integer R_SHAPE(11,11): a binary matrix that describes the region.
%
%    integer P_NUM: the number of polyominoes.
%

%
%  Create binary matrices for the pentominoes.
%  Here, we call a function which sets up all 12 pentominoes.
%
  p_shapes = pentomino_pack ( 11, 11 );
%
%  Create the binary matrix for the region with the four 2 x 2 holes
%
  r_shape = ones ( 11, 11 );
  r_shape(4:5,4:5) = 0;
  r_shape(4:5,7:8) = 0;
  r_shape(7:8,4:5) = 0;
  r_shape(7:8,7:8) = 0;
%
%  P_NUM counts the polyominoes to be used.
%  D defines how often each polyomino may be used.
%
  p_num = 12;
  d = [2 2 2 2 2 2 2 1 1 1 2 2];
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b, var_p ]  = polyomino_multihedral_matrix ( r_shape, p_num, ...
    p_shapes, d );
  [ m, n ] = size ( a );
%
%  Create and save the LP file
%
  filename = 'Figure10b.lp';
  polyomino_lp_write ( filename, '\ Figure10b', m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_Figure10b created the LP file "%s"\n', filename );

  return
end
