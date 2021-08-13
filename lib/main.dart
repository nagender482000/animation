import '../screen/home_screen.dart';

import '../screen/profile_screen.dart';

import 'screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NSS Project',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.muliTextTheme(),
      ),
      home: SplashScreen(),
      routes: {
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
        HomePage.routeName: (ctx) => HomePage(),
      },
    );
  }
}
