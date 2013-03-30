-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------
with Part; use Part;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Handler is
   type Part_Arr is 
      array(Integer range <>) of Part_Access;
   type Handler_Type(P: Part_Access; Nr_Of_Parts: Positive) is private;

   procedure Put(H: in Handler_Type);
   procedure Split_Part_String(H: in out Handler_Type; U: in Unbounded_String);
   function Parse_Figure(U: in Unbounded_String) return Part_Access;

--When comparing the figure to the Parts you have to take into
--account the displacement!

private
   type Handler_Type(P: Part_Access; Nr_Of_Parts: Positive) is
      record
         Figure: Part_Access := P;
         Parts: Part_Arr(1..Nr_Of_Parts);
      end record;

end Handler;