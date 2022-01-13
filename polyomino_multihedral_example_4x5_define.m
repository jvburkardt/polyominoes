function [ r_shape, p_num, p_shapes, d ] = ...
  polyomino_multihedral_example_4x5_define ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_4x5_define() defines example 4x5.
%
%  Discussion:
%
%    The problem seeks to tile a 4x5 rectangle with a 1x2 hole, using
%    2 P pentominoes, a 2x2 square, and an L pentomino.
%
%    R: 1 1 1 1 1
%       1 1 1 1 1
%       1 1 0 0 1
%       1 1 1 1 1
%
%    P1: 1 1 1
%        1 1 0
%
%    P2: 1 1
%        1 1
%
%    P3: 0 0 1
%        1 1 1
%
%    Four tilings should be found.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 September 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_4x5_define:\n' );
  fprintf ( 1, '  Define the data for an example in which the region\n' );
  fprintf ( 1, '  is a 4x5 rectangle with a 1x2 hole,\n' );
  fprintf ( 1, '  tiled with a 2x2 square, 2 copies of the P pentomino,\n' );
  fprintf ( 1, '  and 1 copy of the L pentomino.\n' );
%
%  Define R.
%
  r_m = 4;
  r_n = 5;
  r_shape = ones ( r_m, r_n );
  r_shape(3,3:4) = 0;
%
%  Pack the polyominoes.
%
  p_num = 3;
  p_shapes = zeros ( r_m, r_n, p_num );

  p_shapes(1,1:3,1) = 1;
  p_shapes(2,1:2,1) = 1;

  p_shapes(1:2,1:2,2) = 1;

  p_shapes(1,4,3) = 1;
  p_shapes(2,1:4,3)= 1;
%
%  D indicates how many copies of each polyomino we can use.
%
  d = [ 2; 1; 1 ];

  return
end
