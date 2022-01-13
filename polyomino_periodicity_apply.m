function t = polyomino_periodicity_apply ( r_m, r_n, r, p_m, p_n, p )

%*****************************************************************************80
%
%% polyomino_periodicity_apply() applies periodicity to a polyomino.
%
%  Discussion:
%
%    An R_M x R_N region R and a P_M x P_N polyomino P are given.  Both are 
%    represented as binary rectangles.
%
%    It is assumed that the polyomino P is periodically repeated with offsets
%    R_M and R_N.  Each entry of P is mapped into the range R_M x R_N and
%    added to an "image" T.  
%
%    If any elements of T are greater than 1, then the polyomino cannot be
%    periodically embedded in R without overlap.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    10 December 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R_M, R_N, the number of rows and columns in the 
%    representation of the region R.
%
%    integer R(R_M,R_N), a matrix of 0's and 1's representing the 
%    region.
%
%    integer P_M, P_N, the number of rows and columns in the 
%    representation of the polyomino R.
%
%    integer P(P_M,P_N), a matrix of 0's and 1's representing the 
%    polyomino.  
%
%  Output:
%
%    integer T(R_M,R_N), the periodic representation of the polyomino
%    in R.  
%
  t = zeros ( r_m, r_n );

  for i = 1 : p_m
    ip = i4_wrap ( i, 1, r_m );
    for j = 1 : p_n
      jp = i4_wrap ( j, 1, r_n );
      t(ip,jp) = t(ip,jp) + p(i,j);
    end
  end

  return
end
