function parity = polyomino_parity ( p )

%*****************************************************************************80
%
%% polyomino_parity() returns the parity of a polyomino.
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
%    integer PARITY: the parity of the polynomial.
%
  parity = abs ( ...
         sum ( sum ( p(1:2:end,1:2:end) ) ) ...
       + sum ( sum ( p(2:2:end,2:2:end) ) ) ...
       - sum ( sum ( p(2:2:end,1:2:end) ) ) ...
       - sum ( sum ( p(1:2:end,2:2:end) ) ) );

  return
end
