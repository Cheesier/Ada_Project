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
   LitenTest: Part_Access := Part.Parse_Part(To_Unbounded_String("3x2x2 010111010111"));
   NewTest: Part_Access := Part.Parse_Part(To_Unbounded_String("5x3x4 000000000000000000000000000000000010000100000100001111100000"));
   TestSpec: Part_Access := Part.Parse_Part(To_Unbounded_String("3x2x3 111111110110100100"));

   LitenHandle: Handler_Access := new Handler_Type(LitenTest, 2, Id);
   NewHandle: Handler_Access := new Handler_Type(NewTest, 2,4);
   Handle: Handler_Access := new Handler_Type(Test, 7, Id);
   Handle2: Handler_Type(Test2, 7, 2);
   Solved: Boolean := True;
   Count: Integer := 0;
   Dim: Vec3 := Get_Dimensions(Test2);
   U: Unbounded_String;
begin

   --Put(Test3); New_Line;
   --Test := new Part.Parse_Part(To_Unbounded_String("2x2x2 11001100"));
   
  -- Uppkoppling mot servern och körning av solvern.
   if Network.Init("localhost", 2600, To_Unbounded_String("Ost")) then
      -- De här tre är för dynamisk upphämtning av strängen.
      -- U := Network.Get_Figure;
      -- Test := Part.Parse_Part(To_Unbounded_String(Slice(U, 3, Length(U))));
      -- Handle := new Handler_Type(Test, 2, Id);
      Put_Line("Connection Established");

      --För vanlig test
      -- Split_Part_String(Handle, Network.Get_Parts);
      -- Solver(Handle, B);
      -- Put(Handle); New_Line;

      --För liten test
--       Put(Parse_Figure(Network.Get_Figure));
--       New_Line;
--       Put(Get_Nr_Of_Parts(Network.Get_Parts),0);
--       New_Line;
--       Put(Id,0);
--       New_Line;
    loop
      Handle := new Handler_Type(Parse_Figure(Network.Get_Figure), 
                                 Get_Nr_Of_Parts(Network.Get_Parts),
                                 Id);
      Split_Part_String(Handle, Network.get_Parts);
      Solver(Handle, Solved);
      if Solved then
         Network.Solution(Get_Result(Handle));
         Solved := False;
      else
         Network.Give_Up(Id);
      end if;
      Id := Id+1;
     exit when not Network.Get_Answer;
   end loop;
   Network.Get_Result;
else
   Put_Line("Failed to establish connection to server");
end if;

-- while True loop
--    count := count + 1;
--    if count mod 2000000 = 0 then
--       Put(Count, 0); New_Line;
--    end if;
-- end loop;



--Blandade tester
--   Part.Move(PartA, 1, 1, 0);
   --Part.Move(PartB, 1, 1, 0);

--   if Part.Collides(PartA, PartB) then
--      Put("They collide");
--   end if;

   --Split_Part_String(Handle, To_Unbounded_String("2 1x2x1 11 2x2x1 1001"));
   --Put(Handle);
--   Put(Test2);
--   New_Line;


   -- Put_Visual(TestSpec);
   -- Put_Line("---");
   -- Part.Rotate(TestSpec, 0, 1, 1);
   -- Put_Visual(TestSpec);

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
