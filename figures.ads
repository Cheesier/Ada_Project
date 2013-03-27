-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Parts; use Parts;

package Figures is
   type Figure_Type(Id : Natural; fig_string : String; nr_of_parts : Positive := 1) is private;
   --Perhaps be able to make an empty?
   function "="(left, right : in Figure_Type) return Boolean;
   procedure insert(F : in out figure; part : in String);


private
   type Figure_Type(Id : Natural; fig_string : String; nr_of_parts : Positive := 1) is
      record
         Id : Natural := Id;
         F : array of Parts(1..nr_of_parts);
--           F : Part := to_part(fig_string);
      end record;

end Figures;
