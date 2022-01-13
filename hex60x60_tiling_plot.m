function hex60x60_tiling_plot ( )

%*****************************************************************************80
%
%% hex60x60_tiling_plot() plots a solution of example HEX60X60.
%
%  Discussion:
%
%    The problem seeks to tile the 60x60 rectangle with 600 copies of a
%    single hexomino.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    23 June 2018
%
%  Author:
%
%    John Burkardt
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'hex60x60_tiling_plot():\n' );
  fprintf ( 1, '  Plot a solution of HEX60X60 example.\n' );
%
%  Get the problem definition.
%
  [ r, p ] = hex60x60_define ( );
%
%  Extract the solution from the CPLEX file.
%
  filename = 'hex60x60_solution';
  x = cplex_file_read ( filename );
%
%  Plot the solution.
%
  filename = 'hex60x60.fig';
  label = '60x60 tiled by 600 hexominoes';
  polyomino_monohedral_tiling_plot ( r, p, x, filename, label );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'hex60x60_tiling_plot():\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end

