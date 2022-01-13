function polyomino_monohedral_tiling_plot ( r, p, x, filename, label )

%*****************************************************************************80
%
%% polyomino_monohedral_tiling_plot() plots monohedral polyomino tilings.
%
%  Discussion:
%
%    The value of the internally set variable COLOR_CHOICE determines whether
%    1: all polyominoes have the same color;
%    2: all visible polyominoes have unique colors;
%    3: all polyominoes have unique colors.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    05 Septmber 2020
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    integer R(MR,NR), a matrix of 0's and 1's representing the region.
%
%    integer P(MP,NP), a matrix of 0's and 1's representing the polyomino.
%
%    integer X(NVAR,X_NUM), a binary vector describing one or more
%    solutions of the tiling problem.  Every possible placement of a copy of 
%    P has been assigned an index.  If X(I,J) is 1, then the I-th placement 
%    is included in solution J.
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
%    'Solution of the Reid Example'.
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
%  jpg -> jpeg.
%
  if ( length ( ext ) == 3 )
    if ( ext == 'jpg' )
      ext = 'jpeg';
    end
  end
%
%  Color_choice:
%  white for space, and"
%  1: 2 colors, a single color for all polyominoes.
%  2: NZ+1 colors, separate color for each visible polyomino.
%  3: VAR_NUM+1, separate color for every polyomino, visible or not.
%
  color_choice = 1;
%
%  Make a copy of FILENAME that we can change.
%
  filename2 = filename;
%
%  Get the sizes of R, P, and X.
%
  [ mp, np ] = size ( p );
  [ mr, nr ] = size ( r );
  [ mx, nx ] = size ( x );
%
%  Construct all possible variants (rotations and reflections) of P.
%
  [ mn_num, mn_v, nm_num, nm_v ] = polyomino_monohedral_variants ( mp, np, p );
%
%  Process each solution.
%
  for x_index = 1 : nx
%
%  The array S is our representation of the tiling.
%  S starts as a zeroed out version of R.
%
    s1 = zeros ( mr, nr );
    s2 = zeros ( mr, nr );
%
%  Start the variable count at 0.
%
    var = 0;
    nz = 0;
%
%  Handle the variants which have shape (MP,NP) like P.
%  Store the actual representation of the variant in Q.
%
    for k = 1 : mn_num

      mq = mp;
      nq = np;
      q = mn_v(1:mq,1:nq,k);
%
%  Determine the number of ways, and the corresponding offsets, by which
%  Q can be placed on R.
%
      number = polyomino_embed_number ( mr, nr, r, mq, nq, q );

      list = polyomino_embed_list ( mr, nr, r, mq, nq, q, number );
%
%  For each placement VAR, check whether it is part of the solution.
%  If so, we can mark the corresponding entries of S with VAR.
%
      for l = 1 : number
        var = var + 1;
        if ( x(var,x_index) == 1 )
          nz = nz + 1;
          if ( color_choice == 1 )
            color = 1;
          elseif ( color_choice == 2 )
            color = nz;
          elseif ( color_choice == 3 )
            color = var;
          end
          ioff = list(l,1);
          joff = list(l,2);
          s1(1+ioff:mq+ioff,1+joff:nq+joff) = ...
            s1(1+ioff:mq+ioff,1+joff:nq+joff) + color * q(1:mq,1:nq);
          s2(1+ioff:mq+ioff,1+joff:nq+joff) = ...
            s2(1+ioff:mq+ioff,1+joff:nq+joff) + nz * q(1:mq,1:nq);
        end
      end

    end
