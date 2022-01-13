function pack = pentomino_pack ( m, n )

%*****************************************************************************80
%
%% pentomino_pack() "packs" all 12 pentominoes into an MxNx12 array.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    13 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns in the pack.
%    M should be at least 3, and N should be at least 5.
%
%  Output:
%
%    integer PACK(M,N,12), a 3 dimensional array containing the
%    12 pentominoes.
%
  pack = zeros ( m, n, 12 );

  for k = 1 : 12
    name = pentomino_name ( k );
    p = pentomino_matrix ( name );
    [ p_m, p_n ] = size ( p );
    pack(1:p_m,1:p_n,k) = p(1:p_m,1:p_n);
  end

  return
end

