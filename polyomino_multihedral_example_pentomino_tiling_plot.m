function polyomino_multihedral_example_pentomino_tiling_plot ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_pentomino_tiling_plot() plots pentomino example:
%
%  Discussion:
%
%    Print tiling solutions for the pentomino problem.
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
  fprintf ( 1, 'polyomino_multihedral_example_pentomino_tiling_plot():\n' );
  fprintf ( 1, '  An 8x8 square with a 2x2 central hole is to be tiled\n' );
  fprintf ( 1, '  by the 12 pentominoes.  Plot a solution given in X.\n' );
%
%  Define R.
%
  r_m = 8;
  r_n = 8;
  r_shape = ones ( r_m, r_n );
  r_shape(4:5,4:5) = 0.0;
  polyomino_print ( r_shape, '  Region R:' );
%
%  P_NUM is the number of polyominoes.
%
  p_num = 12;
%
%  Pack the pentominoes into P_SHAPE.
%
  p_shapes = pentomino_pack ( r_m, r_n );
%
%  D indicates how many times each polyomino is to be used.
%
  d = ones ( p_num, 1 );
%
%  Get the solutions from a file.
%
  x = load ( 'pentomino_solution.txt' );
%
%  Plot the tilings corrresponding to each solution.
%
  filename = 'pentomino01.png';
  label = 'Pentomino Tiling';
  polyomino_multihedral_tiling_plot ( r_shape, p_num, p_shapes, d, x, ...
    filename, label );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'POLYOMINO_MULTIHEDRAL_EXAMPLE_PENTOMINO_TILING_PLOT\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
