-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package Coordinates is
   
   type Vec3 is
      record
         X, Y, Z: Integer := 0;
      end record;
   
   type AABB is
      record
         Min: Vec3 := Vec3'(1, 1, 1);
         Max: Vec3 := Vec3'(1, 1, 1);
      end record;

   procedure Put(Item: Vec3);
   procedure Put(Item: AABB);

   function Min(A, B: in Integer) return Integer;--Added in .ads
   function Max(A, B: in Integer) return Integer;--Added in .ads

   function "="(Left, Right: in Vec3) return Boolean; --Added in .ads
   function "+"(Left, Right: in Vec3) return Vec3;
   function "+"(Left: in Vec3; Right: in Integer) return Vec3;
   function "-"(Left, Right: in Vec3) return Vec3;
   function "-"(Left: in AABB; Right: in Vec3) return AABB;
   
   function Collides(A, B: in AABB) return Boolean;
   function Fits_In(A, B: in AABB) return Boolean;
   function Find_Overlap(A, B: in AABB) return AABB;
   
end Coordinates;
