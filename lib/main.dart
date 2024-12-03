import 'package:adventure_guide/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/models/UserModel.dart'; 
import 'package:adventure_guide/services/auth.dart';// Import UserModel
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:provider/provider.dart'; // Import Provider
import 'package:adventure_guide/pages/landing.dart'; // Import your landing page
import 'package:adventure_guide/Provider/favorite_provider.dart'; // Import your FavoriteProvider

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
    // return MaterialApp(
    //   title: 'Explore Sri Lanka',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     textTheme: GoogleFonts.mulishTextTheme(
    //       Theme.of(context).textTheme,
    //     ),
    //   ),
    //   home: const TravelOnBoardingScreen(),
    // );


    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""),
      value: AuthService().user,
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        home: TravelOnBoardingScreen(),
      ),
    );


    
  }
}
