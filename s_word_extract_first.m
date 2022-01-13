function [ w, s ] = s_word_extract_first ( s )

%*****************************************************************************80
%
%% s_word_extract_first() extracts the first word from a string.
%
%  Discussion:
%
%    A "word" is a string of characters terminated by a blank or
%    the end of the string.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    12 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Input:
%
%    string S, the string.
%
%  Output:
%
%    string W, the leading word of the string.
%
%    string S, the first word of the input string has been removed, 
%    and the remaining string has been shifted left.
%
  w = ' ';

  s_len = s_len_trim ( s );

  if ( s_len < 1 )
    return
  end
%
%  Find the first nonblank.
%
  get1 = 0;

  while ( true )

    get1 = get1 + 1;

    if ( s_len < get1 )
      return
    end

    if ( s(get1) ~= ' ' )
      break
    end

  end
%
%  Look for the last contiguous nonblank.
%
  get2 = get1;

  while ( true )

    if ( s_len <= get2 )
      break
    end

    if ( s(get2+1) == ' ' )
      break
    end

    get2 = get2 + 1;

  end
%
%  Copy the word.
%
  w = s(get1:get2);
%
%  Replace the original string by the unread portion.
%
  s = s(get2+1:s_len);

  return
end
