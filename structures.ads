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
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Structures is
   type Structure_Type(iX, iY, iZ : Positive) is private;

--     procedure rotate_X(S : in out Structure_Type; Times : Positive);
--     procedure rotate_Y(S : in out Structure_Type; Times : Positive);
--     procedure rotate_Z(S : in out Structure_Type; Times : Positive);
--
--     function collides(a, b : in Structure_Type; Displacement : in Vec3) return boolean;
--     function get_dimensions(S : in Structure_Type) return Vec3;
--     -- ^ Needs to return a pair of Vec3! ^
--     function structure_to_string(S : in Structure_Type) return String;
   procedure Add(S : in out Structure_Type; X,Y,Z : in Integer);
   function Is_Occupied(S : in Structure_Type; X,Y,Z : in Integer) return Boolean;
   procedure Parse_Structure(Str : in Unbounded_String; Struct : in out Structure_Type);
   function Structure_To_String(Struct : in Structure_Type) return Unbounded_String;
private
   type Test_Arr is
     array(Integer range <>, Integer range <>, Integer range<>) of Boolean;
   type Structure_Type(iX, iY, iZ : Positive) is
      record
         -- ineffective, but it's a start
         X : Integer := iX;
         Y : Integer := iY;
         Z : Integer := iZ;
         Data : Test_Arr(1..iX, 1..iY, 1..iZ) := (others => (others =>(others => false)));
      end record;
end Structures;
