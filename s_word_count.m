function word_num = s_word_count ( s )

%*****************************************************************************80
%
%% s_word_count() counts the number of "words" in a string.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    30 January 2006
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    string S, the string to be examined.
%
%  Output:
%
%    integer WORD_NUM, the number of "words" in the string.
%    Words are presumed to be separated by one or more blanks.
%
  word_num = 0;
  s_length = length ( s );

  if ( s_length <= 0 )
    return;
  end

  blank = 1;

  for i = 1 : s_length

    if ( s(i) == ' ' )
      blank = 1;
    elseif ( blank == 1 )
      word_num = word_num + 1;
      blank = 0;
    end

  end

  return
end
