function polyomino_multihedral_tiling_plot ( r_shape, p_num, p_shapes, d, ...
  x, filename, label );

%*****************************************************************************80
%
%% polyomino_multihedral_tiling_plot() plots multihedral polyomino tilings.
%
%  Discussion:
%
%    You need a tiling problem definition (R_SHAPE, P_NUM, P_SHAPES, D) and
%    one or more solution vectors in the array X, in order for this function
%    to create a plot of the proposed tiling.
%
%    This function cannot detect bogus tilings.  If your vector X describes
%    a tiling that actually does not cover some cells of R, those cells will
%    appear white, as though they were not part of the region.  If X indicates
%    more than one polyomino covering a cell, then that cell will be assigned
%    a color that is the sum of the indices of all the colors of polyominoes
%    covering the cell, which will result in a bogus and somewhat chaotic plot.
%
%
%    The interpretation of X, that is, the association of an index into X with
%    a particular polyomino that has been reflected, rotated, and translated,
%    depends entirely on the scheme used by polyomino_multihedral_variants().
%
%
%    The value of the internally set variable COLOR_CHOICE determines whether
%    1: all polyominoes have the same color;
%    2: all visible polyominoes have unique colors;
%    3: all polyominoes have unique colors.
%    4: each polyomino "parent" has a unique color, shared by all variants.
%
%
%    The color map is internally set to jet.  Other choices for MATLAB's
%    build-in color maps include parula, hsv, hot, cool, spring, summer,
%    winter, and gray.  
%
%    To use a different color map, find the following line:
%      colormap ( jet ( color_num ) );
%    and change "jet" to your desired color map.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 September 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R_SHAPE(R_M,R_N), a matrix of 0's and 1's representing the 
%    region.
%
%    integer P_NUM, the number of polyomino shapes to be used.
%
%    integer P_SHAPES(R_M,R_N,P_NUM), a binary matrix describing the 
%    polyominoes.  The matrix is "top-left tight", that is, the I-th polyomino 
%    is stored in P_SHAPES(1:R_M,1:R_N,I) with a 1 in the first row, a 1 in the 
%    first column, but with trailing rows and columns of zeros allowed.
%
%    integer D(P_NUM), tells us how many copies of each polyomino
%    we must use in the tiling.
%
%    integer X(X_M,X_N), a binary vector describing one or more
%    solutions of the tiling problem.  Every possible placement of every variant 
%    of a polyomino in P has been assigned an index.  If X(I,J) is 1, then 
%    the I-th placement is included in solution J.
%
%    string FILENAME, a filename to be used for storing plots.
%    Unless only one file is to be created, the filename should include
%    a numeric field.  The first file created will have the name specified 
%    in FILENAME.  Subsequent files, if needed, will create new filenames
%    by incrementing the numeric field.  if the numeric field is only a 
%    single digit, as in "plot1.png", then once "plot9.png" is reached, the
%    next name will wrap around to "plot0.png".  In order to avoid this, 
%    use a name like "plot01.png" for up to 99 plots, and so on.
%    Note that the extension of the filename should be recognizable by
%    MATLAB, including: 'bmp, 'eps', 'fig', 'jpeg', 'jpg', 'pbm', 'pdf', 'pgm', 
%    'png', 'tif'.
%
%    string LABEL, a label for the printout, such as 
%    'Solution of the 2x4 Example'.
%
  fprintf ( 1, '\n' );
%
%  Get "ext", which tells us the type of files to create.
%
  [ path, name, ext ] = fileparts ( filename );
%
%  Remove the initial period from EXT.
%
  ext = ext(2:end);
%
%  MATLAB only accepts "jpeg" as a device.
%  If the user specified "jpg", switch jpg -> jpeg.
%
  if ( length ( ext ) == 3 )
    if ( ext == 'jpg' )
      ext = 'jpeg';
    end
  end
%
%  Color_choice:
%  white for space, and:
%  1: 2 colors, a single color for all polyominoes.
%  2: NZ+1 colors, separate color for each visible polyomino.
%  3: VAR_NUM+1, separate color for every polyomino, visible or not.
%  4: P_NUM+1, separate color for each polyomino "parent", and variants.
%
  color_choice = 4;
%
%  Make a copy of FILENAME that we can change.
%
  filename2 = filename;
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
%  Get tne number of cells in R.
%
  r_num = polyomino_area ( r_shape );
