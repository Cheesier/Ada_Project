-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package body Structures is

   procedure Add(S : in out Structure_Type; X, Y, Z : in Integer) is
   begin
      S.Data(X, Y, Z) := True;
   end Add;

   function Is_Occupied(S : in Structure_Type; X, Y, Z : in Integer) return Boolean is
   begin
      return S.Data(X, Y, Z);
   end Is_Occupied;

   procedure Parse_Structure(Str : in Unbounded_String; Struct : in out Structure_Type) is
      S :  String := To_String(Str);
      X : Integer := Struct.X;
      Y : Integer := Struct.Y;
      Z : Integer := Struct.Z;
   begin
      for I in 1..Z loop
         for J in 1..Y loop
            for K in 1..X loop
               if S(k + (j-1)*X) = '1' then
                  Add(Struct, K, J, I);
               end if;
            end loop;
         end loop;
         S(1..Length(Str)-X*Y+1) := Slice(Str, Y*X, Length(Str));
      end loop;
   end Parse_Structure;

   function Structure_To_String(Struct : in Structure_Type) return Unbounded_String is
      X : Integer := Struct.X;
      Y : Integer := Struct.Y;
      Z : Integer := Struct.Z;
      S : Unbounded_String;
   begin
      Append(S, Trim(Integer'Image(X), Ada.Strings.Left));
      Append(S, 'x');
      Append(S, Trim(Integer'Image(Y), Ada.Strings.Left));
      Append(S, 'x');
      Append(S, Trim(Integer'Image(Z), Ada.Strings.Left));
      Append(S, ' ');

      for I in 1..Z loop
         for J in 1..Y loop
            for K in 1..X loop
               if Is_Occupied(Struct, k, j, i) then
                  Append(S, '1');
               else
                  Append(S, '0');
               end if;
            end loop;
         end loop;
      end loop;
      return S;
   end;
end Structures;
