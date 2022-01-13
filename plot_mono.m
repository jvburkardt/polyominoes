function plot_mono ( r_shape, p_shapes, sol_file, image_file, solver )

%****************************************************************************80
%
%% plot_mono() plots monohedral polyomino tilings after optimization.
%
%  Discussion:
%
%    This program combines the codes POLYOMINO_MONOHEDRAL_TILING_PLOT
%    and one of CPLEX_SOLUTION_READ, SCIP_SOLUTION_READ or GUROBI_SOLUTION_READ.
%
%    It represents step 3 in the following sequence:
%
%    1. Run the appropriate 'LP_MAKE' file in MATLAB;
%    2. Take the resulting LP file and solve with one of the optimizers
%       (CPLEX, SCIP or GUROBI);
%    3. Bring the solution from step 2 back into MATLAB, run this program,
%       and wait as the image files are generated.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    22 July 2020
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Input:
%
%    integer R_SHAPE(M_R,N_R), the binary matrix describing the region.
%
%    integer P_SHAPES(M_R,N_R), a binary matrix describing the 
%    polyomino.  The matrix is "top-left tight", that is, the polyomino 
%    is stored with a 1 in the first row, a 1 in the first column, but 
%    with trailing rows and columns of zeros allowed.
%
%    string SOL_FILE: the name of the file containing the solutions produced 
%    by the optimizer, with filename extension 'sol' for CPLEX and GUROBI 
%    and extension 'txt' for SCIP.
%
%    string IMAGE_FILE: the name of the first image file to be generated,
%    such as 'test01.png'.  The name should include a numeric field.
%    If there are multiple solutions, the numeric field will be automatically
%    incremented.  In this example, files 'test01.png' would be followed by
%    'test02.png' and so on.
%    Any valid Matlab extension is allowed in the filename, such as 'jpg', 'png', 
%    'pdf', 'tif', or 'fig'. 
%
%    integer SOLVER: identifies the optimizer that was used:
%    *1 for CPLEX 
%    *2 for SCIP
%    *3 for GUROBI
%

%
%  Read the LP file produced by CPLEX, SCIP or GUROBI.
%
  if ( solver == 1 )
    x = cplex_solution_read ( sol_file );
  elseif ( solver == 2 )
    x = scip_solution_read ( sol_file );
  else (solver == 3)
    x = gurobi_solution_read ( sol_file );
  end 
% 
%  Plot the solutions.
%
  polyomino_monohedral_tiling_plot ( r_shape, p_shapes, x, image_file, '' );

  return
end

