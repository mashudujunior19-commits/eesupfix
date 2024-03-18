import 'package:my_kasi_shop/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryOrange = Color.fromRGBO(252, 127, 3, 1);
const _primaryGreen = Color.fromRGBO(48, 142, 88, 1);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryOrange,
    primary: _primaryOrange,
    secondary: _primaryGreen,
    tertiary: Colors.grey.shade200,
  ),
  scaffoldBackgroundColor: Colors.white,
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(Colors.white),
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
      minimumSize: const Size(double.infinity, 50),
      textStyle: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: MaterialStateProperty.all(const Size(0, 0)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(const CircleBorder()),
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
