-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Structures;
with Coordinates;

package body Part is

   procedure Rotate_X(P: in out Part_Type) is
   begin
      Rotate_X(P.Structure);
      if P.Rotations(0) /= 3 then
         P.Rotations(0) := P.Rotations(0) + 1;
      else
         P.Rotations(0) := 0;
   end Rotate_X;

   procedure Rotate_Y(P: in out Part_Type) is
   begin
      Rotate_Y(P.Structure);
      if P.Rotations(1) /= 3 then
         P.Rotations(1) := P.Rotations(1) + 1;
      else
         P.Rotations(1) := 0;
   end Rotate_Y;

   procedure Rotate_Z(P: in out Part_Type) is
   begin
      Rotate_Z(P.Structure);
      if P.Rotations(3) /= 3 then
         P.Rotations(3) := P.Rotations(3) + 1;
      else
         P.Rotations(3) := 0;
   end Rotate_Z;

   procedure Get_Dimensions(U: in Unbounded_String; X, Y, Z, Len: out Integer) is
      C: Character := Element(U, 1);
      IntString: String := "   ";
      S: String := to_String(U);
      I: Integer := 2;
      E: Integer := 1;
   begin
      while C /= 'x' loop
      IntString(E) := C;
      C := S(I);
      I := I + 1;
      E := E + 1;
   end loop;
   X := Integer'Value(IntString(1..E-1));
   IntString := "   ";
   C := S(I);
   E := 1;
   while C /= 'x' loop
      IntString(E) := C;
      I := I + 1;
      E := E + 1;
      C := S(I);
   end loop;
   Y := Integer'Value(IntString(1..E-1));
   IntString := "   ";
   I := I + 1;
   C := S(I);
   E := 1;
   while C /= ' '  loop
      IntString(E) := C;
      I := I + 1;
      E := E + 1;
      C := S(I);
   end loop;
   Z := Integer'Value(IntString(1..E-1));
   Len := I;
   end Get_Dimensions;
   
   procedure Move(P: in out Part_Type; X, Y, Z: in Integer) is
   begin
      P.Origin_Displacement.X := P.Origin_Displacement.X + X;
      P.Origin_Displacement.Y := P.Origin_Displacement.Y + Y;
      P.Origin_Displacement.Z := P.Origin_Displacement.Z + Z;

      P.Bounding.Min := P.Origin_Displacement;
      P.Bounding.Max := Coordinates.Vec3'(P.X, P.Y, P.Z) + P.Origin_Displacement;
   end Move;
   
   function Collides(A, B: in Part_Type) return Boolean is
   begin
      if Coordinates.Collides(A.Bounding, B.Bounding) then
         return Structures.Collides(
                  A.Structure, 
                  B.Structure,
                  Coordinates.Find_Overlap(A.Bounding, B.Bounding),
                  Coordinates.Positive_1(A.Origin_Displacement - B.Origin_Displacement),
                  Coordinates.Positive_1(B.Origin_Displacement - A.Origin_Displacement));
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

      P.Bounding.Min := P.Origin_Displacement;
      P.Bounding.Max := Coordinates.Vec3'(P.X, P.Y, P.Z) + P.Origin_Displacement;

      Return(P);
   end Parse_Part;

   function Part_To_String(P: in Part_Type) return Unbounded_String is
      S: Unbounded_String;
   begin
      return Structure_To_String(P.Structure);
   end Part_To_String;

end Part;
