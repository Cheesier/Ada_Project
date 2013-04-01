-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Coordinates;

package body Structures is


   procedure Rotate_X(S : in out Structure_Access) is
      Temp : Structure_Access := new Structure_Type(S.X, S.Z, S.Y);
   begin
      for X in 1..S.X loop
         for Y in reverse 1..S.Y loop
            for Z in 1..S.Z loop
               if(Is_Occupied(S, X, Y, Z)) then
                  add(Temp, X, Z, S.Y-Y+1);
               end if;
            end loop;
         end loop;
      end loop;
      Free(S);
      S := Temp;
   end Rotate_X;

   procedure Rotate_Y(S: in out Structure_Access) is
      Temp : Structure_Access := new Structure_Type(S.Z, S.Y, S.X);
   begin
      for X in 1..S.X loop
         for Y in 1..S.Y loop
            for Z in reverse 1..S.Z loop
               if(Is_Occupied(S, X, Y, Z)) then
                  add(Temp, S.Z-Z+1, Y, X);
               end if;
            end loop;
         end loop;
      end loop;
      Free(S);
      S := Temp;
   end Rotate_Y;

   function Get_Dimensions(S: in Structure_Access) return Vec3 is
   begin
      return Vec3'(S.X, S.Y, S.Z);
   end Get_Dimensions;

   procedure Rotate_Z(S: in out Structure_Access) is
      Temp : Structure_Access := new Structure_Type(S.Y, S.X, S.Z);  
   begin
      for X in reverse 1..S.X loop
         for Y in 1..S.Y loop
            for Z in 1..S.Z loop
               if(Is_Occupied(S, X, Y, Z)) then
                  add(Temp, Y, S.X-X+1, Z);
               end if;
            end loop;
         end loop;
      end loop;
      Free(S);
      S := Temp;
   end Rotate_Z;

   function Get_Nr_Of_Blocks(S: in Structure_Access) return Integer is
      Count: Integer := 0;
   begin
      for X in 1..S.X loop
         for Y in 1..S.Y loop
            for Z in 1..S.Z loop
               if Is_Occupied(S, X, Y, Z) then
                  Count := Count + 1;
               end if;
            end loop;
         end loop;
      end loop;
      return Count;
   end Get_Nr_Of_Blocks;

   procedure Add(S: in out Structure_Access; X, Y, Z: in Integer) is
   begin
      S.Data(X, Y, Z) := True;
   end Add;

   function Is_Occupied(S: in Structure_Access; X, Y, Z: in Integer) return Boolean is
   begin
      Put(Vec3'(X, Y, Z));
      Put(Get_Dimensions(S)); New_Line;
      return S.Data(X, Y, Z);
   end Is_Occupied;

   function Is_Occupied(S: in Structure_Access; X, Y, Z: in Integer; D: in Vec3) return Boolean is
   begin
      return Is_Occupied(S, X-D.X, Y-D.Y, Z-D.Z);
   end Is_Occupied;

   function Collides(A, B: in Structure_Access; Overlap: in AABB; Da, Db: in Vec3) return Boolean is
   begin
      New_Line;Put_Line("Collides");
      for X in Overlap.Min.X..Overlap.Max.X loop
         for Y in Overlap.Min.Y..Overlap.Max.Y loop
            for Z in Overlap.Min.Z..Overlap.Max.Z loop
               if Is_Occupied(A, X, Y, Z, Da) and Is_Occupied(B, X, Y, Z, Db) then
                  return True;
               end if;
               New_Line;
            end loop;
         end loop;
      end loop;
      return False;
   end Collides;

   function Fits_Inside(A, B: in Structure_Access; Overlap: in AABB; D: in Vec3) return Boolean is
   begin
      New_Line;Put_Line("Fits_In");
      for X in Overlap.Min.X..Overlap.Max.X loop
         for Y in Overlap.Min.Y..Overlap.Max.Y loop
            for Z in Overlap.Min.Z..Overlap.Max.Z loop
               if Is_Occupied(A, X, Y, Z, D) and not Is_Occupied(B, X, Y, Z) then
                  return False;
               end if;
            end loop;
         end loop;
      end loop;
      return True;
   end Fits_Inside;

   procedure Parse_Structure(Str : in Unbounded_String; Struct : in out Structure_Access) is
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
         S(1..Length(Str)-X*Y*I) := Slice(Str, Y*X*I+1, Length(Str));
      end loop;
   end Parse_Structure;

   function Structure_To_String(Struct : in Structure_Access) return Unbounded_String is
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

   procedure Free_Memory(S: in out Structure_Access) is
   begin
      Free(S);
   end Free_Memory;
  
end Structures;
