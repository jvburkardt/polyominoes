function [ a, b ] = polyomino_monohedral_example_reid_system ( )

%*****************************************************************************80
%
%% polyomino_monohedral_example_reid_system() sets up the Reid linear system.
%
%  Discussion:
%
%    This function sets up the linear system A*x=b associated with
%    the Reid polyomino tiling problem.
%
%    While it is desirable to have a general procedure that can automatically
%    deduce the linear system from the problem specification, for simplicity
%    in this example, we simply provide the linear system directly.
%
%    I have modified this file so that the numbering of equations and
%    variables agrees with the paper.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Output:
%
%    real A(8,10), the system matrix.
%
%    real B(8), the right hand side.
%

%
%  Each of 8 cells must be covered by one of 10 tile positions.
%
  a = [ ...
    1,0,0,0,0,1,0,0,0,0; ...
    0,0,1,0,0,1,0,0,0,0; ...
    1,1,0,0,0,0,1,0,0,0; ...
    0,0,1,1,0,0,1,1,0,0; ...
    0,0,0,0,1,0,0,1,0,0; ...
    0,1,0,0,0,0,0,0,1,0; ...
    0,0,0,1,0,0,0,0,1,1; ...
    0,0,0,0,1,0,0,0,0,1 ];

  b = [ 1;1;1;1;1;1;1;1];
%
%  Each tile covers two cells.  The total number of cells covered must be 8.
%
% a2 = [ ...
%   2,2,2,2,2,2,2,2,2,2];
% b2 = [8];
%
%  Combined system.
%
% a = [ a1; a2 ];
% b = [ b1; b2 ];

  return
end