%
%  Index the nonzero cells in R.
%
  r_index = polyomino_index ( r_shape );
%
%  Get the size of X.
%
  [ x_m, x_n ] = size ( x );

  for x_index = 1 : x_n
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
    axc = a(1:r_num,1:a_n) * xc;
    axi = a(1:r_num,1:a_n) * xi;
%
%  R_SHAPE is binary (0 or 1).
%  R_TILING replaces each 1 by the index of the polyomino variant which
%  covers it.
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
%  Clear figure.
%  Prepare for overlaying multiple graphics commands.
%
    clf ( );
    hold ( 'on' );
%
%  Before working with imagesc, we want to flip each column.
%
    r_color = flip ( r_color );
    r_label = flip ( r_label );
%
%  Display the solution as a matrix.
%
    imagesc ( r_color );

    lw = 0.04;

    for i = 1 : r_m
      for j = 1 : r_n

        if ( r_label(i,j) ~= 0 ) 
%
%  Horizontal separator above.
%
          if ( i == 1 )
            xl = [ j - 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j - 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i-1,j) == 0 )
            xl = [ j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i-1,j) ~= r_label(i,j) )
            xl = [ j - 0.5, j + 0.5, j + 0.5,      j - 0.5      ];
            yl = [ i - 0.5, i - 0.5, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Horizontal separator below.
%
          if ( i == r_m )
            xl = [ j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [ i + 0.5 + lw, i + 0.5 + lw, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i+1,j) == 0 )
            xl = [ j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [ i + 0.5 + lw, i + 0.5 + lw, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i+1,j) ~= r_label(i,j) )
            xl = [j - 0.5, j + 0.5, j + 0.5,      j - 0.5      ];
            yl = [ i + 0.5, i + 0.5, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Vertical separator to left.
%
          if ( j == 1 )
            xl = [ j - 0.5 - lw, j - 0.5 + lw, j - 0.5 + lw, j - 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i,j-1) == 0 )
            xl = [ j - 0.5 - lw, j - 0.5 + lw, j - 0.5 + lw, j - 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i,j-1) ~= r_label(i,j) )
            xl = [ j - 0.5,      j - 0.5 + lw, j - 0.5 + lw, j - 0.5      ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Vertical separator to right.
%
          if ( j == r_n )
            xl = [ j + 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i,j+1) == 0 )
            xl = [ j + 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( r_label(i,j+1) ~= r_label(i,j) )
            xl = [ j + 0.5 - lw, j + 0.5,      j + 0.5,      j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end

        end
      end
    end

    hold ( 'off' );
%
%  Coloring option 1:
%  0 = white for blank space.
%  1 = light blue for all polyominoes.
%
    if ( color_choice == 1 )

      color_num = 2;
%
%  Coloring option 2:
%  Allow a color for each nonzero variable, plus 0=white.
%
    elseif ( color_choice == 2 )
      color_num = nz + 1;
%
%  Coloring option 3:
%  Allow a color for each variable, plus 0=white.
%
    elseif ( color_choice == 3 )
      var_num = x_m;
      color_num = var_num + 1;
%
%  Coloring option 4:
%  Allow a color for each "parent", plus 0=white.
%
    elseif ( color_choice == 4 )
      color_num = p_num + 1;
    end

    caxis ( [ 0, color_num - 1 ] );
%
%  For gray scale plots, change "false" to "true".
%
    if ( false )
      colormap ( gray ( color_num ) );
      cmap = colormap ( );
      newmap = contrast ( cmap );
      newmap(1,1:3) = [ 1, 1, 1 ];
      colormap ( newmap );
      brighten ( 0.4 );
%
%  You can change "jet" to another built-in MATLAB color map.
%
    else
      colormap ( jet ( color_num ) );
      cmap = colormap ( );
      cmap(1,1:3) = [ 1, 1, 1 ];
      colormap ( cmap );
    end
%
%  Title the plot.
%
    title ( { label; filename2 } )
%
%  Use the same scale for X and Y directions.
%
    axis ( 'equal' )
%
%  Don't display the graph axes.
%
    axis ( 'off' )
%
%  Save a version of the plot.
%
    if ( isempty ( ext ) )

    else

      device = [ '-d', ext ];
      print ( device, filename2 );
      fprintf ( 1, '  Saved plot as "%s"\n', filename2 );

    end

    filename2 = filename_inc ( filename2);

  end

  return
end
