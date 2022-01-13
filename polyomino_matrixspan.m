function AM = polyomino_matrixspan ( filename )

%*****************************************************************************80
%
%% polyomino_matrixspan() assembles the matrix for a polyomino tiling problem.
%
%  Discussion:
%
%    For a given matrix equation
%
%     c1*A1 + c2*A2 + ... + cn*An = B  ---- (*)
%
%    where c1, c2, ..., cn are unknowns and A1, A2, ..., An, are given 
%    matrices, and B is a matrix of all ones. The rows corresponding 
%    to the constraints of each Series are then added to the augmemnted matrix.
%
%    While the original program was strictly interactive, it has been modified
%    to allow the input to be provided in a file.  Thus, if the program is
%    called with a nonempty filename argument, the input is read from this
%    file, rather than through interaction with the user.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    09 April 2018
%
%  Author:
%
%    Marcus Garvie
%
%  Input:
%
%    string FILENAME.  If this is nonempty, then further input is
%    read from this data file.  Otherwise, the program requests input from
%    the user.
%
%  Interactive input:
%
%    integer ROWS, COLS, the dimension of the matrices.
%
%    integer NS, the number of series
%
%    integer S(1,j), j = 1,...,NS, the number of matrices 
%    in each series
%
%    integer A(rows,cols), the current matrix for each a series.
%
%  Output:
%
%    integer AM(n*rows*cols+ns,n+1), the augmented matrix,
%    where n = total number of matrices in the span
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'POLYOMINO_MATRIXSPAN:\n' );
  fprintf ( 1, '  MATLAB version\n' );
  fprintf ( 1, '  Assemble the matrix associated with a polyomino tiling.\n' );

  if ( 0 < length ( filename ) )
    interactive = false;
    fid = fopen ( filename );
  else
    interactive = true;
  end
%
%  Input how many series.
%
  if ( interactive )
    ns = input('Enter the number of Series  ');
  else
    ns = fscanf ( fid, '%d', 1 );
  end

  s = zeros(1,ns);
  for j = 1 : ns
    if ( interactive )
      s(1,j) = input(['No. of matrices in Series ' num2str(j) '?  ']);
    else
      s(1,j) = fscanf ( fid, '%d', 1 );
    end
  end
%
%  Calculate how many matrices we have in total.
%
  n = sum ( s );
%
%  Specify the dimension of the matrices.
%
  if ( interactive )
    rows = input('Enter the no. of rows in the matrix  ');
    cols = input('Enter the no. of columns in the matrix  ');
  else
    rows = fscanf ( fid, '%d', 1 );
    cols = fscanf ( fid, '%d', 1 );
  end
%
%  The coefficient matrix is initialized.
%
  nrows = rows * cols + ns;
  ncols = n + 1;
  AM = zeros ( nrows, ncols );
%
%  Last column of ones added.
%
  AM(:,ncols) = ones ( nrows, 1 );
%
%  Prompt user for the matrices in each series and add 
%  each contribution to AM.
%
  matrix_no = 0;

  for j = 1:ns
    for i = 1:s(1,j)
      equation_no = 0;
      if ( interactive )
        A = input(['Enter matrix  ' num2str(i) ' in Series ' num2str(j) '   ']);
      else
        for ii = 1 : rows
           for jj = 1 : cols
            A(ii,jj) = fscanf ( fid, '%d', 1 );
          end
        end
      end
%
%  Loop through rows of A and add any ones to AM.
%
      matrix_no = matrix_no + 1;
      for ii = 1:rows
        for jj = 1:cols
          equation_no = equation_no + 1;
          if A(ii,jj)==1
            AM(equation_no,matrix_no) = 1;
          end
        end
      end
    end
  end
%
%  Now add contributions for constraints.
%
  column = 0;
  for j = 1:ns
    for i = 1:s(1,j)
      sc = sum(s(1,[1:j])); 
      AM(rows*cols+j,[sc-s(1,j)+1:sc]) = 1;
    end
  end

  return
end
