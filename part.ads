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

package Part is
   type Part_Type(X, Y, Z: Integer) is private;
   type Part_Access is
      access Part_Type;
   procedure Move(P: in out Part_Type; X, Y, Z: in Integer);

   procedure Get_Dimensions(U: in Unbounded_String; X, Y, Z, Len: out Integer);
   function Part_To_String(P: in Part_Type) return Unbounded_String;
   function Parse_Part(Str: in Unbounded_String) return Part_Type;
   --function movement_to_string(P: in Part) return String;

   procedure Rotate_X(P : in out Part_Type);
   procedure Rotate_Y(P : in out Part_Type);
   procedure Rotate_Z(P : in out Part_Type);

   function Collides(A, B: in Part_Type) return Boolean;
--     function Fits_In(left, right: in Part_Type) return boolean;

private
   type range_0_3 is range 0..3;
   type Rot_Arr is array(1..3) of range_0_3;

   type Part_Type(X, Y, Z: Integer) is
      record
         Origin_Displacement: Vec3; -- starts zeroed
         Bounding: AABB; -- cache for Origin_Displacement
         Structure: Structure_Access := new Structure_Type(X, Y, Z);
         Rotations: Rot_Arr := (others => 0);
      end record;

end Part;
