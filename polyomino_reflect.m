function [ mq, nq, q ] = polyomino_reflect ( m, n, p )

%*****************************************************************************80
%
%% polyomino_reflect() reflects a polyomino about the vertical axis.
%
%  Discussion:
%
%    The reflection is carried out by simply reversing the order of the
%    elements of each row of the polyomino.
%
%  Example:
%
%    0 0 1 0 0 0
%    1 1 1 0 0 1
%    0 0 1 1 1 1
%
%    is reflected to
%
%    0 0 0 1 0 0
%    1 0 0 1 1 1
%    1 1 1 1 0 0
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    14 October 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the rows and columns in the polyomino P.
%
%    integer P(M,N), a matrix of 0's and 1's representing the 
%    polyomino.  The matrix should be "tight", that is, there should be a
%    1 in row 1, and in column 1, and in row M, and in column N.
%
%  Output:
%
%    integer MQ, NQ, the rows and columns of the transformed polyomino
%
%    integer Q(MQ,NQ), the transformed polyomino.
%
  mq = m;
  nq = n;
  q = fliplr ( p );

  return
end
