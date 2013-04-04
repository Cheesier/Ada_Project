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
   begin
      return Parse_Part(U);
   end Parse_Figure;

   procedure Solver(H: in out Handler_Access; Solved: out Boolean) is

      procedure Solver_Do(I: in Integer) is
         Colliding: Boolean := False;
         Has_Next_Pos: Boolean := True;
      begin
         if I > H.Parts'Length then -- Checks if it is solved
            Solved := True;
            return;
         end if;
         loop
            if not Fits_In(H.Parts(I), H.Figure) then
               colliding := True;
               Next_Pos(H.Parts(I), H.Figure, Has_Next_Pos);
            else
               for J in 1..I-1 loop
                  if Collides(H.Parts(J), H.Parts(I)) then
                     Colliding := True;
                     Next_Pos(H.Parts(I), H.Figure, Has_Next_Pos);
                     exit;
                  end if;
               end loop;
            end if;

            if not Colliding then
               Solver_Do(I + 1);
               if not solved then
                  next_pos(H.Parts(I), H.Figure, Has_Next_Pos);
               else 
                  return;
               end if;
            elsif not Has_Next_Pos then
               reset(H.parts(I));
               return;
            end if;
            Colliding := False;
         end loop;
      end Solver_Do;

   begin
      Solved := False;
      if not Block_Check(H) then
         return;
      end if;
      Solver_Do(1); -- Start at first part, and then dig in
   end Solver;

   procedure Solver_Old(H: in out Handler_Access; Bool: out Boolean) is
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
         Put(Count);
         Count := Count+1;
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
   end Solver_Old;

   function Block_Check(H: in Handler_Access) return Boolean is
      Count: Integer := 0;
   begin
      for I in 1..H.Parts'Length loop
         Count := Count + Get_Nr_Of_Blocks(H.Parts(I));
      end loop;
      return Count = Get_Nr_Of_Blocks(H.Figure);
   end Block_Check;

   procedure Split_Part_String(H: in out Handler_Access; U: in Unbounded_String) is
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