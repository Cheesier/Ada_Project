-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------
with Coordinates; use Coordinates;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Deallocation;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Structures is
   type Structure_Type(iX, iY, iZ : Positive) is private;
   type Structure_Access is access Structure_Type;

   procedure Rotate_X(S: in out Structure_Access);
   procedure Rotate_Y(S: in out Structure_Access);
   procedure Rotate_Z(S: in out Structure_Access);

   function Collides(A, B: in Structure_Access; Overlap: in AABB; Da, Db: in Vec3) return Boolean;
   function Fits_Inside(A, B: in Structure_Access; Overlap: in AABB; Da, Db: in Vec3) return Boolean;
--
--     function collides(a, b : in Structure_Type; Displacement : in Vec3) return boolean;
--     function get_dimensions(S : in Structure_Type) return Vec3;
--     -- ^ Needs to return a pair of Vec3! ^
--     function structure_to_string(S : in Structure_Type) return String;
   procedure Add(S: in out Structure_Access; X,Y,Z: in Integer);
   function Is_Occupied(S: in Structure_Access; X,Y,Z: in Integer) return Boolean;
   procedure Parse_Structure(Str: in Unbounded_String; Struct: in out Structure_Access);
   function Structure_To_String(Struct: in Structure_Access) return Unbounded_String;
private
   type Test_Arr is
     array(Integer range <>, Integer range <>, Integer range <>) of Boolean;
   type Structure_Type(iX, iY, iZ : Positive) is
      record
         -- ineffective, but it's a start
         X : Integer := iX;
         Y : Integer := iY;
         Z : Integer := iZ;
         Data : Test_Arr(1..iX, 1..iY, 1..iZ) := (others => (others =>(others => false)));
      end record;

   procedure Free is new Ada.Unchecked_Deallocation
     (Object => Structure_Type, Name => Structure_Access);
end Structures;
