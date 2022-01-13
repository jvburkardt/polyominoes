function polyomino_multihedral_example_pentomino_tiling_print ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_pentomino_tiling_print() prints pentomino tiling:
%
%  Discussion:
%
%    Print a solution for the 12 pentominoes tiling problem.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    10 June 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_pentomino_tiling_print():\n' );
  fprintf ( 1, '  Given a solution for the tiling of an 8x8 square with\n' );
  fprintf ( 1, '  a 2x2 central hole by 12 pentominoes, print the tiling.\n' );
%
%  Define R.
%
  r_m = 8;
  r_n = 8;
  r_shape = ones( r_m, r_n );
  r_shape(4:5,4:5) = 0;
  polyomino_print ( r_shape, '  Region R:' );
%
%  Define pentominoes.
%
  p_num = 12;
  p_shapes = pentomino_pack ( r_m, r_n );
%
%  Print the polyominoes.
%
  polyominoes_print ( r_m, r_n, p_num, p_shapes, '  The 12 Pentominoes:' );
%
%  D indicates how many times each polyomino is to be used.
%
  d = ones ( p_num, 1 );
%
%  Get the solutions from a file.
%
  x = load ( 'pentomino_solution.txt' );
%
%  Print the tilings corrresponding to each solution.
%
  label = '  Pentominoes Tile 8x8 Square with Hole';
  polyomino_multihedral_tiling_print ( r_shape, p_num, p_shapes, d, x, label );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'POLYOMINO_MULTIHEDRAL_EXAMPLE_PENTOMINO_TILING_PRINT\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
