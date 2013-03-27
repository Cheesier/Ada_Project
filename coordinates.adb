-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Coordinates is

   function Min(A, B: in Integer) return Integer is
   begin
      if A < B then
         return A;
      else
         return B;
      end if;
   end Min;

   function Max(A, B: in Integer) return Integer is
   begin
      if A > B then
         return A;
      else
         return B;
      end if;
   end Max;

   procedure Put(Item: Vec3) is
   begin
      Put("(");
      Put(Item.X, 0);
      Put(",");
      Put(Item.Y, 0);
      Put(",");
      Put(Item.Z, 0);
      Put(")");
   end Put;

   procedure Put(Item: AABB) is
   begin
      Put(Item.Min);
      Put(Item.Max);
   end Put; 

   
   function Collides(A, B: in AABB) return Boolean is
   begin
      return 
        (A.Min.X < B.Max.X and A.Max.X > B.Min.X) and 
        (A.Min.Y < B.Max.Y and A.Max.Y > B.Min.Y) and 
        (A.Min.Z < B.Max.Z and A.Max.Z > B.Min.Z);
   end Collides;
   
   function Find_Overlap(A, B: in AABB) return AABB is
      Ret: AABB;
   begin
      Ret.Max.X := Min(A.Max.X, B.Max.X);
      Ret.Max.Y := Min(A.Max.Y, B.Max.Y);
      Ret.Max.Z := Min(A.Max.Z, B.Max.Z);

      Ret.Min.X := Max(A.Min.X, B.Min.X);
      Ret.Min.Y := Max(A.Min.Y, B.Min.Y);
      Ret.Min.Z := Max(A.Min.Z, B.Min.Z);

      return Ret;
   end Find_Overlap;
   
end Coordinates;
