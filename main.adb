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
   -- Connecting to the server and running the solver.
   if Network.Init("astmatix", 2600, To_Unbounded_String("VORO")) then
      Put_Line("Connection Established");

      Handle := new Handler_Type(Get_Nr_Of_Parts(Network.Get_Parts));
      Split_Part_String(Handle, Network.Get_Parts);
      
      loop
         Solver(Handle, Network.Get_Figure, Solved);
         
         if Solved then
            Network.Solution(Get_Result(Handle, Id));
         else
            Network.Give_Up(Id);
         end if;

         Id := Id + 1;
         exit when not Network.Get_Answer;
      end loop;

      Network.Get_Result;
   else
      Put_Line("Failed to establish connection to server");
   end if;

end main;
