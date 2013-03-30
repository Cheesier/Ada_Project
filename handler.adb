-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

package body Handler is

   function Parse_Figure(U: in Unbounded_String) return Part_Type is
   begin
      return Parse_Part(U);
   end Parse_Figure;

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
         Put("After First loop");
         New_Line;
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
            
         H.Parts(K) := new Parse_Part(To_Unbounded_String(Slice(U, Start+1, I+X*Y*Z)));
         Start := I+X*Y*Z+1;
         I := I + X*Y*Z + 1;
      end loop;
   end Split_Part_String;
end Handler;