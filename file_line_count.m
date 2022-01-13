function [ line_num, blank_num, comment_num, data_num ] = ...
  file_line_count ( filename )

%*****************************************************************************80
%
%% file_line_count() counts the lines in a file.
%
%  Discussion:
%
%    Each input line is a "RECORD".
%
%    The records are divided into three groups:
%    
%    * BLANKS (nothing but blanks)
%    * COMMENTS (begin with a '#')
%    * DATA (anything else)
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license. 
%
%  Modified:
%
%    06 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    string FILENAME, the name of the input file.
%
%  Output:
%
%    integer LINE_NUM, the number of lines.
%
%    integer BLANK_NUM, COMMENT_NUM, DATA_NUM, the number of blank, comment
%    and data lines.
%
  input_unit = fopen ( filename );

  if ( input_unit < 0 ) 
    fprintf ( 1, '\n' );
    fprintf ( 1, 'FILE_LINE_COUNT - Error!\n' );
    fprintf ( 1, '  Could not open the file "%s".\n', filename );
    error ( 'FILE_LINE_COUNT - Error!' );
  end

  blank_num = 0;
  comment_num = 0;
  row_num = 0;
  line_num = 0;
  
  while ( true )

    line = fgetl ( input_unit );

    if ( line == -1 )
      break;
    end

    line_num = line_num + 1;
    line_length = s_len_trim ( line );
    
    if ( line_length <= 0 )
      blank_num = blank_num + 1;
    elseif ( line(1) == '#' )
      comment_num = comment_num + 1;
    else
      row_num = row_num + 1;
    end

  end

  fclose ( input_unit );

  return
end
