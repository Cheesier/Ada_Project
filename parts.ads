-----------------------------------------------------------
-- ADA Projekt
--
-- Oscar Thunberg,   oscth887
-- Oskar Therén,     oskth878
-- Viktor Persson,    ????
-- Rasmus Thuresson, ????
--
-----------------------------------------------------------

package Parts is

   type X_Type(X : Positive) is private;
   type Y_Type(Y : Positive; X : Positive) is private;
   type Part(Z, Y, X : Positive) is private;

   procedure new_part(Z, Y, X : in Positive; P : out Part);
   procedure rotate_X(P : in out Part; Times : Positive);
   procedure rotate_Y(P : in out Part; Times : Positive);
   procedure rotate_Z(P : in out Part; Times : Positive);

   procedure move_X(P : in out Part; Steps : Integer);
   procedure move_Y(P : in out Part; Steps : Integer);
   procedure move_Z(P : in out Part; Steps : Integer);

   function get_dimensions(P : in Part) return String;
   function to_string(P : in Part) return String;
   function to_part(S : in String) return Part; --Fixar med dimensionerna också
   function movement_to_string(P : in Part) return String;

   procedure reset(P : in out Part); --Flyttar tillbaka till ursprungsläget

   function collides(a, b : in Part) return boolean;
   function fits_in(left, right : in Part) return boolean;

private
   --Vektorer istället?
   type X_Type(X : Positive) is
      record
         A : array(1..X) of Integer := (Others => 0);
         I : Integer := X;
      end record;
   type Y_Type(Y, X : Positive) is
      record
         A : array(1..Y) of X_Type(X);
         I : Integer := Y;
      end record;
   type Part(Z, Y, X : Positive) is
      record
         A : array(1..Z) of Y_Type(Y, X);
         I : Integer := Z;
         Movement : array(1..6) of Integer; --Sparar alla rörelser
         -- ^^ De första tre är rotationer, de andra tre är förflyttningar
         --Coordinates?
      end record;

end Parts;
