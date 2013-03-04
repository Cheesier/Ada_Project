-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Structures; use Structures;

package Parts is

   type Part(Z, Y, X : Positive) is private;

   procedure new_part(Z, Y, X : in Positive; P : out Part);
   procedure rotate_X(P : in out Part; Times : Positive);
   procedure rotate_Y(P : in out Part; Times : Positive);
   procedure rotate_Z(P : in out Part; Times : Positive);

   procedure move_X(P : in out Part; Steps : Integer);
   procedure move_Y(P : in out Part; Steps : Integer);
   procedure move_Z(P : in out Part; Steps : Integer);

   function get_dimensions(P : in Part) return String;
   function to_string(P : in Part) return String;
   --function movement_to_string(P : in Part) return String;

   procedure reset(P : in out Part); --Flyttar tillbaka till ursprungsläget

   function collides(a, b : in Part) return boolean;
   function fits_in(left, right : in Part) return boolean;

private
   type Part(Data : String) is
      record
         OriginDisplacement : Coordinates; -- starts zeroed
         Structure : Structure_Type;
         Rotations : array(1..3) of Natural := (others => 0);
      end record;

end Parts;
