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
         X, Y, Z: Integer;
      end record;
   
   type AABB is
      record
         Min: Vec3;
         Max: Vec3;
      end record;
   
   function Collides(A, B: in AABB) return Boolean;
   function Find_Overlap(A, B: in AABB) return AABB;
   procedure Put(Item: AABB);
   procedure Put(Item: Vec3);
   
end Coordinates;
