import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Only import once
import 'package:adventure_guide/pages/landing.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:adventure_guide/Provider/favorite_provider.dart'; // Import your FavoriteProvider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(
    // Wrap your app with ChangeNotifierProvider to provide FavoriteProvider
    ChangeNotifierProvider(
      create: (context) => FavoriteProvider(), // Provide FavoriteProvider
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
      // home: WelcomePage(),
      home: const TravelOnBoardingScreen(),
    );
  }
}
