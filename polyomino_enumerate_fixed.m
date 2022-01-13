function number = polyomino_enumerate_fixed ( order )

%*****************************************************************************80
%
%% polyomino_enumerate_fixed() counts fixed polyominoes of given order (allowing holes).
%
%  Discussion:
%
%    Polyominoes are connected planar shapes formed by adjoining unit squares.
%
%    The number of unit squares in a polyomino is its order.
%
%    If we do not ignore reflections and rotations when comparing polyominoes,
%    then we are considering the class of "fixed" polyominoes.  In that case,
%    for instance, there are 63 fixed polyominoes of order 5.
%
%    As the order increases, the number of polyominoes grows very rapidly.
%    The list offered here goes no further than order 28, but the later
%    numbers in the list are too large to represent as 32 byte integers. 
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 April 2018
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
%    integer ORDER, the order of a polyomino, between 0 and 28;
%
%  Output:
%
%    integer NUMBER, the number of fixed polyominos of this order.
%
  number_vec = [  ...
    1. ...
    1, 2, 6, 19, 63,  ...
    216, 760, 2725, 9910, 36446,  ...
    135268, 505861, 1903890, 7204874, 27394666,  ...
    104592937, 400795844, 1540820542, 5940738676, 22964779660,  ...
    88983512783, 345532572678, 1344372335524, 5239988770268, 20457802016011,  ...
    79992676367108, 313224032098244, 1228088671826973 ];

  if ( 0 <= order && order <= 28 )
    number = number_vec(order+1);
  else
    fprintf ( 1, '\n' );
    fprintf ( 1, 'POLYOMINO_ENUMERATE_FIXED - Fatal error!\n' );
    fprintf ( 1, '  0 <= order <= 28 is required.\n' );
    fprintf ( 1, '  Input value was order = %d\n', order );
    error ( 'POLYOMINO_ENUMERATE_FIXED - Fatal error!' );
  end

  return
end
