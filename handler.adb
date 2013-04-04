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

   procedure Put(H: in Handler_Access) is
   begin
      for I in 1..H.Parts'Length loop
         Put(H.Parts(I));
         New_Line;
      end loop;
   end Put;

   function Get_Result(H: in Handler_Access) return Unbounded_String is
      U: Unbounded_String;
   begin
      Append(U, Trim(To_Unbounded_String(Integer'Image(H.Id)), Ada.Strings.Left));
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
      return Parse_Part(Str);
   end Parse_Figure;

   procedure Solver(H: in out Handler_Access; Bool: out Boolean) is
      B: Boolean := True;
      Solved: Boolean := False;
      I: Integer := 1;
      K: Integer;
      Count : Integer:=1;
      checker : Boolean := False;
   begin
     -- if not Block_Check(H) then
       --  Bool := False;
        -- return;
      --end if;
      while I <= H.Parts'Length loop
         K := I;
        -- Put(Count);
         --Count := Count+1;
         --Put(H);
         --if I = 4 then
         --   Put(H.Parts(I));
         --end if;
         --Put(H); New_Line;
         if not Fits_In(H.Parts(I), H.Figure) then
            Next_Pos(H.Parts(I), H.Figure, B);
            if not B and I /= 1 then
               Reset(H.Parts(I));
               Next_Pos(H.Parts(I-1), H.Figure, B);
               I := I - 1;
               --Put("I: "); Put(I, 0); New_Line;
            elsif not B then
               exit;
            end if;
            I := I - 1;
         else
            for J in 1..I-1 loop
--               Put("J: "); Put(J); New_Line;
               if Collides(H.Parts(J), H.Parts(I)) then
--                  Put("Collides"); New_Line;
                  Next_Pos(H.Parts(I), H.Figure, B);
                  checker := True;
                  exit;
               end if;
            end loop;
            if not B and I /= 1 then
               Reset(H.Parts(I));
               Next_Pos(H.Parts(I-1), H.Figure, B);
               --Put("I: "); Put(I, 0); New_Line;
               I := I - 1;
            elsif not B then
               exit;
            end if;
            if checker then
	      I := I - 1;
	      checker := False;
	    end if;
         end if;
         I := I + 1;
      end loop;
      New_Line;
      Bool := B;
   end Solver;

   function Block_Check(H: in Handler_Access) return Boolean is
      Count: Integer := 0;
   begin
      for I in 1..H.Parts'Length loop
         Count := Count + Get_Nr_Of_Blocks(H.Parts(I));
      end loop;
      return Count = Get_Nr_Of_Blocks(H.Figure);
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