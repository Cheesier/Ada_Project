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
      access all Part_Type;
   procedure Move(P: in out Part_Access; X, Y, Z: in Integer);

   procedure Put_Bounding(P: in Part_Access);
   procedure Put_Visual(P: in Part_Access);
   function Get_Result(P: in Part_Access) return Unbounded_String;
   procedure Rotate_Next(P: in out Part_Access; B: out Boolean);
   procedure Reset(P: in out Part_Access);
   procedure Reset_Rotations(P: in out Part_Access);
   procedure Put(P: in Part_Access);
   procedure Get_Dimensions(U: in Unbounded_String; X, Y, Z, Len: out Integer);
   function Get_Dimensions(P: in Part_Access) return Vec3;   
   function Part_To_String(P: in Part_Access) return Unbounded_String;
   function Parse_Part(Str: in Unbounded_String) return Part_Access;
   function Parse_Figure_Part(Str: in Unbounded_String) return Part_Access;
   procedure Fix_Bounding(P: in out Part_Access);
   function Get_Nr_Of_Blocks(P: in Part_Access) return Integer;
   procedure Next_Pos(Part: in out Part_Access; Fig: in Part_Access; B: out Boolean);

   function Collides(A, B: in Part_Access) return Boolean;
   function Fits_In(A, B: in Part_Access) return boolean;
   procedure Empty(P: in Part_Access);
   procedure Merge(A: in Part_Access; B: in out Part_Access);
   procedure Subtract(A: in Part_Access; B: in out Part_Access);

private
   procedure Rotate(P: in out Part_Access; X, Y, Z: in Integer);
   procedure Rotate_X_Internal(P: in out Part_Access);
   procedure Rotate_Y_Internal(P: in out Part_Access);
   procedure Rotate_Z_Internal(P: in out Part_Access);

   function Exists_In_Unique_Rotations(S: in Structure_Access; P: in Part_Access) return Boolean;
   procedure Find_Unique_Rotations(P: in out Part_Access);

   type Unique_Rotation_Arr is array(1..24) of Structure_Access;
   type Unique_Rotation_Pattern is array(1..24) of Vec3;

   type Part_Type(X, Y, Z: Integer) is
      record
         Origin_Displacement: Vec3; -- starts zeroed
         Bounding: AABB; -- cache for Origin_Displacement
         Structure: Structure_Access := new Structure_Type(X, Y, Z);

         -- New rotation system
         Unique_Rotations: Unique_Rotation_Arr;
         Rotation_Pattern: Unique_Rotation_Pattern;
         Unique_Count: Integer := 0;
         Current_Rotation: Integer := 1;
      end record;

end Part;
