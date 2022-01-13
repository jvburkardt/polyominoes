function [ r_shape, p_num, p_shapes, d ] = ...
  polyomino_multihedral_example_pent18x30_define ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_pent18x30_define() defines example PENT18X30.
%
%  Discussion:
%
%    The problem seeks to tile the 18x30 rectangle with 9 copies of the
%    12 distinct pentominoes.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    17 June 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_pent18x30_define:\n' );
  fprintf ( 1, '  Define the data for the example in which an 18x30\n' );
  fprintf ( 1, '  rectangle is tiled by 9 copies of the 12 pentominoes.\n' );
%
%  Define R.
%
  r_m = 18;
  r_n = 30;
  r_shape = ones ( r_m, r_n );
%
%  Pack the 12 pentominoes into an 18x30x12 array.
%
  p_num = 12;
  p_shapes = pentomino_pack ( r_m, r_n );
%
%  D indicates how many copies of each pentomino we can use.
%
  d = 9 * ones ( p_num, 1 );

  return
end
