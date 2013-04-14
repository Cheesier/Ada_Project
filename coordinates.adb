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

   ----

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

   ----

   function "="(Left, Right: in Vec3) return Boolean is
   begin
      return Left.X = Right.X and Left.Y = Right.Y and Left.Z = Right.Z;
   end "=";

   function "+"(Left, Right: in Vec3) return Vec3 is
   begin
      return Vec3'(Left.X + Right.X, Left.Y + Right.Y, Left.Z + Right.Z);
   end "+";

   function "+"(Left: in Vec3; Right: in Integer) return Vec3 is
   begin
      return Vec3'(Left.X + Right, Left.Y + Right, Left.Z + Right);
   end "+";

   function "-"(Left, Right: in Vec3) return Vec3 is
   begin
      return Vec3'(Left.X - Right.X, Left.Y - Right.Y, Left.Z - Right.Z);
   end "-";

   function "-"(Left: in AABB; Right: in Vec3) return AABB is
      Ret: AABB;
   begin
      Ret.Min := Left.Min - Right;
      Ret.Max := Left.Max - Right;
      return Ret;
   end "-";

   ----
   
   function Collides(A, B: in AABB) return Boolean is
   begin
      if A.Min.X <= B.Max.X then
         if A.Max.X >= B.Min.X then 
            if A.Min.Y <= B.Max.Y then
               if A.Max.Y >= B.Min.Y then
                  if A.Min.Z <= B.Max.Z then 
                     if A.Max.Z >= B.Min.Z then
                        return True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
      return False;
   end Collides;

   function Fits_In(A, B: in AABB) return Boolean is
   begin
      if A.Min.X >= B.Min.X then
         if A.Max.X <= B.Max.X then 
            if A.Min.Y >= B.Min.Y then
               if A.Max.Y <= B.Max.Y then
                  if A.Min.Z >= B.Min.Z then 
                     if A.Max.Z <= B.Max.Z then
                        return True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end if;
      return False;
   end Fits_In;
   
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
