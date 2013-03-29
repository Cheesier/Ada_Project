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
   procedure Add_Parts(Parts: in Unbounded_String) is
   begin
      for I in 1..Nr_Of_Parts loop
         Part_Arr(I) := Parse_Part(Parts);
      end loop;
   end Add_Parts;

   procedure Split_Part_String(H: in Handler_Type; U: in Unbounded_String) is
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
            Put(S'Length);
            New_Line;
            Put(I);
            New_Line;
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
            
         H.Parts(K) := Parse_Part(To_Unbounded(Slice(U, Len+1, I+X*Y*Z)));
         Start := I+X*Y*Z+1;
         I := I + X*Y*Z + 1;
      end loop;
   end Split_Part_String;
end Hanler;