-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package Structures is
   type Structure_Type(X, Y, Z : Positive) is private;

   procedure rotate_X(S : in out Structure_Type; Times : Positive);
   procedure rotate_Y(S : in out Structure_Type; Times : Positive);
   procedure rotate_Z(S : in out Structure_Type; Times : Positive);

   --Coordinates borde byta namn till Point3D eller liknande.
   function collides(a, b : in Part; Displacement : in Coordinates);
   function get_dimensions(S : in Structure_Type) return Coordinates;
   function structure_to_string(S : in Structure_Type) return String;

private
   type Structure_Type(X, Y, Z : Positive) is
      record
         -- ineffektiv, men är en start
         Data : array(1..X, 1..Y, 1..Z) of Boolean;
      end record;
end Structures;
