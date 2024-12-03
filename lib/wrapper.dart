import 'package:adventure_guide/app_main_screen.dart';
import 'package:adventure_guide/my_app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/authentication/authenticate.dart';
import 'package:adventure_guide/pages/home.dart';
import 'package:adventure_guide/models/UserModel.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_auth/models/UserModel.dart';
// import 'package:flutter_auth/screens/authentication/authenticate.dart';
// import 'package:flutter_auth/screens/home/home.dart';
// import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //the user data that the provider proides this can be a user data or can be null.
    final user = Provider.of<UserModel?>(context);

     if (user == null) { 
       return Authenticate();
     } else {
       return AppMainScreen();
     }
   
  }
}