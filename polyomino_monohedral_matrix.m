function [ a, b ] = polyomino_monohedral_matrix ( r, p )

%*****************************************************************************80
%
%% polyomino_monohedral_matrix() sets the linear system for a polyomino monotiling.
%
%  Discussion:
%
%    Given the problem of tiling a region R with copies of a polyomino P
%    which may be reflected or rotated, this function computes the linear
%    system A*x=b that can be used to search for solutions.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 November 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R(MR,NR), a binary matrix describing the region.
%
%    integer P(MP,NP), a binary matrix describing the polyomino.
%
%  Output:
%
%    integer A(EQN_NUM,VAR_NUM), the system matrix.
%
%    intege B(EQN_NUM,1), the right hand side.
%

%
%  E will index the nonzero cells in R, and represents equations.
%
  e = polyomino_index ( r );
%
%  Get sizes.
%
  [ mp, np ] = size ( p );
  [ mr, nr ] = size ( r );
%
%  From P, get each variant.
%
  [ mn_num, mn_v, nm_num, nm_v ] = polyomino_monohedral_variants ( mp, np, p );
%
%  Determine the number of equations.
%
  eqn_num = polyomino_area ( r );
%
%  Determine the number of variables.
%
  var_num = 0;

  for k = 1 : mn_num

    mq = mp;
    nq = np;
    q = mn_v(1:mq,1:nq,k);

    number = polyomino_embed_number ( mr, nr, r, mq, nq, q );

    for l = 1 : number
      var_num = var_num + 1;
    end

  end

  for k = 1 : nm_num

    mq = np;
    nq = mp;
    q = nm_v(1:mq,1:nq,k);

    number = polyomino_embed_number ( mr, nr, r, mq, nq, q );

    for l = 1 : number
      var_num = var_num + 1;
    end

  end
%
%  Set aside space for the linear system.
%
  a = zeros ( eqn_num, var_num );
  b = ones ( eqn_num, 1 );
%
%  Start variable count at 0.
%
  var = 0;
%
%  For each MN variant VAR, determine the embeddings.
%  This sets column VAR.
%
  for k = 1 : mn_num

    mq = mp;
    nq = np;
    q = mn_v(1:mq,1:nq,k);

    number = polyomino_embed_number ( mr, nr, r, mq, nq, q );

    list = polyomino_embed_list ( mr, nr, r, mq, nq, q, number );

    for l = 1 : number
      var = var + 1;
      ioff = list(l,1);
      joff = list(l,2);
      q2 = zeros ( mr, nr );
      q2(1+ioff:mq+ioff,1+joff:nq+joff) = q(1:mq,1:nq);
      e_dot_q2 = e .* q2;
      eqn = e_dot_q2( e_dot_q2 ~= 0 );
      a(eqn,var) = 1;
    end

  end
%
%  For each NM variant VAR, determine the embeddings.
%  This sets column VAR.
%
  for k = 1 : nm_num

    mq = np;
    nq = mp;
    q = nm_v(1:mq,1:nq,k);

    number = polyomino_embed_number ( mr, nr, r, mq, nq, q );

    list = polyomino_embed_list ( mr, nr, r, mq, nq, q, number );

    for l = 1 : number
      var = var + 1;
      ioff = list(l,1);
      joff = list(l,2);
      q2 = zeros ( mr, nr );
      q2(1+ioff:mq+ioff,1+joff:nq+joff) = q(1:mq,1:nq);
      e_dot_q2 = e .* q2;
      eqn = e_dot_q2( e_dot_q2 ~= 0 );
      a(eqn,var) = 1;
    end

  end

  return
end

