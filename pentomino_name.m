function name = pentomino_name ( index )

%*****************************************************************************80
%
%% pentomino_name() returns the standard name of pentominoes 1 through 12.
%
%  Discussion:
%
%    There is a standard name for each pentomino, suggested by its shape.  
%    We list them in alphabetical order:
%
%     1  F
%     2  I
%     3  L
%     4  N
%     5  P
%     6  T
%     7  U
%     8  V
%     9  W
%    10  X
%    11  Y
%    12  Z
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    11 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer INDEX, a value between 1 and 12.
%
%  Output:
%
%    character NAME, is the corresponding name.
%
  pentomino_name = [ 'F', 'I', 'L', 'N', 'P', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ];

  if ( 1 <= index && index <= 12 )
    name = pentomino_name ( index );
  else
    name = '?';
  end

  return
end

