-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Ther�n,     oskth878
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
      access all Part_Type;
   procedure Move(P: in out Part_Type; X, Y, Z: in Integer);

   procedure Put(P: in Part_Access);
   procedure Get_Dimensions(U: in Unbounded_String; X, Y, Z, Len: out Integer);
   function Get_Dimensions(P: in Part_Access) return Vec3;   
   function Part_To_String(P: in Part_Access) return Unbounded_String;
   function Parse_Part(Str: in Unbounded_String) return Part_Access;
   function Get_Nr_Of_Blocks(P: in Part_Access) return Integer;
   procedure Next_Pos(Fig: in Part_Access; Part: in out Part_Access; B: out Boolean);
   --function movement_to_string(P: in Part) return String;

   procedure Rotate_X(P : in out Part_Access);
   procedure Rotate_Y(P : in out Part_Access);
   procedure Rotate_Z(P : in out Part_Access);

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
