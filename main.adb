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
--   PartA: Part.Part_Type := Part.Parse_Part(To_Unbounded_String("2x2x2 11111111"));
--   PartB: Part.Part_Type := Part.Parse_Part(To_Unbounded_String("2x2x2 00000000"));
--   Test: aliased Part.Part_Type := Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   Test: Part_Access := Part.Parse_Part(To_Unbounded_String("3x3x3 111111111111111111111111111"));
   Test2 : Part_Access := Part.Parse_Part(To_Unbounded_String("3x3x3 111111111111111111111111111")); -- := new Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   Test3: Part_Access := Part.Parse_Part(To_Unbounded_String("2x2x2 11001001"));
   Handle: Handler_Type(Test, 7, Id);
   B: Boolean := True;
   Count: Integer := 0;
   Dim: Vec3 := Get_Dimensions(Test2);
begin
   --Test := new Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   if Network.Init("localhost", 2400, To_Unbounded_String("Ost")) then
      Put_Line("Connection Established");
      --Put_Line(Network.Get_Parts);
      Split_Part_String(Handle, Network.Get_Parts);
      Solver(Handle, B);
      Put(To_String(Get_Result(Handle)));
      if B then
         Network.Solution(Get_Result(Handle));
      else
         Network.Give_Up(Id);
      end if;
      B := Network.Get_Answer;
      loop
         Id := Id + 1;
         Put_Line(Network.Get_Figure);
      	Network.Give_Up(Id);
         exit when not Network.Get_Answer;
      end loop;
      Network.Get_Result;

   else
      Put_Line("Failed to establish connection to server");
   end if;

--   Part.Move(PartA, 1, 1, 0);
   --Part.Move(PartB, 1, 1, 0);

--   if Part.Collides(PartA, PartB) then
--      Put("They collide");
--   end if;

   Split_Part_String(Handle, To_Unbounded_String("2 1x2x1 11 2x2x1 1001"));
   --Put(Handle);
--   Put(Test2);
--   New_Line;
   B := False;

   Put(To_String(Get_Result(Handle)));
--   while B loop
--      Next_Pos(Test, Test2, B);
--      Put(Test2);
--      New_Line;
--      Count := Count + 1;
--      Put(Count, 0);
--      New_Line;
--   end loop;
--   New_Line;
--   Put("Counter: ");
--   Put(Count, 0);
end main;
