function list = polyomino_embed_list ( mr, nr, r, mp, np, p, number )

%*****************************************************************************80
%
%% polyomino_embed_list() lists the polyomino embeddings in a region.
%
%  Discusion:
%
%    A region R is a subset of an MRxNR grid of squares.
%
%    A polyomino P is a subset of an MPxNP grid of squares.
%
%    Both objects are represented by binary matrices, with the property that
%    there are no initial or final zero rows or columns.
%
%    For this computation, we regard P as a "fixed" polyomino; in other words,
%    no reflections or rotations will be allowed.
%
%    An "embedding" of P into R is an offset (MI,NJ) such that 
%      P(I,J) = R(I+MI,J+NJ) 
%      for 1 <= I <= MP, 1 <= J <= NP, and 
%      for 0 <= MI <= MR-MP, 0 <= MJ <= NR-NP.
%    We can detect an embedding simply by taking what amounts to a kind of
%    dot product of P with a corresponding subregion of R.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 April 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer MR, NR, the rows and columns in the region R.
%
%    integer R(MR,NR), a matrix of 0's and 1's representing the region.
%
%    integer MP, NP, the rows and columns in the polyomino P.
%
%    integer P(MP,NP), a matrix of 0's and 1's representing the polyomino.
%
%    integer NUMBER, the number of embeddings.
%
%  Output:
%
%    integer LIST(NUMBER,2), for each embedding, the I and J offsets applied 
%    to the polyomino P.
%
  list = zeros ( number, 2 );
%
%  Count the 1's in P.
%
  pr = polyomino_area ( p );
%
%  For each possible (I,J) coordinate of the upper left corner of a subset of R,
%  see if such a subset exactly matches P.
%
  k = 0;
  for mi = 0 : mr - mp
    for nj = 0 : nr - np
      srp = polyomino_area ( p(1:mp,1:np) .* r(1+mi:mp+mi,1+nj:np+nj) );
      if ( srp == pr )
        k = k + 1;
        list(k,1:2) = [ mi, nj ];
      end      
    end
  end

  return
end
