import 'package:ui/src/core/themes/text_theme.dart';
import 'package:ui/src/core/themes/towris_brand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryGreen = TowrisBrand.green;
const _primaryBlue = Color.fromRGBO(13, 71, 161, 1);

final eesupLightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryGreen,
    primary: _primaryGreen,
    secondary: _primaryBlue,
    tertiary: Colors.grey.shade200,
    surface: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    surfaceTintColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _primaryGreen,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      minimumSize: const Size(double.infinity, 54),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: TowrisBrand.field,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: const BorderSide(color: TowrisBrand.lightGreen, width: 1.6),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: WidgetStateProperty.all(const Size(0, 0)),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      shape: WidgetStateProperty.all(const CircleBorder()),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  textTheme: textTheme,
  tooltipTheme: TooltipThemeData(
    textStyle: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(0, 0),
      padding: const EdgeInsets.symmetric(vertical: 10),
      textStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
