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
with Network; use Network;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

procedure main is
begin

   if Init("localhost", 2400, To_Unbounded_String("Ost")) then
      Put_Line("Success!");
      Put_Line(Get_Parts);
   else
      Put_Line("Fail");
   end if;
   
   delay 10.0;

end main;
