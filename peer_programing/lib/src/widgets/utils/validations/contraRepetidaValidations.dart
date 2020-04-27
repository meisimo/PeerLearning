class ContraRepetidaValidation{
  static String contraValida;
  static String contraValida2;

static  contraseValidation(contra) {
         contraValida= contra;
}

static  String contraseValidationReal(contra2) {
        contraValida2= contra2;

         if(contraValida==contraValida2) return null;
          return "Contraseñas diferentes";
  }

}