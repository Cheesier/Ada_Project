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
with Ada.Unchecked_Deallocation;

package Handler is
   type Part_Arr is 
      array(Integer range <>) of Part_Access;
   type Handler_Type(Nr_Of_Parts: Positive) is private;
   type Handler_Access is access Handler_Type;
   
   function Get_Result(H: in Handler_Access; Id: in Integer) return Unbounded_String;
   procedure Solver(H: in out Handler_Access; Figure_String: in Unbounded_String; Solved: out Boolean);
   function Block_Check(H: in Handler_Access; Figure: in Part_Access) return Boolean;
   procedure Put(H: in Handler_Access);
   procedure Split_Part_String(H: in out Handler_Access; U: in Unbounded_String);
   function Parse_Figure(U: in Unbounded_String) return Part_Access;
   function Get_Nr_Of_Parts(S: in Unbounded_String) return Integer;
--When comparing the figure to the Parts you have to take into
--account the displacement!
   
   procedure Free_Memory(H: in out Handler_Access);

private
   type Handler_Type(Nr_Of_Parts: Positive) is
      record
         Parts: Part_Arr(1..Nr_Of_Parts);
      end record;

   procedure Free is new Ada.Unchecked_Deallocation
     (Object => Handler_Type, Name => Handler_Access);

end Handler;