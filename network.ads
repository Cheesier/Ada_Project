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
   function Get_Parts return Unbounded_String;
   function Get_Figure return Unbounded_String;

   procedure Solution(Solution: in Unbounded_String);
   procedure Give_Up(Id: in Natural);
   function Get_Answer return Boolean; -- Continue or not?

   procedure Get_Result;
   
private
   procedure Terminate_Session;

   type Packet_Type is 
      record
         Time: String(1..8);
         Header: Character;
         Message: Unbounded_String;
      end record;
   
end Network;
