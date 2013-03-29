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
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Handler is
   type Part_Arr is 
      array(Integer range <>) of Part_Type(1, 1, 1);
   type Handler_Type(Fig: Unbounded_String; Nr_Of_Parts: Positive) is private;

   procedure Add_Parts(Parts: in Unbounded_String);
   procedure Split_Part_String(H: in Handler_Type; U: in Unbounded_String);


--When comparing the figure to the Parts you have to take into
--account the displacement!

private
   type Handler_Type(Fig: Unbounded_String; Nr_Of_Parts: Positive) is
      record
         Figure: Part_Type := Parse_Part(Fig);
         Parts: Part_Arr(1..Nr_Of_Parts);
      end record;

end Handler;