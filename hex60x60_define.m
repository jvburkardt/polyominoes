function [ r_shape, p ] = hex60x60_define ( )

%*****************************************************************************80
%
%% hex60x60_define() defines example HEX60X60.
%
%  Discussion:
%
%    The problem seeks to tile the 60x60 rectangle with 600 copies of a
%    single hexomino.
%
%  Licensing:
%
%    This code is distributed under the GNU LGPL license.
%
%  Modified:
%
%    21 June 2018
%
%  Author:
%
%    John Burkardt
%
%  Output:
%
%    integer R_SHAPE(60,60), the region.
%
%    integer P(3,3), the polyomino.
%
  fprintf ( 1, '\n' );
  fprintf ( 1, 'hex60x60_define():\n' );
  fprintf ( 1, '  Define the data for the example in which a 60x60\n' );
  fprintf ( 1, '  rectangle is tiled by copies of a single hexomino.\n' );
%
%  Define the region R.
%
  r_m = 60;
  r_n = 60;
  r_shape = ones ( r_m, r_n );
%
%  Define the polyomino P.
%
  p = zeros ( 3, 3 );
  p(1,2) = 1;
  p(2,1:2) = 1;
  p(3,1:3) = 1;

  return
end
