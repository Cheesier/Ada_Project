-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package Coordinates is
	-- should be bounding box, and contain 2 coordinates
   type Coord_Pair is
      record
         x, y, z : Positive;
      end record;

   -- same change should be done here
   function collides(a, b : in Coord_Pair) return Boolean;

end Coordinates;
