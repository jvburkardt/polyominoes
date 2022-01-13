function area = polyomino_area ( p )

%*****************************************************************************80
%
%% polyomino_area() returns the area of a polyomino.
%
%  Discussion:
%
%    A polyomino is a shape formed by connecting unit squares edgewise.
%
%    A polyomino can be represented by an MxN matrix, whose entries are
%    1 for squares that are part of the polyomino, and 0 otherwise.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    03 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer P(MP,NP), a matrix of 0's and 1's representing the polyomino.  
%
%  Output:
%
%    integer AREA, the area of the polyomino.
%
  area = sum ( sum ( p ) );

  return
end
