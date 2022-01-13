function [ a, b ] = polyomino_multihedral_example_2x4_system ( )

%*****************************************************************************80
%
%% polyomino_multihedral_example_2x4_system() sets the polyomino system.
%
%  Discussion:
%
%    This function sets up the linear system A*x=b associated with
%    problem of tiling a 2x4 rectangular region R with several different
%    polyomino shapes.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Output:
%
%    real A(11,20), the system matrix.
%
%    real B(11), the right hand side.
%

%
%  Covering conditions.
%
  a1 = [ ...
    1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0;
    0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1;
    0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1;
    0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1;
    0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0;
    0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0;
    0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0;
    0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1];
  b1 = [1;1;1;1;1;1;1;1];
%
%  Polyomino repetition conditions.
%
  a2 = [ ...
    1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1];
  b2 = [1;1;1];
%
%  Area matching condition.
%
%  a3 = [ ...
%    1,1,1,1,1,1,1,1,3,3,3,3,4,4,4,4,4,4,4,4];
%
% b3 = [ 8 ];
%
%  Combined system.
%
% a = [ a1; a2; a3 ];
% b = [ b1; b2; b3 ];

  a = [ a1; a2 ];
  b = [ b1; b2 ];

  return
end

