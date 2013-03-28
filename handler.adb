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