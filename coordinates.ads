package Coordinates is
   type Coord_Pair is
      record
         x, y, z : Positive;
      end record;

   function collides(a, b : in Coord_Pair) return Boolean;

end Coordinates;
