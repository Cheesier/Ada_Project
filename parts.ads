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

   type Part_Type(X, Y, Z: Integer) is private;

--     procedure new_part(Z, Y, X: in Positive; P: out Part_Type);
--     procedure rotate_X(P: in out Part_Type; Times: Positive);
--     procedure rotate_Y(P: in out Part_Type; Times: Positive);
--     procedure rotate_Z(P: in out Part_Type; Times: Positive);
--
   procedure Move(P: in out Part_Type; X, Y, Z: in Integer);

   procedure Get_Dimensions(P: in Part_Type; X, Y, Z: out Integer);
   function Part_To_String(P: in Part_Type) return Unbounded_String;
   function Parse_Part(Str: in Unbounded_String) return Part_Type;
   --function movement_to_string(P: in Part) return String;
--     -- ^nothing to use?

--     procedure Reset(P: in out Part_Type); -Resets to initial position
--
   function Collides(A, B: in Part_Type) return Boolean;
--     function Fits_In(left, right: in Part_Type) return boolean;

private
   type range_0_3 is range 0..3;
   type Rot_Arr is array(1..3) of range_0_3;

   type Part_Type(X, Y, Z: Integer) is
      record
         Origin_Displacement: Vec3; -- starts zeroed
         Bounding: AABB; -- cache for Origin_Displacement
         Structure: Structure_Type(X, Y, Z);
         Rotations: Rot_Arr := (others => 0);
      end record;

end Parts;
