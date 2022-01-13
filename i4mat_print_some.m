function i4mat_print_some ( m, n, a, ilo, jlo, ihi, jhi, label )

%*****************************************************************************80
%
%% i4mat_print_some() prints out a portion of an I4MAT.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    31 July 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer M, N, the number of rows and columns of the matrix.
%
%    integer A(M,N), an M by N matrix to be printed.
%
%    integer ILO, JLO, the first row and column to print.
%
%    integer IHI, JHI, the last row and column to print.
%
%    string LABEL, a title.
%
  incx = 10;

  if ( 0 < length ( label ) )
    fprintf ( 1, '\n' );
    fprintf ( 1, '%s\n', label );
  end

  if ( m <= 0 || n <= 0 )
    fprintf ( 1, '\n' );
    fprintf ( 1, '  (None)\n' );
    return
  end

  for j2lo = max ( jlo, 1 ): incx : min ( jhi, n )

    j2hi = j2lo + incx - 1;
    j2hi = min ( j2hi, n );
    j2hi = min ( j2hi, jhi );

    fprintf ( 1, '\n' );
    fprintf ( 1, '  Col: ' );

    for j = j2lo : j2hi
      fprintf ( 1, '%7d  ', j );
    end

    fprintf ( 1, '\n' );
    fprintf ( 1, '  Row\n' );
    fprintf ( 1, '\n' );

    i2lo = max ( ilo, 1 );
    i2hi = min ( ihi, m );

    for i = i2lo : i2hi

      fprintf ( 1, '%5d: ', i );
      for j = j2lo : j2hi
        fprintf ( 1, '%7d  ', a(i,j) );
      end

      fprintf ( 1, '\n' );

    end

  end

  return
end
