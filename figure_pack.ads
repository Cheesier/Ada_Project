package Figure_Pack is

private
   type Figure_Type(fig_string : in String) is
      record
         Id : Natural;
         F : Part := to_part(fig_string);
      end record;
end Figure_Pack;
