import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:provider/provider.dart'; // Import Provider
import 'package:adventure_guide/pages/landing.dart'; // Import your landing page
import 'package:adventure_guide/Provider/favorite_provider.dart'; // Import your FavoriteProvider
import 'package:adventure_guide/custom_info_windows.dart'; // Import the map screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  try {
    await Firebase.initializeApp();
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(
    // Wrap your app with ChangeNotifierProvider to provide FavoriteProvider
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const TravelOnBoardingScreen(),
    );
  }
}
