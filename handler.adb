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

package body Handler is

   procedure Put(H: in Handler_Type) is
   begin
      for I in 1..H.Parts'Length loop
         Put(H.Parts(I));
         New_Line;
      end loop;
   end Put;

   function Get_Result(H: in Handler_Type) return Unbounded_String is
      U: Unbounded_String;
   begin
      Append(U, Trim(To_Unbounded_String(Integer'Image(H.Id)), Ada.Strings.Left));
      for I in 1..H.Parts'Length loop
         Append(U, Get_Result(H.Parts(I)));
      end loop;
      return U;
   end Get_Result;

   function Parse_Figure(U: in Unbounded_String) return Part_Access is
   begin
      return Parse_Part(U);
   end Parse_Figure;

   procedure Solver(H: in out Handler_Type; Bool: out Boolean) is
      B: Boolean := True;
      Solved: Boolean := False;
      I: Integer := 1;
   begin
      Put("Length: "); Put(H.Parts'Length); New_Line;
      if not Block_Check(H) then
         Bool := False;
         Put_Line("The Number of blocks does not match!");
         return;
      end if;
      while I <= H.Parts'Length loop
         if not Fits_In(H.Parts(I), H.Figure) then
            Put("I: "); Put(I, 0);
            Next_Pos(H.Parts(I), H.Figure, B);
            I := I - 1;
            Put("Gick in i not Fits_In");
            if not B and I /= 1 then
               I := I - 2;
            elsif not B then
               exit;
            end if;
         else
            for J in 1..I-1 loop
               Put("For-loopen"); New_Line;
               if Collides(H.Parts(J), H.Parts(I)) then
                  Next_Pos(H.Parts(I), H.Figure, B);
                  I := I - 1;
                  Put("Collides, exit"); New_Line;
                  exit;
               end if;
            end loop;
            if B then
               Put("True"); New_Line;
            else
               Put("False"); New_Line;
            end if;
            if not B and I /= 1 then
               I := I - 2;
            elsif not B then
               exit;
            end if;
            Put("Gick past if not B"); New_Line;
         end if;
         I := I + 1;
      end loop;
      Bool := B;
   end Solver;

   function Block_Check(H: in Handler_Type) return Boolean is
      Count: Integer := 0;
   begin
      for I in 1..H.Parts'Length loop
         Count := Count + Get_Nr_Of_Blocks(H.Parts(I));
      end loop;
      return Count = Get_Nr_Of_Blocks(H.Figure);
   end Block_Check;

   procedure Split_Part_String(H: in out Handler_Type; U: in Unbounded_String) is
      IntString: String := "   ";
      S: String := To_String(U);
      I: Integer := 2;
      E: Integer := 1;
      Start: Integer := 0;
      X, Y, Z, Count: Integer;
      C: Character := Element(U, 1);
   begin
      while C /= ' ' loop
         IntString(E) := C;
         C := S(I);
         I := I + 1;
         E:= E + 1;
      end loop;
      Count := Integer'Value(IntString(1..E-1));
      IntString := "   ";
      Start := E;
      E := 1;
      
      for K in 1..Count loop
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
            
         H.Parts(K) := Parse_Part(To_Unbounded_String(Slice(U, Start+1, I+X*Y*Z)));
         Start := I+X*Y*Z+1;
         I := I + X*Y*Z + 1;
      end loop;
   end Split_Part_String;
end Handler;