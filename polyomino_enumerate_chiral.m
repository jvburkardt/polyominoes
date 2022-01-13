function number = polyomino_enumerate_chiral ( order )

%*****************************************************************************80
%
%% polyomino_enumerate_chiral() counts chiral polyominoes of given order (allowing holes).
%
%  Discussion:
%
%    Polyominoes are connected planar shapes formed by adjoining unit squares.
%
%    The number of unit squares in a polyomino is its order.
%
%    If we do allow rotations, but not reflections, when comparing polyominoes,
%    then we are considering the class of "chiral" or "one-sided" polyominoes.  
%    In that case, for instance, there are 18 chiral polyominoes of order 5.
%
%    As the order increases, the number of polyominoes grows very rapidly.
%    The list offered here goes no further than order 24, but the later
%    numbers in the list are too large to represent as 32 byte integers. 
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 April 2018
%
%  Author:
%
%    John Burkardt
%
%  Reference:
%
%    Solomon Golomb,
%    Polyominoes: Puzzles, Patterns, Problems, and Packings,
%    Princeton University Press, 1996,
%    ISBN: 9780691024448
%
%  Input:
%
%    integer ORDER, the order of a polyomino, between 0 and 30;
%
%  Output:
%
%    integer NUMBER, the number of chiral polyominos of this order.
%
  number_vec = [  ...
    1, ...
    1, 1, 2, 7, 18, ...
    60, 196, 704, 2500, 9189, ...
    33896, 126759, 476270, 1802312, 6849777, ...
    26152418, 100203194, 385221143, 1485200848, 5741256764, ...
    22245940545, 86383382827, 336093325058, 1309998125640, 5114451441106, ...
    19998172734786, 78306011677182, 307022182222506, 1205243866707468, 4736694001644862 ];

  if ( 0 <= order && order <= 30 )
    number = number_vec(order+1);
  else
    fprintf ( 1, '\n' );
    fprintf ( 1, 'POLYOMINO_ENUMERATE_CHIRAL - Fatal error!\n' );
    fprintf ( 1, '  0 <= order <= 30 is required.\n' );
    fprintf ( 1, '  Input value was order = %d\n', order );
    error ( 'POLYOMINO_ENUMERATE_CHIRAL - Fatal error!' );
  end

  return
end
