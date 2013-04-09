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
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Part is

   procedure Put_Bounding(P: in Part_Access) is
   begin
      Put(P.Bounding);
   end Put_Bounding;

   procedure Put_Visual(P: in Part_Access) is
   begin
      Put_Visual(P.Structure);
   end Put_Visual;
   
   procedure Put(P: in Part_Access) is
   begin
      Put(Part_To_String(P));
      New_Line;
      Put("Orgin_displacement: "); Coordinates.Put(P.Origin_Displacement);
      New_Line;
      Put("Bounding_Box: "); Coordinates.Put(P.Bounding);
      New_Line;
      Put("Rotations: "); Put(P.Rotations(1), 0); Put(" ");
      Put(P.Rotations(2), 0); Put(" "); Put(P.Rotations(3), 0);
      New_Line;
      Put("---------------------------");
   end Put;

   function Equals(Left, Right: in Part_Access) return Boolean is
   begin
      return Equals(Left.Structure, Right.Structure);
   end Equals;
   
   function Get_Result(P: in Part_Access) return Unbounded_String is
      U: Unbounded_String;
   begin
      Append(U, " !");
      Put(P);
      for I in 1..3 loop
      --    if I = 2 then
      --       Append(U, Integer'Image(3-P.Rotations(I)));
      --    else
            Append(U, Integer'Image(P.Rotations(I)));
      --    end if;
      end loop;
      Append(U, Integer'Image(P.Origin_Displacement.X));
      Append(U, Integer'Image(P.Origin_Displacement.Y));
      Append(U, Integer'Image(P.Origin_Displacement.Z));
      return U;
   end Get_Result;

   procedure Rotate_X_Internal(P: in out Part_Access) is
   begin
      Rotate_X(P.Structure);
      if P.Rotations(1) /= 3 then
         P.Rotations(1) := P.Rotations(1) + 1;
      else
         P.Rotations(1) := 0;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
   end Rotate_X_Internal;

   procedure Rotate_Y_Internal(P: in out Part_Access) is
   begin
      Rotate_Y(P.Structure);
      if P.Rotations(2) /= 3 then
         P.Rotations(2) := P.Rotations(2) + 1;
      else
         P.Rotations(2) := 0;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
   end Rotate_Y_Internal;

   procedure Rotate_Z_Internal(P: in out Part_Access) is
   begin
      Rotate_Z(P.Structure);
      if P.Rotations(3) /= 3 then
         P.Rotations(3) := P.Rotations(3) + 1;
      else
         P.Rotations(3) := 0;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
   end Rotate_Z_Internal;

   procedure Rotate_X(P: in out Part_Access) is
   begin
      if P.Rotations(1) = 3 then
         P.Structure := P.Rotation_Cache(0, P.Rotations(2), P.Rotations(3));
         P.Rotations(1) := 0;
      else
         P.Structure := P.Rotation_Cache(P.Rotations(1)+1, P.Rotations(2), P.Rotations(3));
         P.Rotations(1) := P.Rotations(1) + 1;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
   end Rotate_X;

   procedure Rotate_Y(P: in out Part_Access) is
   begin
      if P.Rotations(2) = 3 then
         P.Structure := P.Rotation_Cache(P.Rotations(1), 0, P.Rotations(3));
         P.Rotations(2) := 0;
      else
         P.Structure := P.Rotation_Cache(P.Rotations(1), P.Rotations(2)+1, P.Rotations(3));
         P.Rotations(2) := P.Rotations(2) + 1;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
   end Rotate_Y;

   procedure Rotate_Z(P: in out Part_Access) is
   begin
      if P.Rotations(3) = 3 then
         P.Structure := P.Rotation_Cache(P.Rotations(1), P.Rotations(2), 0);
         P.Rotations(3) := 0;
      else
         P.Structure := P.Rotation_Cache(P.Rotations(1), P.Rotations(2), P.Rotations(3)+1);
         P.Rotations(3) := P.Rotations(3) + 1;
      end if;
      P.Bounding.Max := P.Origin_Displacement + Get_Dimensions(P.Structure);
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
   
   procedure Move(P: in out Part_Access; X, Y, Z: in Integer) is
   begin
      P.Origin_Displacement.X := P.Origin_Displacement.X + X;
      P.Origin_Displacement.Y := P.Origin_Displacement.Y + Y;
      P.Origin_Displacement.Z := P.Origin_Displacement.Z + Z;

      P.Bounding.Min := P.Origin_Displacement + 1;
      P.Bounding.Max := Get_Dimensions(P) + P.Origin_Displacement;
   end Move;
   
   function Collides(A, B: in Part_Access) return Boolean is
   begin      
      if Coordinates.Collides(A.Bounding, B.Bounding) then
         return Structures.Collides(
                  A.Structure,
                  B.Structure,
                  Coordinates.Find_Overlap(A.Bounding, B.Bounding),
                  A.Origin_Displacement,
                  B.Origin_Displacement);
      else
         return False;
      end if;
   end Collides;

   function Fits_In(A, B: in Part_Access) return Boolean is
   begin
      if Coordinates.Fits_In(A.Bounding, B.Bounding) then
         return Structures.Fits_Inside(
                                 A.Structure,
                                 B.Structure,
                                 A.Bounding,
                                 A.Origin_Displacement);
      else
         return False;
      end if;
   end Fits_In;

   procedure Cache_Rotations(P: in out Part_Access) is
   begin
      for X in 0..3 loop
         for Y in 0..3 loop
            for Z in 0..3 loop
               Rotate(P, X, Y, Z);
               Copy(P.Structure, P.Rotation_Cache(X, Y, Z));
            end loop;
         end loop;
      end loop;
   end Cache_Rotations;

   function Parse_Part(Str: in Unbounded_String) return Part_Access is
      S: String := to_String(Str);
      X, Y, Z, Len: Integer;
      P: Part_Access;
      Temp: Structure_Access;
   begin
      Get_Dimensions(Str, X, Y, Z, Len);
      P := new Part_Type(X, Y, Z);
      S(1..Length(Str)-Len) := Slice(Str, Len+1, Length(Str));
      Parse_Structure(To_Unbounded_String(S(1..Length(Str)-Len)), P.Structure);
      Parse_Structure(To_Unbounded_String(S(1..Length(Str)-Len)), P.Start_Struct);

      Fix_Bounding(P);

      P.Rotation_Cache(0, 0, 0) := new Structure_Type(X, Y, Z);
      P.Rotation_Cache(0, 0, 0).all := P.Structure.all;
      Cache_Rotations(P);
      Reset(P);

      Return(P);
   end Parse_Part;

   -- function Exists_In_Cache(S: in Structure_Access; P: in Part_Access) return Boolean is
   -- begin
   --    for X in Xa..3 loop
   --       for Y in Ya..3 loop
   --          for Z in Za+1..3 loop
   --             if S = P.Rotation_Cache(X, Y, Z) and then Equals(S, P.Rotation_Cache(X, Y, Z)) then
   --                return True;
   --             end if;
   --          end loop;
   --       end loop;
   --    end loop;
   --    return False;
   -- end Exists_In_Cache;

   -- function Exists_In_Unique_Rotations(S: in Structure_Access; P: in Part_Access) return Boolean is
   -- begin
   --    for I in 1..P.Unique_Rotations loop
   --       if Equals(S, P.Unique_Rotations(I)) then
   --          return True;
   --       end if;
   --       return False;
   --    end loop;
   -- end Exists_In_Unique_Rotations;

   -- procedure Find_Unique_Rotations(P: in Part_Access) is
   --    D: Get_Dimensions(P);
   -- begin
   --    for X in 0..3 loop
   --       for Y in 0..3 loop
   --          for Z in 0..3 loop
   --             null;
   --          end loop;
   --       end loop;
   --    end loop;
   -- end Find_Unique_Rotations;

   function Get_Dimensions(P: in Part_Access) return Vec3 is
   begin
      return Structures.Get_Dimensions(P.Structure);
   end Get_Dimensions;

   function Get_Nr_Of_Blocks(P: in Part_Access) return Integer is
   begin
      return Get_Nr_Of_Blocks(P.Structure);
   end Get_Nr_Of_Blocks;

   function Part_To_String(P: in Part_Access) return Unbounded_String is
      S: Unbounded_String;
   begin
      return Structure_To_String(P.Structure);
   end Part_To_String;

   procedure Fix_Bounding(P: in out Part_Access) is
      D: Vec3 := Get_Dimensions(P);
   begin
      P.Bounding.Min := P.Origin_Displacement + 1;
      P.Bounding.Max := Coordinates.Vec3'(D.X, D.Y, D.Z) + P.Origin_Displacement;
   end Fix_Bounding;

   procedure Reset(P: in out Part_Access) is
   begin
      Reset_Rotations(P);
      P.Origin_Displacement := Vec3'(0, 0, 0);
      P.Bounding := AABB'(Vec3'(1, 1, 1), Get_Dimensions(P));
   end Reset;

   procedure Reset_Rotations(P: in out Part_Access) is
      dim: Vec3 := Get_Dimensions(P.Start_Struct);
   begin
      P.Structure := P.Rotation_Cache(0, 0, 0);
      P.Rotations := (others => 0);
   end Reset_Rotations;

   procedure Reset_Rotations_Internal(P: in out Part_Access) is
      dim: Vec3 := Get_Dimensions(P.Start_Struct);
   begin
      Copy(P.Rotation_Cache(0, 0, 0), P.Structure);
      P.Rotations := (others => 0);
   end Reset_Rotations_Internal;

   procedure Rotate(P: in out Part_Access; X, Y, Z: in Integer) is
   begin
      Reset_Rotations_Internal(P);
      for i in 1..X loop
         Rotate_X_Internal(P);
      end loop;
      for i in 1..Y loop
         Rotate_Y_Internal(P);
      end loop;
      for i in 1..Z loop
         Rotate_Z_Internal(P);
      end loop;
   end Rotate;

   procedure Rotate_Next(P: in out Part_Access; B: out Boolean) is
   begin
      if P.Rotations(3) < 3 then
         Rotate_Z(P);
      else
         Rotate_Z(P);
         if P.Rotations(2) < 3 then
            Rotate_Y(P);
         else
            Rotate_Y(P);
            if P.Rotations(1) < 3 then
               Rotate_X(P);
            else
               Rotate_X(P);
               B := False;
               return;
            end if;
         end if;
      end if;
      B := True;
   end Rotate_Next;

   procedure Next_Pos(Part: in out Part_Access; Fig: in Part_Access; B: out Boolean) is
      Part_Dim: Vec3 := Get_Dimensions(Part);
      Fig_Dim: Vec3 := Get_Dimensions(Fig);
   begin
      if Part.Origin_Displacement.X + Part_Dim.X < Fig_Dim.X then
         Move(Part, 1, 0, 0);
      else
         Move(Part, -Part.Origin_Displacement.X, 0, 0);
         if Part.Origin_Displacement.Y + Part_Dim.Y < Fig_Dim.Y then
            Move(Part, 0, 1, 0);
         else
            Move(Part, 0, -Part.Origin_Displacement.Y, 0);
            if Part.Origin_Displacement.Z + Part_Dim.Z < Fig_Dim.Z then
               Move(Part, 0, 0, 1);
            else
               Move(Part, 0, 0, -Part.Origin_Displacement.Z);
               Rotate_Next(Part, B);
               if not B then
                  return;
               end if;
            end if;
         end if;
      end if;
      B:= True;
   end Next_Pos;

   procedure Empty(P: in Part_Access) is
   begin
      Empty(P.Structure);
   end Empty;

   procedure Merge(A: in Part_Access; B: in out Part_Access) is
   begin
      Merge(A.Structure, A.Origin_Displacement, B.Structure);
   end Merge;

   procedure Subtract(A: in Part_Access; B: in out Part_Access) is
   begin
      Subtract(A.Structure, A.Origin_Displacement, B.Structure);
   end Subtract;

end Part;
