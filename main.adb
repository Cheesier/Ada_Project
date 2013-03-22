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
--with Parts; use parts;
with Ada.Text_IO; use Ada.Text_IO;
with Network;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

procedure main is
	Id: Integer := 1;
begin

   if Network.Init("localhost", 2400, To_Unbounded_String("Ost")) then
      Put_Line("Success!");
      Put_Line(Network.Get_Parts);
      Put_Line(Network.Get_Figure);

      Network.Give_Up(Id);
      while Network.Get_Answer loop
         Id := Id + 1;
      	Network.Give_Up(Id);
      end loop;
      Network.Get_Result;

   else
      Put_Line("Fail");
   end if;

end main;
