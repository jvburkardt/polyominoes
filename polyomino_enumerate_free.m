function number = polyomino_enumerate_free ( order )

%*****************************************************************************80
%
%% polyomino_enumerate_free() counts free polyominoes of given order (allowing holes).
%
%  Discussion:
%
%    Polyominoes are connected planar shapes formed by adjoining unit squares.
%
%    The number of unit squares in a polyomino is its order.
%
%    If we ignore reflections and rotations when comparing polyominoes,
%    then we are considering the class of "free" polyominoes.  In that case,
%    for instance, there are just 12 free polyominoes of order 5, the
%    so called "pentominoes".
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
%    integer ORDER, the order of a polyomino, between 0 and 28.
%
%  Output:
%
%    integer NUMBER, the number of polyominos of this order.
%
  number_vec = [  ...
    1, ...   
    1,  1,  2,  5,  12, ...
    35,  108,  369,  1285,  4655, ...
    17073,  63600,  238591,  901971,  3426576, ...
    13079255,  50107909,  192622052,  742624232,  2870671950, ...
    11123060678,  43191857688,  168047007728,  654999700403,  2557227044764, ...
    9999088822075,  39153010938487,  153511100594603 ];

  if ( 0 <= order && order <= 28 )
    number = number_vec(order+1);
  else
    fprintf ( 1, '\n' );
    fprintf ( 1, 'POLYOMINO_ENUMERATE_FREE - Fatal error!\n' );
    fprintf ( 1, '  0 <= order <= 28 is required.\n' );
    fprintf ( 1, '  Input value was order = %d\n', order );
    error ( 'POLYOMINO_ENUMERATE_FREE - Fatal error!' );
  end

  return
end
