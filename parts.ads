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

<<<<<<< HEAD
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
=======
--     procedure new_part(Z, Y, X : in Positive; P : out Part_Type);
   procedure Rotate_X(P : in out Part_Type);
   procedure Rotate_Y(P : in out Part_Type);
   procedure Rotate_Z(P : in out Part_Type);
--
--     procedure move_X(P : in out Part_Type; Steps : Integer);
--     procedure move_Y(P : in out Part_Type; Steps : Integer);
--     procedure move_Z(P : in out Part_Type; Steps : Integer);

   procedure Get_Dimensions(P : in Part_Type; X, Y, Z : out Integer);
   function Part_To_String(P : in Part_Type) return Unbounded_String;
   function Parse_Part(Str : in Unbounded_String) return Part_Type;
   --function movement_to_string(P : in Part) return String;
>>>>>>> Added Rotations for pieces
--     -- ^nothing to use?

--     procedure Reset(P: in out Part_Type); -Resets to initial position
--
   function Collides(A, B: in Part_Type) return Boolean;
--     function Fits_In(left, right: in Part_Type) return boolean;

private
   type Rot_Arr is
     array(1..3) of Natural;

<<<<<<< HEAD
   type Part_Type(X, Y, Z: Integer) is
      record
         Origin_Displacement: Vec3; -- starts zeroed
         Bounding: AABB; -- cache for Origin_Displacement
         Structure: Structure_Type(X, Y, Z);
         Rotations: Rot_Arr := (others => 0);
=======


   type Part_Type(X, Y, Z : Integer) is
      record
         OriginDisplacement : Vec3; -- starts zeroed
         Structure : Structure_Access := new Structure_Type(X, Y, Z);
         Rotations : Rot_Arr := (others => 0);
>>>>>>> Added Rotations for pieces
      end record;

end Parts;
