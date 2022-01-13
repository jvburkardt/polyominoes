function polyomino_multihedral_example_octomino_tiling_plot ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_octomino_tiling_plot()polyomino_boundary_word plots octomino example:
%
%  Discussion:
%
%    Print tiling solutions for the octomino problem.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 June 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'polyomino_multihedral_example_octomino_tiling_plot():\n' );
  fprintf ( 1, '  Given 8 solutions for the 8x8 multihedral octomino\n' );
  fprintf ( 1, '  tiling problem, plot a representation of the tiling\n' );
  fprintf ( 1, '  corresponding to each solution.\n' );
%
%  Define R.
%
  r_shape = ones(8,8);
  [ r_m, r_n ] = size ( r_shape );
  polyomino_print ( r_shape, '  Region R:' );
%
%  Define O1, O2, ...O8.
%
  o1 = [ ...
  1, 1, 1, 0, 0, 0, 0, 0; ...
  1, 1, 1, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

 o2 = [ ...
  1, 1, 1, 1, 0, 0, 0, 0; ...
  1, 1, 0, 1, 1, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o3 = [ ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 0, 1, 0, 0, 0, 0, 0; ...
  1, 1, 1, 1, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o4 = [ ...
  1, 1, 1, 1, 0, 0, 0, 0; ...
  1, 0, 1, 1, 0, 0, 0, 0; ...
  0, 0, 0, 1, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o5 = [ ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 1, 1, 1, 1, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o6 = [ ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 1, 0, 0, 0, 0, 0, 0; ...
  1, 1, 0, 0, 0, 0, 0, 0; ...
  1, 1, 1, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o7 = [ ...
  1, 1, 1, 1, 1, 0, 0, 0; ...
  0, 1, 0, 0, 0, 0, 0, 0; ...
  0, 1, 1, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];

  o8 = [ ...
  1, 0, 1, 0, 0, 0, 0, 0; ...
  1, 1, 1, 0, 0, 0, 0, 0; ...
  1, 0, 0, 0, 0, 0, 0, 0; ...
  1, 1, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0; ...
  0, 0, 0, 0, 0, 0, 0, 0 ];
%
%  Pack the octominoes into P_SHAPES.
%
  p_num = 8;
  p_shapes = zeros ( r_m, r_n, p_num );
  p_shapes(:,:,1) = o1;
  p_shapes(:,:,2) = o2;
  p_shapes(:,:,3) = o3;
  p_shapes(:,:,4) = o4;
  p_shapes(:,:,5) = o5;
  p_shapes(:,:,6) = o6;
  p_shapes(:,:,7) = o7;
  p_shapes(:,:,8) = o8;
%
%  D indicates how many times each polyomino is to be used.
%
  d = ones ( p_num, 1 );
%
%  Get the solutions from a file.
%
  x = load ( 'octomino_solution.txt' );
%
%  Plot the tilings corrresponding to each solution.
%
  filename = 'octomino01.png';
  label = '  8x8 Octomino Tiling';
  polyomino_multihedral_tiling_plot ( r_shape, p_num, p_shapes, d, x, ...
    filename, label );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'POLYOMINO_MULTIHEDRAL_EXAMPLE_OCTOMINO_TILING_PLOT\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
