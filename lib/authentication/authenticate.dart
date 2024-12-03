import 'package:flutter/material.dart';
import 'package:adventure_guide/authentication/register.dart';
import 'package:adventure_guide/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signinPage = true;



  // toggle pages
  void switchPages(){
    setState(() {
      signinPage = !signinPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (signinPage == true) {
      return SignIn(toggle: switchPages);
    } else {
      return Register(toggle: switchPages);
    }
}
}