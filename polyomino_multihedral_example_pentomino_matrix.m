function polyomino_multihedral_example_pentomino_matrix ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_pentomino_matrix() sets the pentomino example.
%
%  Discussion:
%
%    The problem seeks to tile the 8x8 rectangle with 12 distinct pentominoes.
%
%    This function sets up the corresponding linear system.  But because
%    the system is large, we expect the solution to be carried out by a
%    standard integer programming package such as CPLEX.
%
%    The resulting solution vectors X can then be examined.
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
  fprintf ( 1, 'polyomino_multihedral_example_pentomino_matrix():\n' );
  fprintf ( 1, '  Set up the linear system for the 8x8 pentomino example.\n' );
%
%  Define R.
%
  r_shape = ones(8,8);
  r_shape(4:5,4:5) = 0;
  [ r_m, r_n ] = size ( r_shape );
  polyomino_print ( r_shape, '  Region R:' );
%
%  Define pentominoes.
%
  pentomino = [ 'F', 'I', 'L', 'N', 'P', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ];

  p_num = 12;
  p_shape = zeros ( r_m, r_n, p_num );

  for k = 1 : p_num
    name = pentomino(k);
    pent = pentomino_matrix ( name );
    [ pent_m, pent_n ] = size ( pent );
    p_shape(1:pent_m,1:pent_n,k) = pent(1:pent_m,1:pent_n);
  end
%
%  Print the polyominoes.
%
  polyominoes_print ( r_m, r_n, p_num, p_shape, '  The 12 Pentominoes:' );
%
%  Set the vector D, which indicates how many copies of each polyomino
%  we can use: one of each, in this case.
%
  d = ones ( p_num, 1 );
%
%  Compute the system matrix.
%
  [ a, b, parent ] = polyomino_multihedral_matrix ( r_shape, p_num, p_shape, d );
  [ a_m, a_n ] = size ( a );
%
%  Write the linear system to an LP file.
%
  filename = 'pentomino.lp';
  comment = 'The 8x8 multihedral pentomino example.';
  polyomino_lp_write ( filename, comment, a_m, a_n, a, b );
%
%  Terminate.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'POLYOMINO_MULTIHEDRAL_EXAMPLE_PENTOMINO_MATRIX:\n' );
  fprintf ( 1, '  Normal end of execution.\n' );

  return
end
