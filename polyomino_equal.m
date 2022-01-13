function value = polyomino_equal ( m1, n1, p1, m2, n2, p2 )

%*****************************************************************************80
%
%% polyomino_equal() determines if polyominoes P1 and P2 are equal.
%
%  Discussion:
%
%    P1 and P2 should only contain 0 and 1 entries.
%
%    The matrix representations P1 and P2 should be "tight", that is, there 
%    should be a nonzero in the first and last rows, and in the first and last 
%    columns.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    02 May 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M1, N1, the rows and columns in polyomino P1.
%
%    integer P1(M1,N1), the representation of polyonomial P1. 
%
%    integer M2, N2, the rows and columns in polyomino P2.
%
%    integer P2(M2,N2), the representation of polyonomial P2. 
%
%  Output:
%
%    logical VALUE, is true if P1 and P2 represent the same polyomino.
%
  if ( m1 ~= m2 )
    value = false;
  elseif ( n1 ~= n2 )
    value = false;
  else
    value = all ( all ( p1 == p2 ) );
  end

  return
end
