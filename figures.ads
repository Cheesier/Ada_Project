-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Ther�n,     oskth878
-- Viktor Persson,   vikpe557
-- Rasmus Thuresson, rasth297
--
-----------------------------------------------------------

with Parts; use Parts;

package Figures is
   type Figure(Id : Natural; fig_string : String; nr_of_parts : Positive := 1) is private;
   --Beh�vs �ndringar f�r att kunna g�ra en tom? (Stoppa in delarna p� sina platser)
   function "="(left, right : in Figure) return Boolean;
   procedure insert(F : in out figure; part : in String);


private
   type Figure(Id : Natural; fig_string : String; nr_of_parts : Positive := 1) is
      record
         Id : Natural := Id;
         F : array of Parts(1..nr_of_parts);
--           F : Part := to_part(fig_string);
      end record;

end Figures;
