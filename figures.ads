with Parts; use Parts;

package Figures is
   type Figure(Id : Natural; fig_string : String; nr_of_parts : Positive := 1) is private;
   --Behövs ändringar för att kunna göra en tom? (Stoppa in delarna på sina platser)
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
