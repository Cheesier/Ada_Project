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
   Test2: Part_Access := Part.Parse_Part(To_Unbounded_String("5x2x5 10000111100000011111000001111100000111111000111111")); -- := new Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   Test3: Part_Access := Part.Parse_Part(To_Unbounded_String("1x2x2 1101"));
   Test4: Part_Access := Part.Parse_Part(To_Unbounded_String("2x2x1 1111"));
   TestSpec: Part_Access := Part.Parse_Part(To_Unbounded_String("3x2x3 111111110110100100"));

   Handle: Handler_Access;
   Handle2: Handler_Type(Test2, 7, 2);
   B: Boolean := True;
   Count: Integer := 0;
   Dim: Vec3 := Get_Dimensions(Test2);
   U: Unbounded_String;
begin

   --Put(Test3); New_Line;
   --Test := new Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   
--    if Network.Init("localhost", 2500, To_Unbounded_String("Ost")) then
--       U := Network.Get_Figure;
--       Test := Part.Parse_Part(To_Unbounded_String(Slice(U, 3, Length(U))));
--       Handle := new Handler_Type(Test, 2, Id);
--       Put_Line("Connection Established");
--       --Put_Line(Network.Get_Parts);
--       Split_Part_String(Handle, Network.Get_Parts);
--       Solver(Handle, B);
--       Put(Handle); New_Line;
--       Put(To_String(Get_Result(Handle)));
--       --New_Line;
--       if B then
--          Network.Solution(Get_Result(Handle));
--          --Network.Solution(To_Unbounded_String("1 ! 0 0 0 0 0 0 ! 0 0 0 0 0 1 ! 0 0 0 0 0 2 ! 0 0 1 0 0 1 ! 0 0 0 0 0 0 ! 0 0 0 0 0 0 ! 0 0 0 0 0 0"));
--       else
--          Network.Give_Up(Id);
--       end if;
--       B := Network.Get_Answer;
--       loop
--          B := True;
--          Id := Id + 1;
--          Network.Give_Up(Id);
--          -- Split_Part_String(Handle2, Network.Get_Parts);
--          -- Solver(Handle2, B);
--          -- Put(To_String(Get_Result(Handle2)));
--          -- if B then
--          --    Network.Solution(Get_Result(Handle2));
--          -- else
--       	  -- Network.Give_Up(Id);
--          -- end if;
--          exit when not Network.Get_Answer;
--       end loop;
--       Network.Get_Result;

-- else
--    Put_Line("Failed to establish connection to server");
-- end if;

--   Part.Move(PartA, 1, 1, 0);
   --Part.Move(PartB, 1, 1, 0);

--   if Part.Collides(PartA, PartB) then
--      Put("They collide");
--   end if;

   --Split_Part_String(Handle, To_Unbounded_String("2 1x2x1 11 2x2x1 1001"));
   --Put(Handle);
--   Put(Test2);
--   New_Line;

   Put_Visual(TestSpec);
   Put_Line("---");
   Part.Rotate(TestSpec, 0, 1, 1);
   Put_Visual(TestSpec);

   -- Put_Line("---");

   --Put_Visual(Test3);
   --Rotate_X(Test3);
   --Put_Visual(Test3);

   -- if Collides(Test3, Test4) then
   --    Put("Kolliderar"); New_Line;
   -- else
   --    Put("Kolliderar inte"); New_Line;
   -- end if;

   -- Rotate_X(Test4);
   -- -- Move(Test4, 0, 1, 0);

   -- if Collides(Test3, Test4) then
   --    Put("Kolliderar"); New_Line;
   -- else
   --    Put("Kolliderar inte"); New_Line;
   -- end if;

end main;
