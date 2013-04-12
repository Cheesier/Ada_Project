-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------
with Ada.Strings; use Ada.Strings;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Coordinates; use Coordinates;
with Part; use Part;

package body Handler is

   procedure Put(H: in Handler_Access) is
   begin
      for I in 1..H.Parts'Length loop
         Put(H.Parts(I));
         New_Line;
      end loop;
   end Put;

   function Get_Result(H: in Handler_Access; Id: in Integer) return Unbounded_String is
      U: Unbounded_String;
   begin
      Append(U, Trim(To_Unbounded_String(Integer'Image(Id)), Ada.Strings.Left));
      for I in 1..H.Parts'Length loop
         Append(U, Get_Result(H.Parts(I)));
      end loop;
      return U;
   end Get_Result;

   function Parse_Figure(U: in Unbounded_String) return Part_Access is
      Str : Unbounded_String;
      C: Integer := Integer'Image(Get_Nr_Of_Parts(U))'Length+1;
   begin
      Str := To_Unbounded_String(Slice(U, C, Length(U)));
      return Parse_Figure_Part(Str);
   end Parse_Figure;

   procedure Solver(H: in out Handler_Access; Figure_String: in Unbounded_String; Solved: out Boolean) is
      Figure: Part_Access := Parse_Figure(Figure_String);
      Dim: Vec3 := Part.Get_Dimensions(Figure);
      Merged: array (1..H.Parts'Length) of Part_Access := (Others => new Part_Type(Dim.X, Dim.Y, Dim.Z));

      procedure Solver_Do(I: in Integer) is
         Colliding: Boolean := False;
         Has_Next_Pos: Boolean := True;
         
      begin
         if I > H.Parts'Length then -- Checks if it is solved
            Solved := True;
            return;
         end if;

         if I /= 1 then
            Empty(Merged(I));
            Part.Merge(Merged(I-1), Merged(I));
         end if;    

         loop
            if Fits_In(H.Parts(I), Figure) then
               if I /= 1 then
                  if Collides(Merged(I), H.Parts(I)) then
                     Colliding := True;
                  end if;
               end if;
            else
               Colliding := True;
            end if;

            if not Colliding then
               Part.Merge(H.Parts(I), Merged(I));

               Solver_Do(I + 1);
               Part.Subtract(H.Parts(I), Merged(I));
               if Solved then
                  return;
               end if;
            end if;

            Next_Pos(H.Parts(I), Figure, Has_Next_Pos);
            Colliding := False;
            if not Has_Next_Pos then
               Reset(H.parts(I));
               return;
            end if;

         end loop;
      end Solver_Do;

   begin
      Solved := False;
      if not Block_Check(H, Figure) then
         return;
      end if;
      for I in H.Parts'Range loop
         Reset(H.Parts(I)); -- Reset all the parts before we start
         Fix_Bounding(Merged(I));
      end loop;
      Solver_Do(1); -- Start at first part, and then dig in
   end Solver;

   function Block_Check(H: in Handler_Access; Figure: in Part_Access) return Boolean is
      Count: Integer := 0;
   begin
      for I in 1..H.Parts'Length loop
         Count := Count + Get_Nr_Of_Blocks(H.Parts(I));
      end loop;
      return Count = Get_Nr_Of_Blocks(Figure);
   end Block_Check;

   
   function Get_Nr_Of_Parts(S: in Unbounded_String) return Integer is
      Nr_Of_Fig :Unbounded_String;
      I: Integer := 2;
      E: Integer := 1;
      C: Character := Element(S, 1);
      Count: Integer;
   begin
      while C /= ' ' loop
         Append(Nr_Of_Fig, C);
         C := Element(S, I);
         I := I + 1;
         E:= E + 1;
      end loop;
      Count := Integer'Value(To_String(Nr_Of_Fig));
      return Count;
   end Get_Nr_Of_Parts;
   
   procedure Split_Part_String(H: in out Handler_Access; U: in Unbounded_String) is
      K: Integer := Integer'Image(Get_Nr_Of_Parts(U))'Length+1;
      IntString: String := "   ";
      S: String(1..Length(U));
      I: Integer := 2;
      E: Integer := 1;
      Start: Integer := 0;
      X, Y, Z : Integer;
      Str : Unbounded_String := To_Unbounded_String(Slice(U, K, Length(U)));
      C: Character := Element(Str, 1);
   begin
      S(1..Slice(U, K, Length(U))'Length) := Slice(U, K, Length(U));
      for K in 1..Get_Nr_Of_Parts(U) loop
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
         IntString := "   ";
         E := 1;
            
         H.Parts(K) := Parse_Part(To_Unbounded_String(Slice(Str, Start+1, I+X*Y*Z)));
         Start := I+X*Y*Z+1;
         I := I + X*Y*Z + 1;
      end loop;
   end Split_Part_String;
end Handler;