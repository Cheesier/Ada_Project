-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Part;

package Figure is
   type Figure_Type(Id: Natural; Fig_String: String; Part_Count: Positive := 1) 
      is private;
   --Perhaps be able to make an empty?
   function "="(Left, Right: in Figure_Type) return Boolean;
   procedure Insert(F: in out Figure_Type; Part: in String);


private
   type Figure_Type(Id: Natural; Fig_String: String; Part_Count: Positive := 1) is
      record
         Id: Natural := Id;
         F: array of Parts_Type(1..Part_Count);
--           F: Part := to_part(fig_string);
      end record;

end Figure;
