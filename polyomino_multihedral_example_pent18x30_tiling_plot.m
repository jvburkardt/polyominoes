function polyomino_multihedral_example_pent18x30_tiling_plot ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_pent18x30_tiling_plot() plots PENT18X30
%
%  Discussion:
%
%    PENT18X30 is a tiling problem in which the 18x30 rectangle is to be
%    tiled using 9 copies of the 12 pentominoes.
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
  fprintf ( 1, 'polyomino_multihedral_example_pent18x30_tiling_plot\n' );
  fprintf ( 1, '  Plot a tiling of the 18x30 rectangle that uses\n' );
  fprintf ( 1, '  9 copies of each of the 12 pentominoes.\n' );
%
%  Define the problem.
%
  [ r_shape, p_num, p_shapes, d ] = ...
    polyomino_multihedral_example_pent18x30_define ( );
%
%  Get the single solution X, which was computed by GUROBI.
%
  x = load ( 'pent18x30_gurobi.txt' );
%
%  Plot the tiling.
%
  filename = 'pent18x30.png';
  label = '18x30 rectangle, 9 copies of pentominoes.';

  polyomino_multihedral_tiling_plot ( r_shape, p_num, p_shapes, d, ...
    x, filename, label );

  return
end
