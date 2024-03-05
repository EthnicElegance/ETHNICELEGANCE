import 'package:ethnic_elegance/utils/theme/custom_themes/appbar_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/chip_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/text_field_theme.dart';
import 'package:ethnic_elegance/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class EAppTheme{
  EAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // fontFamily:  ,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: ETextTheme.lightTextTheme,
    chipTheme: EChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: EAppBarTheme.lightAppBarTheme,
    checkboxTheme: ECheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: EBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: EElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: EOutlinedButtonTheme.lightOutlinedbuttonTheme,
    inputDecorationTheme: ETextFormFieldTheme.lightInputDecorationTheme

  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      // fontFamily: ''
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      textTheme: ETextTheme.darkTextTheme,
      chipTheme: EChipTheme.darkChipTheme,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: EAppBarTheme.darkAppBarTheme,
      checkboxTheme: ECheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: EBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: EElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: EOutlinedButtonTheme.darkOutlinedbuttonTheme,
      inputDecorationTheme: ETextFormFieldTheme.darkInputDecorationTheme
  );
}