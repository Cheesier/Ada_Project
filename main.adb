-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

--with figures; use figures;
with Part; use Part;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Network;
with Handler; use Handler;
with Coordinates; use Coordinates;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

procedure main is
   Id: Integer := 1;
   Handle: Handler_Access;
   Solved: Boolean;

begin
   null;

   -- Uppkoppling mot servern och körning av solvern.
   if Network.Init("localhost", 1234, To_Unbounded_String("VORO")) then
      Put_Line("Connection Established");
      
      -- http://xkcd.com/292/
      <<Next>>

      Handle := new Handler_Type(Parse_Figure(Network.Get_Figure), 
                                 Get_Nr_Of_Parts(Network.Get_Parts),
                                 Id);
      Split_Part_String(Handle, Network.get_Parts);
      Solver(Handle, Solved);
      if Solved then
         Network.Solution(Get_Result(Handle));
      else
         Network.Give_Up(Id);
      end if;

      if Network.Get_Answer then
         Id := Id + 1;
         goto Next; -- http://xkcd.com/292/
      end if;

      Network.Get_Result;
   else
      Put_Line("Failed to establish connection to server");
   end if;

end main;
