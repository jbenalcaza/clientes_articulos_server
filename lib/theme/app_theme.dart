import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //Colores Medicity
  static const Color backgroundColorMedi = Color(0xffF0F0F0);
  static const Color buttomAndheadersMedi = Color(0xff8db944);
  static const Color textColorMedi = Colors.white;

  static final TextStyle customTextSylte =
      GoogleFonts.poppins(color: const Color(0xff0070B6));
  static final TextTheme customTextTheme = TextTheme(
      titleLarge: customTextSylte,
      titleMedium: customTextSylte,
      titleSmall: customTextSylte,
      bodyLarge: customTextSylte,
      bodySmall: customTextSylte,
      bodyMedium: customTextSylte);

  //Colores Económicas
  static const Color backgroundColorEco = Color(0xffF0F0F0);
  static const Color buttomAndheadersEco = Color(0xffE20714);
  static final TextStyle customTextSylteEco =
      GoogleFonts.poppins(color: const Color(0xff6A6A71));
  static final TextTheme customTextThemeEco = TextTheme(
      titleLarge: customTextSylteEco,
      titleMedium: customTextSylteEco,
      titleSmall: customTextSylteEco,
      bodyLarge: customTextSylteEco,
      bodySmall: customTextSylteEco,
      bodyMedium: customTextSylteEco);

  //THEMES

  //-----------------MEDICITY------------//

  static final ThemeData mediTheme = ThemeData.dark().copyWith(
    //TEMA PARA EL CONTENIDO DE TEXTO
    textTheme: customTextTheme,

    //TEMA PARA EL COLOR DE FONDO
    scaffoldBackgroundColor: backgroundColorMedi,

    //TEMA PARA EL CURSOR
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: buttomAndheadersMedi,
    ),

    //TEMA PARA EL CONTENIDO DEL APP BAR
    appBarTheme: AppBarTheme(
      titleTextStyle: customTextTheme.bodyLarge,
      surfaceTintColor: buttomAndheadersMedi,
      iconTheme: const IconThemeData(color: buttomAndheadersMedi),
      centerTitle: true,
    ),

    //TEMA PARA LOS ELEVETAD BUTTON Y SU CONTENIDO
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 55),
        backgroundColor: buttomAndheadersMedi,
        shadowColor: Colors.transparent,
      ),
    ),

    //TEMA PARA EL CONTENIDO DE LAS TABLAS
    dataTableTheme: DataTableThemeData(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      dataTextStyle: const TextStyle(color: Color(0xff0070B6)),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
    ),

    //TEMA PARA EL CONTENIDO DE LOS INPUT_TEXTS
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 27),
      fillColor: Colors.white, // Establecer un color de fondo sólido
      filled: true,

      focusedBorder: InputBorder.none,

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  //-----------------ECONOMICAS------------//
  static final ThemeData ecoTheme = ThemeData.dark().copyWith(
    //TEMA PARA EL CONTENIDO DE LOS TEXTOS
    textTheme: customTextThemeEco,

    //TEMA PARA EL COLOR DE FONDO DE LA APP
    scaffoldBackgroundColor: backgroundColorEco,

    //TEMA PARA EL CONTENIDO DE LOS ÍCONOS
    iconTheme: const IconThemeData(color: buttomAndheadersEco),

    //TEMA PARA EL CONTENIDO DEL APP BAR
    appBarTheme: AppBarTheme(
      titleTextStyle: customTextThemeEco.bodyLarge,
      surfaceTintColor: buttomAndheadersEco,
      iconTheme: const IconThemeData(color: buttomAndheadersEco),
      centerTitle: true,
    ),

    //TEMA PARA EL CURSOR
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: buttomAndheadersEco,
    ),

    //TEMA PARA LOS ELEVETAD BUTTON Y SU CONTENIDO
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(300, 55),
        backgroundColor: buttomAndheadersEco,
        shadowColor: Colors.transparent,
      ),
    ),

    //TEMA PARA LAS TABLAS Y SU CONTENIDO
    dataTableTheme: DataTableThemeData(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      dataTextStyle: const TextStyle(
        color: Color(0xff6A6A71),
      ),
      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
    ),

    //TEMA PARA EL CONTENIDO DEL TEXTO EN LOS INPUT_TEXT
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 27),
      fillColor: Colors.white, // Establecer un color de fondo sólido
      filled: true,

      focusedBorder: InputBorder.none,

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
