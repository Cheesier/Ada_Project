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
with Coordinates; use Coordinates;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package Parts is

   type Part_Type(X, Y, Z : Integer) is private;

--     procedure new_part(Z, Y, X : in Positive; P : out Part_Type);
--     procedure rotate_X(P : in out Part_Type; Times : Positive);
--     procedure rotate_Y(P : in out Part_Type; Times : Positive);
--     procedure rotate_Z(P : in out Part_Type; Times : Positive);
--
--     procedure move_X(P : in out Part_Type; Steps : Integer);
--     procedure move_Y(P : in out Part_Type; Steps : Integer);
--     procedure move_Z(P : in out Part_Type; Steps : Integer);

   procedure get_dimensions(P : in Part_Type; X, Y, Z : out Integer);
   function Part_To_String(P : in Part_Type) return Unbounded_String;
   function Parse_Part(Str : in Unbounded_String) return Part_Type;
   --function movement_to_string(P : in Part) return String;
--     -- ^nothing to use?

--     procedure reset(P : in out Part_Type); --Resets to initial position
--
--     function collides(a, b : in Part_Type) return boolean;
--     function fits_in(left, right : in Part_Type) return boolean;

private
   type Rot_Arr is
     array(1..3) of Natural;

   type Part_Type(X, Y, Z : Integer) is
      record
         OriginDisplacement : Vec3; -- starts zeroed
         Structure : Structure_Type(X, Y, Z);
         Rotations : Rot_Arr := (others => 0);
      end record;

end Parts;
