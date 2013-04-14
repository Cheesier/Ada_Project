-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------
with TJa.Sockets; use TJa.Sockets;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with GNAT.Calendar; use GNAT.Calendar;
with Ada.Calendar;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package body Network is
   Socket: Socket_Type;
   Last_Packet: Packet_Type;
   Parts: Unbounded_String;
   Figure: Unbounded_String;

   ----

   function Init(Address: in String; Port: in Positive; Nick: in Unbounded_String)
                return Boolean is
      Nickname: Unbounded_String := Nick;
   begin
      if not Connect(Address, Port) then
         Get_Packet; -- The terminate Packet
         Put_Line("Servern stängs: """ & Last_Packet.Message & """");
         return False;
      end if;
      
      while not Send_Nickname(Nickname) loop
         Put_Line("Ditt Nickname var " & Last_Packet.Message);
            Put("Välj ett annat: ");
            Nickname := Get_Line;
      end loop;
      
      Get_Packet;
      Parts := Last_Packet.Message;

      Get_Packet; -- we always know that this is a figure
      Recieve_Figure;
      
      return True;
   end Init;

   procedure Send(Header: in Character; Message: in Unbounded_String) is
   begin
      Put(Socket, Get_Time);
      Put(Socket, Header);
      Put(Socket, ' ');
      Put(Socket, Message);
      New_Line(Socket);
   end Send;

   procedure Send(Header: in Character; Message: in Integer) is
   begin
      Send(Header, To_Unbounded_String(Integer'Image(Message)));
   end Send;

   function Connect(Address: in String; Port: Natural) return Boolean is
   begin
      Initiate(Socket);
      Connect(Socket, Address, Port);
      Get_Packet;
      return Last_Packet.Message = "OK";
   end Connect;
   
   function Send_Nickname(Nickname: in Unbounded_String) return Boolean is
   begin
      Send('N', Nickname);
      Get_Packet;
      return Last_Packet.Message = "OK";
   end Send_Nickname;

   ----
   
   function Get_Parts return Unbounded_String is
   begin
      return Parts;
   end Get_Parts;
   
   function Get_Figure return Unbounded_String is
   begin
      return Figure;
   end Get_Figure;

   -- Gets an entire message back from server
   procedure Get_Packet is
      Blank: Character;
   begin
      Get(Socket, Last_Packet.Time);
      Get(Socket, Blank);
      Get(Socket, Last_Packet.Header);
      Get(Socket, Blank);
      Get_Line(Socket, Last_Packet.Message);
   end Get_Packet;

   function Get_Time return Unbounded_String is
      Now: Ada.Calendar.Time := Ada.Calendar.Clock;
      Ret: Unbounded_String;
   begin
      Ret := Append_Zero(Hour(Now)) & ":" &
          Append_Zero(Minute(Now)) & ":" &
          Append_Zero(Second(Now)) & " ";
      return Ret;
   end Get_Time;

   procedure Get_Result is
   begin
      -- we already got the packet from Get_Answer
      Put("Corrent, Fail, Position: ");
      Put_Line(Last_Packet.Message);

      Get_Packet;
      if Last_Packet.Header = 'U' then
         Put("Got a new Position: ");
         Put(Last_Packet.Message);
         Get_Packet; -- get the AllDone packet
      end if;

      Put("Current Position: ");
      Put_Line(Last_Packet.Message);
      Terminate_Session;
   end Get_Result;

   procedure Recieve_Figure is
   begin
      Figure := Last_Packet.Message;
   end Recieve_Figure;

   ----

   function Append_Zero(Value: in Natural) return Unbounded_String is
      Ret: Unbounded_String;
   begin
      if Value < 10 then
         Append(Ret, '0');
      end if;
      Append(Ret, Trim(Integer'Image(Value), Ada.Strings.Left));
      return Ret;
   end Append_Zero;

   --------------------------------------------------------

   procedure Give_Up(Id: in Natural) is
   begin
      Send('G', Id);
      Put_Line("Gave up on figure" & Integer'Image(Id));
   end Give_Up;

   procedure Solution(Solution: in Unbounded_String) is
   begin
      Send('S', Solution);
   end Solution;

   -- Boolean tells us if to continue or not
   function Get_Answer return Boolean is
   begin
      Get_Packet;
      Put_Line(Last_Packet.Message); -- Far from best practice but still

      Get_Packet;
      case Last_Packet.Header is
         when 'F' =>
            Recieve_Figure;
            return True;
         when 'D' =>
            return False;
         when others =>
            -- debug
            Put_Line(Last_Packet.Header & " was sent?!?!");
            return False;
      end case;
   end Get_Answer;

   --------------------------------------------------------

   procedure Terminate_Session is
   begin
      Get_Packet;
      Put("Terminating Session: ");
      Put_Line(Last_Packet.Message);
      Close(Socket);
   end Terminate_Session;

   
end Network;
