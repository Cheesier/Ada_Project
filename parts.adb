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
   procedure Get_Dimensions(P : in Part_Type; X, Y, Z : out Integer) is
   begin
      X := P.X;
      Y := P.Y;
      Z := P.Z;
   end Get_Dimensions;

   function Parse_Part(Str : in Unbounded_String) return Part_Type is
      S : String := to_String(Str);
      X : Integer := Integer'Value(S(1..1));
      Y : Integer := Integer'Value(S(3..3));
      Z : Integer := Integer'Value(S(5..5));
      P : Part_Type(X, Y, Z);
   begin
      --Can we put the dimensions to the buffer?
      --P.Structure := Structure_Type(X, Y, Z);
      --Put(length(Str), 0);
      --Put(Slice(Str, 7, Length(Str)));
      S(1..Length(Str)-6) := Slice(Str, 7, Length(Str));
      Parse_Structure(To_Unbounded_String(S(1..Length(Str)-6)), P.Structure);
      Return(P);
   end Parse_Part;

   function Part_To_String(P : in Part_Type) return Unbounded_String is
      S : Unbounded_String;
   begin
      return Structure_To_String(P.Structure);
   end Part_To_String;

end Parts;
