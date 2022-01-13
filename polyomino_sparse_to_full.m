function p = polyomino_sparse_to_full ( ps )

%*****************************************************************************80
%
%% polyomino_sparse_to_full() converts a polyomino from sparse to full form.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 January 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer PS(NS,2), the grid points forming the polyomino.
%
%  Output:
%
%    integer P(M,N), a rectangular grid:
%    P(I,J) = 0, this square is not part of the polyomino.
%    P(I,J) = 1, this square is part of the polyomino.
%
  [ ns, ~ ] = size ( ps );

  i_min = min ( ps(:,1) );
  i_max = max ( ps(:,1) );
  j_min = min ( ps(:,2) );
  j_max = max ( ps(:,2) );

  m = i_max - i_min + 1;
  n = j_max - j_min + 1;
  p = zeros ( m, n );

  for k = 1 : ns
    p(ps(k,1)+1-i_min,ps(k,2)+1-j_min) = 1;
  end

  return
end

