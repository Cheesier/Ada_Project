-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

--with Figures; use Figures;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package Network is
   type Packet_Type is private;
   
   function Init(Address: in String; Port: in Positive; Nick : in Unbounded_String)
                return Boolean;
   procedure Send(Header: in Character; Message: in Unbounded_String);--Added in .ads
   procedure Send(Header: in Character; Message: in Integer);--Added in .ads
   function Connect(Address: in String; Port: Natural) return Boolean;--Added in .ads
   function Send_Nickname(Nickname: in Unbounded_String) return Boolean;--Added in .ads

   function Get_Parts return Unbounded_String;
   function Get_Figure return Unbounded_String;
   procedure Get_Packet;--Added in .ads
   function Get_Time return Unbounded_String;--Added in .ads
   procedure Get_Result;
   procedure Recieve_Figure;--Added in .ads

   function Append_Zero(Value: in Natural) return Unbounded_String;--Added in .ads

   procedure Give_Up(Id: in Natural);
   procedure Solution(Solution: in Unbounded_String);
   function Get_Answer return Boolean; -- Continue or not?

private
   procedure Terminate_Session;

   type Packet_Type is 
      record
         Time: String(1..8);
         Header: Character;
         Message: Unbounded_String;
      end record;
   
end Network;
