function [ p_shapes, d, r_shape, p_num ] = LPmake_Figure10a ( )

%*****************************************************************************80
%
%% lpmake_figure10a() sets up the tiling problem associated with Figure 10a.
%
%  Discussion:
%
%    4 copies each of 8 octominoes are to be used to tile an L-shaped region
%    which is a 16x24 rectangle with an 8x16 notch removed.
%
%    This problem is depicted in figure 10a in the reference.
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
%    integer P_SHAPES(16,24,8): a binary matrix that describes each polyomino.
%
%    integer D(1,8): how many times each polyomino is to be used.
%
%    integer R_SHAPE(16,24): a binary matrix that describes the region.
%
%    integer P_NUM: the number of polyominoes.
%

%
%  P_NUM counts the polyomino shapes.
%
  p_num = 8;
%
%  Create the 3D binary matrix for the octominoes.
%
  for page = 1 : p_num
    p_shapes(:,:,page) = zeros(16,24);
  end

  p_shapes(1:4,1:4,1) = [ 1 1 1 0; ...
                          1 1 1 0; ...
                          1 0 0 0; ... 
                          1 0 0 0];

  p_shapes(1:2,1:5,2) = [1 1 1 1 0; ... 
                         1 1 0 1 1];

  p_shapes(1:4,1:4,3) = [1 0 0 0; ...
                         1 0 0 0; ... 
                         1 0 1 0; ... 
                         1 1 1 1];

  p_shapes(1:3,1:4,4) = [1 1 1 1; ...
                         1 0 1 1; ...
                         0 0 0 1];

  p_shapes(1:4,1:5,5) = [1 0 0 0 0; ...
                         1 0 0 0 0; ...
                         1 0 0 0 0; ...
                         1 1 1 1 1];

  p_shapes(1:4,1:3,6) = [1 0 0; ...
                         1 1 0; ...
                         1 1 0; ...
                         1 1 1];

  p_shapes(1:3,1:5,7) = [1 1 1 1 1; ...
                         0 1 0 0 0; ...
                         0 1 1 0 0];

  p_shapes(1:4,1:3,8) = [1 0 1; ...
                         1 1 1; ...
                         1 0 0; ...
                         1 1 0];
%
%  D specifies how often each polyomino is to be used.
%
  d = 4 * ones ( 1, p_num );
%
%  Create the binary matrix for the region.
%
  r_shape = ones ( 16, 24 );
  r_shape(9:16,1:16) = 0;
%
%  Set up the linear system A*x=b for the tiling problem.
%
  [ a, b, var_p ]  = polyomino_multihedral_matrix ( r_shape, p_num,...
    p_shapes, d );
  [ m, n ] = size ( a );
%
%  Create the LP file for submission to an optimizer.
%
  filename = 'Figure10a.lp';
  polyomino_lp_write ( filename, '\ Figure10a', m, n, a, b );

  fprintf ( 1, '\n' );
  fprintf ( 1, '  LPmake_Figure10a created the LP file "%s"\n', filename );

  return
end
