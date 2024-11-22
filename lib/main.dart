// main.dart




// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Only import once
import 'package:adventure_guide/pages/landing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
      await Firebase.initializeApp();
      print("Firebase Initialized Successfully!");

    
  } catch (e) {
    print("Firebase Initialization Error: $e");
    
  }
  
  runApp(const MyApp());
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


// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Travel App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.mulishTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       // home: WelcomePage(),
//       home: TravelOnBoardingScreen(),
//     );
//   }
// }