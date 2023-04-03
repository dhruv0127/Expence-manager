import 'Pages/homepasge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expence_manager/API_Management/googlesheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue,
            useMaterial3: true,
            fontFamily: GoogleFonts.lato().fontFamily,
            brightness: Brightness.light),
        home: const HomePage());
  }
}