%
%  Similar procedure for the variants of P that have shape (N,M).
%
    for k = 1 : nm_num

      mq = np;
      nq = mp;
      q = nm_v(1:mq,1:nq,k);

      number = polyomino_embed_number ( mr, nr, r, mq, nq, q );
 
      list = polyomino_embed_list ( mr, nr, r, mq, nq, q, number );

      for l = 1 : number
        var = var + 1;
        if ( x(var,x_index) == 1 )
          nz = nz + 1;
          if ( color_choice == 1 )
            color = 1;
          elseif ( color_choice == 2 )
            color = nz;
          elseif ( color_choice == 3 )
            color = var;
          end
          ioff = list(l,1);
          joff = list(l,2);
          s1(1+ioff:mq+ioff,1+joff:nq+joff) = ...
            s1(1+ioff:mq+ioff,1+joff:nq+joff) + color * q(1:mq,1:nq);
          s2(1+ioff:mq+ioff,1+joff:nq+joff) = ...
            s2(1+ioff:mq+ioff,1+joff:nq+joff) + nz * q(1:mq,1:nq);
        end
      end

    end
%
%  Clear figure.
%  Prepare for overlaying multiple graphics commands.
%
    clf
    hold on
%
%  Before calling imagesc, we want to flip each column.
%
    s1 = flip ( s1 );
    s2 = flip ( s2 );
%
%  Display the solution as a matrix.
%
    imagesc ( s1 );

    lw = 0.04;

    for i = 1 : mr
      for j = 1 : nr

        if ( s2(i,j) ~= 0 ) 
%
%  Horizontal separator above.
%
          if ( i == 1 )
            xl = [j - 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j - 0.5 - lw ];
            yl = [i - 0.5 - lw, i - 0.5 - lw, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i-1,j) == 0 )
            xl = [j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [i - 0.5 - lw, i - 0.5 - lw, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i-1,j) ~= s2(i,j) )
            xl = [j - 0.5, j + 0.5, j + 0.5,      j - 0.5      ];
            yl = [i - 0.5, i - 0.5, i - 0.5 + lw, i - 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Horizontal separator below.
%
          if ( i == mr )
            xl = [j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [i + 0.5 + lw, i + 0.5 + lw, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i+1,j) == 0 )
            xl = [j - 0.5,      j + 0.5,      j + 0.5,      j - 0.5      ];
            yl = [i + 0.5 + lw, i + 0.5 + lw, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i+1,j) ~= s2(i,j) )
            xl = [j - 0.5, j + 0.5, j + 0.5,      j - 0.5      ];
            yl = [i + 0.5, i + 0.5, i + 0.5 - lw, i + 0.5 - lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Vertical separator to left.
%
          if ( j == 1 )
            xl = [ j - 0.5 - lw, j - 0.5 + lw, j - 0.5 + lw, j - 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i,j-1) == 0 )
            xl = [ j - 0.5 - lw, j - 0.5 + lw, j - 0.5 + lw, j - 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i,j-1) ~= s2(i,j) )
            xl = [ j - 0.5,      j - 0.5 + lw, j - 0.5 + lw, j - 0.5      ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end
%
%  Vertical separator to right.
%
          if ( j == nr )
            xl = [ j + 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i,j+1) == 0 )
            xl = [ j + 0.5 - lw, j + 0.5 + lw, j + 0.5 + lw, j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          elseif ( s2(i,j+1) ~= s2(i,j) )
            xl = [ j + 0.5 - lw, j + 0.5,      j + 0.5,      j + 0.5 - lw ];
            yl = [ i - 0.5 - lw, i - 0.5 - lw, i + 0.5 + lw, i + 0.5 + lw ];
            fill ( xl, yl, 'k' );
          end

        end
      end
    end

    hold off
%
%  Coloring option 1:
%  0 = white for blank space.
%  1 = light blue for all polyominoes.
%
    if ( color_choice == 1 )

      color_num = 2;
      caxis ( [ 0, 1 ] );
%
%  Coloring option 2:
%  Allow a color for each nonzero variable, plus 0=white.
%
    elseif ( color_choice == 2 )
      color_num = nz + 1;
      caxis ( [ 0, nz ] );
%
%  Coloring option 3:
%  Allow a color for each variable, plus 0=white.
%
    elseif ( color_choice == 3 )
      var_num = var;
      color_num = var_num + 1;
      caxis ( [ 0, var_num ] );
    end

    colormap ( jet ( color_num ) );
    cmap = colormap ( );
    cmap(1,1:3) = [ 1, 1, 1 ];
    colormap ( cmap );
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
