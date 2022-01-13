function [ mn_num, mn_v, nm_num, nm_v ] = polyomino_monohedral_variants ( m, n, p )

%*****************************************************************************80
%
%% polyomino_monohedral_variants() reports the distinct orientations of a polyomino.
%
%  Discussion:
%
%    Given a polyomino as a physical object, we can flip it over, and we
%    can turn it 90, 180 or 270 degrees.  The transformed object may
%    actually have the same profile as the original, or it may differ.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 April 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns in the representation
%    of the polyomino P.
%
%    integer P(M,N), a matrix of 0's and 1's representing the 
%    polyomino.  The matrix should be "tight", that is, there should be a
%    1 in row 1, and in column 1, and in row M, and in column N.
%
%  Output:
%
%    integer MN_NUM, the number of variants with M rows and N columns,
%    which will be at least 1.
%
%    integer MN_V(M,N,MN_NUM), the variants with M rows and N columns.
%
%    integer NM_NUM, the number of variants with N rows and M columns,
%    which will be 0 if M = N.
%
%    integer NM_V(N,M,NM_NUM), the variants with N rows and M columns.
%
  mn_num = 0;
  mn_v = [];

  nm_num = 0;
  nm_v = [];
%
%  Case 1: M = N.  All orientations are comparable.
%
  if ( m == n )

    for reflect = 0 : 1
      for rotate = 0 : 4

        [ mq, nq, q ] = polyomino_transform ( m, n, p, rotate, reflect );

        different = true;
        for k = 1 : mn_num
          if ( polyomino_equal ( mq, nq, q, m, n, mn_v(:,:,k) ) )
            different = false;
            break;
          end
        end

        if ( different )
          mn_num = mn_num + 1;
          mn_v(1:m,1:n,mn_num) = q(1:m,1:n);
        end

      end
    end
%
%  Case 2: M /= N.  Orientations are split into MN and NM groups.
%
  else

    for reflect = 0 : 1
      for rotate = 0 : 4

        [ mq, nq, q ] = polyomino_transform ( m, n, p, rotate, reflect );

        if ( mq == m )

          different = true;
          for k = 1 : mn_num
            if ( polyomino_equal ( mq, nq, q, m, n, mn_v(:,:,k) ) )
              different = false;
              break;
            end
          end

          if ( different )
            mn_num = mn_num + 1;
            mn_v(1:mq,1:nq,mn_num) = q(1:mq,1:nq);
          end

        else

          different = true;
          for k = 1 : nm_num
            if ( polyomino_equal ( mq, nq, q, n, m, nm_v(:,:,k) ) )
              different = false;
              break;
            end
          end

          if ( different )
            nm_num = nm_num + 1;
            nm_v(1:mq,1:nq,nm_num) = q(1:mq,1:nq);
          end
        end

      end
    end
  end

  return
end
