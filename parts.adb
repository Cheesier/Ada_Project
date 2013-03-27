-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package body Parts is
<<<<<<< HEAD
   procedure Get_Dimensions(P: in Part_Type; X, Y, Z: out Integer) is
=======

   procedure Rotate_X(P : in out Part_Type) is
   begin
      Rotate_X(P.Structure);
   end Rotate_X;

   procedure Rotate_Y(P : in out Part_Type) is
   begin
      Rotate_Y(P.Structure);
   end Rotate_Y;

   procedure Rotate_Z(P : in out Part_Type) is
   begin
      Rotate_Z(P.Structure);
   end Rotate_Z;

   procedure Get_Dimensions(P : in Part_Type; X, Y, Z : out Integer) is
>>>>>>> Added Rotations for pieces
   begin
      X := P.X;
      Y := P.Y;
      Z := P.Z;
   end Get_Dimensions;
   
   procedure Move(P: in out Part_Type; X, Y, Z: in Integer) is
   begin
      P.Origin_Displacement.X := P.Origin_Displacement.X + X;
      P.Origin_Displacement.Y := P.Origin_Displacement.Y + Y;
      P.Origin_Displacement.Z := P.Origin_Displacement.Z + Z;
   end Move;
   
   function Collides(A, B: in Part_Type) return Boolean is
   begin
      if Coordinates.Collides(A.Bounding, B.Bounding) then
         -- find collide area
         -- bit by bit collision
         return True;
      else
         return False;
      end if;
   end Collides;

   function Parse_Part(Str: in Unbounded_String) return Part_Type is
      S: String := to_String(Str);
      X: Integer := Integer'Value(S(1..1));
      Y: Integer := Integer'Value(S(3..3));
      Z: Integer := Integer'Value(S(5..5));
      P: Part_Type(X, Y, Z);
   begin
      --Can we put the dimensions to the buffer?
      --P.Structure := Structure_Type(X, Y, Z);
      --Put(length(Str), 0);
      --Put(Slice(Str, 7, Length(Str)));
      S(1..Length(Str)-6) := Slice(Str, 7, Length(Str));
      Parse_Structure(To_Unbounded_String(S(1..Length(Str)-6)), P.Structure);
      Return(P);
   end Parse_Part;

   function Part_To_String(P: in Part_Type) return Unbounded_String is
      S: Unbounded_String;
   begin
      return Structure_To_String(P.Structure);
   end Part_To_String;

end Parts;
