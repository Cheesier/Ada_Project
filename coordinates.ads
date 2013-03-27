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
   
   type Vec3 is
      record
         X, Y, Z: Integer;
      end record;
   
   type Bounding_Box is
      record
         A: Vec3;
         B: Vec3;
      end record;

end Coordinates;
