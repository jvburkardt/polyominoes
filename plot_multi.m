function plot_multi ( r_shape, p_num, p_shapes, d, sol_file, image_file, solver )

%*****************************************************************************80
%
%% plot_multi() plots multihedral polyominotilings after optimization.
%
%  Discussion:
%
%    This program combines the codes POLYOMINO_MULTIHEDRAL_TILING_PLOT
%    and one of CPLEX_SOLUTION_READ, SCIP_SOLUTION_READ or GUROBI_SOLUTION_READ.
%
%    It represents step 3 in the following sequence:
%
%    1, Run the appropriate 'LP_MAKE' file in MATLAB;
%    2. Take the resulting LP file and solve it with one of the optimizers
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
%    22 July 2018
%
%  Author:
%
%    Marcus Garvie, John Burkardt
%
%  Input:
%
%    integer R_SHAPE(M_R,N_R): the binary matrix describing the region.
%
%    integer P_NUM: the number of distinct polyominoes.
%
%    integer P_SHAPES(M_R,N_R,P_NUM): a binary matrix describing the 
%    polyominoes.  The matrix is "top-left tight", that is, the I-th polyomino 
%    is stored in P_SHAPES(1:M_R,1:N_R,I) with a 1 in the first row, a 1 in the 
%    first column, but with trailing rows and columns of zeros allowed.
%
%    integer D(P_NUM): the number of times each polyomino can be used.
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
%  Read the LP file created by the optimization program.
%
  if ( solver == 1 )
    x = cplex_solution_read ( sol_file );
  elseif ( solver == 2 )
    x = scip_solution_read ( sol_file );
  elseif ( solver == 3 )
    x = gurobi_solution_read ( sol_file );
  end
%
%  Plot and save solutions.
%
  polyomino_multihedral_tiling_plot ( r_shape, p_num, p_shapes, d, ...
    x, image_file, '' );
 
  return
end
