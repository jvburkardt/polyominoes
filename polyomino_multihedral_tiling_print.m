function [ r_label, r_color ] = polyomino_multihedral_tiling_print ( ...       
  r_shape, p_num, p_shapes, d, x, label );

%*****************************************************************************80
%
%% polyomino_multihedral_tiling_print() prints a multihedral tiling.
%
%  Discussion:
%
%    You can change the internal parameter "COLOR_CHOICE" to specify how to 
%    set the numbers that identify each polyomino component of the tiling.
%
%    You can change the internal parameter "SHOW_ZERO" to specify whether zero 
%    cells should be shown, or blanked out.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    27 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R_SHAPE(R_M,R_N), a matrix of 0's and 1's representing the region.
%
%    integer P_NUM, the number of polyomino shapes to be used.
%
%    integer P_SHAPES(M_R,N_R,P_NUM), a binary matrix describing the 
%    polyominoes.  The matrix is "top-left tight", that is, the I-th polyomino 
%    is stored in P_SHAPES(1:M_R,1:N_R,I) with a 1 in the first row, a 1 in the 
%    first column, but with trailing rows and columns of zeros allowed.
%
%    integer D(P_NUM), tells us how many copies of each polyomino
%    we must use in the tiling.
%
%    integer X(X_M), a solution to the problem, consisting 
%    of a binary value (0 or 1) for every possible placement of a polyomino 
%    variant onto R.
%
%    string LABEL, a label for the printout, such as 
%    'Solution #3 of the 2x4 Example'.
%
%  Output:
%
%    integer R_LABEL(R_M,R_N), an array of indices that suggest
%    the structure of the tiling.  Regions of R that are not used will either
%    be blank, or marked with zero.  Regions of R corresponding to a given
%    polyomino will be marked by a numeric label whose value depends on the
%    value of the internal parameter "color_choice".
%
%    integer R_COLOR(R_M,R_N), an array of indices that indicate
%    the colors applied to the tiling.  Regions of R that are not used will 
%    either be blank, or marked with zero.  The color range depends on the
%    value of the internal parameter "color_choice".
%

%
%  COLOR_CHOICE:
%
%  white for space, and:
%  1: 2 colors, a single color for all polyominoes.
%  2: NZ+1 colors, separate color for each visible polyomino.
%  3: VAR_NUM+1, separate color for every polyomino, visible or not.
%  4: P_NUM+1, separate color for each polyomino "parent", and variants.
%
  color_choice = 4;
%
%  SHOW_ZERO
%  0: do not show zero regions.
%  1: show zero regions.
%
  show_zero = 1;
%
%  Get the linear system satisfied by A*x=b.
%
  [ a, b, parent ] = polyomino_multihedral_matrix ( r_shape, p_num, p_shapes, d );
%
%  Get the size of the linear system.
%
  [ a_m, a_n ] = size ( a );
%
%  Get the size of R.
%
  [ r_m, r_n ] = size ( r_shape );
%
%  Get the number of nonzero cells in R.
%
  r_num = polyomino_area ( r_shape );
%
%  Index the nonzero cells in R.
%
  r_index = polyomino_index ( r_shape );
%
%  Get the size of X.
%  Code modified so it can only handle 1 solution at a time.
%
  [ x_m, x_n ] = size ( x );

% for x_index = 1 : x_n
  x_index = 1;
%
%  Replace each nonzero X(I,*) by an increasing index.
%
    xc = zeros ( x_m, 1 );
    xi = zeros ( x_m, 1 );

    nz = 0;
    var = 0;
    par = 0;

    for i = 1 : x_m

      if ( x(i,x_index) == 0 )
        color = 0;
      else
        nz = nz + 1;

        if ( color_choice == 1 )
          color = 1;
        elseif ( color_choice == 2 )
          color = nz;
        elseif ( color_choice == 3 )
          color = i;
        elseif ( color_choice == 4 )
          color = parent(i);
        end

        xc(i) = color;
        xi(i) = nz;

      end

    end
%
%  The first R_NUM rows of A are equations about covering each cell of R.
%
%  Multiplying this matrix times XC gives us:
%
    size ( a )
    size ( xc )
    axc = a(1:r_num,1:a_n) * xc;
    axi = a(1:r_num,1:a_n) * xi;
%
%  R_SHAPE is binary (0 or 1).
%  R_LABEL replaces each 1 by the index of the polyomino variant which covers it.
%
    r_color = zeros ( r_m, r_n );
    for i = 1 : r_m
      for j = 1 : r_n
        if ( r_index(i,j) == 0 )
          r_color(i,j) = 0;
        else
          r_color(i,j) = axc(r_index(i,j));
        end
      end
    
    end

    r_label = zeros ( r_m, r_n );
    for i = 1 : r_m
      for j = 1 : r_n
        if ( r_index(i,j) == 0 )
          r_label(i,j) = 0;
        else
          r_label(i,j) = axi(r_index(i,j));
        end
      end
    
    end
%
%  Print R_LABEL.
%
    fprintf ( 1, '\n' );
    fprintf ( 1, '%s\n', label );
    fprintf ( 1, '  Numeric Labels\n' );
    fprintf ( 1, '\n' );

    smax = max ( max ( r_label ) );
  
    for i = 1 : r_m
      fprintf ( 1, ' ' );
      for j = 1 : r_n
        if ( 10 <= smax && smax < 100 )
          if ( r_label(i,j) == 0 && show_zero == 0 )
            fprintf ( 1, '   ' );
          else
            fprintf ( 1, ' %2d', r_label(i,j) );
          end
        else
          if ( r_label(i,j) == 0 && show_zero == 0 )
            fprintf ( 1, '  ' );
          else
            fprintf ( 1, ' %d', r_label(i,j) );
          end
        end
      end
      fprintf ( 1, '\n' );
    end
%
%  Print R_COLOR
%
    fprintf ( 1, '\n' );
    fprintf ( 1, '%s\n', label );
    fprintf ( 1, '  "Colors"\n' );
    fprintf ( 1, '\n' );

    smax = max ( max ( r_label ) );
  
    for i = 1 : r_m
      fprintf ( 1, ' ' );
      for j = 1 : r_n
        if ( 10 <= smax && smax < 100 )
          if ( r_label(i,j) == 0 && show_zero == 0 )
            fprintf ( 1, '   ' );
          else
            fprintf ( 1, ' %2d', r_color(i,j) );
          end
        else
          if ( r_label(i,j) == 0 && show_zero == 0 )
            fprintf ( 1, '  ' );
          else
            fprintf ( 1, ' %d', r_color(i,j) );
          end
        end
      end
      fprintf ( 1, '\n' );
    end

% end

  return
end
