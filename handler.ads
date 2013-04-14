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
   type Handler_Type(Nr_Of_Parts: Positive) is private;
   type Handler_Access is access Handler_Type;
   
   procedure Put(H: in Handler_Access);

   function Get_Result(H: in Handler_Access; Id: in Integer) return Unbounded_String;
   function Get_Nr_Of_Parts(S: in Unbounded_String) return Integer;

   procedure Solver(H: in out Handler_Access; Figure_String: in Unbounded_String; Solved: out Boolean);
   function Block_Check(H: in Handler_Access; Figure: in Part_Access) return Boolean;

   function Parse_Figure(U: in Unbounded_String) return Part_Access;
   procedure Split_Part_String(H: in out Handler_Access; U: in Unbounded_String);

private
   type Handler_Type(Nr_Of_Parts: Positive) is
      record
         Parts: Part_Arr(1..Nr_Of_Parts);
      end record;

end Handler;