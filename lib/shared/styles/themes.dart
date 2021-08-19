import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shared/styles/styles.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.deepOrange,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: HexColor('333739'), statusBarIconBrightness: Brightness.light),
    backwardsCompatibility: false,
    backgroundColor: HexColor('333739'),
    elevation: 1.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      elevation: 10.0,
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.grey
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),


  ),


) ;

ThemeData lightTheme = ThemeData(
  primarySwatch: primaryColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white
  ),
  scaffoldBackgroundColor: Colors.grey.shade300,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ),
    backwardsCompatibility: false,
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black54,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      elevation: 10.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  textTheme: TextTheme(
    headline5: bigTitles.headline5,
    bodyText2: bigTitles.bodyText2,
  ),
  fontFamily: 'AGENCY' ,
);