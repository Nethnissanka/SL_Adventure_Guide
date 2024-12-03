import 'package:flutter/material.dart';
import 'package:adventure_guide/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  // Custom Color Palette
  static const Color primaryColor = Color.fromRGBO(6, 74, 68, 1);
  static const Color lightPrimaryColor = Color.fromRGBO(9, 105, 97, 1);
  static const Color darkPrimaryColor = Color.fromRGBO(4, 53, 48, 1);
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color accentColor = Color.fromRGBO(4, 53, 48, 1);

  String email = "";
  String password = "";
  String error = "";
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Center(
                  child: Image.asset(
                    'assets/2.png',
                    height: 200,
                  ),
                ),
                SizedBox(height: 24),

                Text(
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    color: darkPrimaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Explore Sri Lanka's Hidden Beauty",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email Input
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: lightPrimaryColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                        style: GoogleFonts.poppins(color: darkPrimaryColor),
                        validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
                        onChanged: (val) => setState(() => email = val),
                      ),
                      SizedBox(height: 16),

                      // Password Input
                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible 
                                ? Icons.visibility 
                                : Icons.visibility_off,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: lightPrimaryColor.withOpacity(0.5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                        style: GoogleFonts.poppins(color: darkPrimaryColor),
                        validator: (val) => val!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onChanged: (val) => setState(() => password = val),
                      ),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement Forgot Password
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                              color: accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // Error Message
                      if (error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            error,
                            style: GoogleFonts.poppins(
                              color: Colors.red, 
                              fontSize: 14
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Login Button
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.signInUsingEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Could not sign in with those credentials";
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Anonymous Login
                      SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () async {
                          await _auth.signInAnonymously();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: lightPrimaryColor.withOpacity(0.5)),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "LOGIN AS GUEST",
                          style: GoogleFonts.poppins(
                            color: darkPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Social Login
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Divider(color: lightPrimaryColor.withOpacity(0.5))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Or continue with",
                              style: GoogleFonts.poppins(color: darkPrimaryColor.withOpacity(0.7)),
                            ),
                          ),
                          Expanded(child: Divider(color: lightPrimaryColor.withOpacity(0.5))),
                        ],
                      ),
                      SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: Image.asset('assets/google.png', height: 24),
                        label: Text(
                          "Sign in with Google",
                          style: GoogleFonts.poppins(color: darkPrimaryColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: lightPrimaryColor.withOpacity(0.5)),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Implement Google Sign-In
                        },
                      ),

                      // Register Option
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: GoogleFonts.poppins(color: darkPrimaryColor.withOpacity(0.7)),
                          ),
                          TextButton(
                            onPressed: () => widget.toggle(),
                            child: Text(
                              "REGISTER",
                              style: GoogleFonts.poppins(
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}














// import 'package:flutter/material.dart';
// import 'package:adventure_guide/services/auth.dart';
// import 'package:adventure_guide/constants/colors.dart';
// import 'package:adventure_guide/constants/styles.dart';

// class SignIn extends StatefulWidget {
//   //function
//   final Function toggle;
//   const SignIn({Key? key, required this.toggle}) : super(key: key);

//   @override
//   State<SignIn> createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   //ref for the AuthServices class
//   final AuthService _auth = AuthService();

//   //from key
//   final _formKey = GlobalKey<FormState>();
//   //email password states
//   String email = "";
//   String password = "";
//   String error = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         title: const Text("SIGN IN"),
//         elevation: 0,
//         backgroundColor: const Color.fromARGB(255, 8, 74, 68),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 10),
//           child: Column(
//             children: [
//               //descrption
//               const Text("Explore Sri Lanka Hidden Beauty",
//                 style: TextStyle(
//                     height: 1.1,
//                     fontSize: 24,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 6, 68, 61),
//                   ),
//               ),

//               Center(
//                 child: Image.asset(
//                   'assets/2.png',
//                   height: 300,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       //email
//                       TextFormField(
//                         style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
//                         decoration: textInputDecoration,
//                         validator: (val) =>
//                             val!.isEmpty ? "Enter a valid email" : null,
//                         onChanged: (val) {
//                           setState(() {
//                             email = val;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 20),

//                       //password
//                       TextFormField(
//                         obscureText: true,
//                         style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
//                         decoration:
//                             textInputDecoration.copyWith(hintText: "password"),
//                         validator: (val) => val!.length < 6
//                             ? "Password must be at least 6 characters"
//                             : null,
//                         onChanged: (val) {
//                           setState(() {
//                             password = val;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 20),

//                       Text(
//                         error,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                       //google
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Login with social accounts",
//                         style: descriptionStyle,
//                       ),
//                       const SizedBox(height: 20),
//                       GestureDetector(
//                         //sing in with google
//                         onTap: () {},
//                         child: Center(
//                           child: Image.asset(
//                             'assets/google.png',
//                             height: 50,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       //register
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Do not have an account?",
//                             style: descriptionStyle,
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           GestureDetector(
//                             //go to the register page

//                             onTap: () {
//                               widget.toggle();
//                             },

//                             child: const Text(
//                               "REGISTER",
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 9, 65, 56), fontWeight: FontWeight.w600),
//                             ),
//                           )
//                         ],
//                       ),

//                       //button
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         //methode for login user
//                         onTap: () async {
//                           dynamic result = await _auth
//                               .signInUsingEmailAndPassword(email, password);

//                           if (result == null) {
//                             setState(() {
//                               error = "Could not signin with those credentials";
//                             });
//                           }
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 200,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 184, 184, 184),
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(width: 2, color: const Color.fromARGB(255, 0, 255, 162))),
//                           child: const Center(
//                               child: Text(
//                             "LOGIN",
//                             style: TextStyle(
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 fontWeight: FontWeight.w500),
//                           )),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       //anon
//                       GestureDetector(
//                         //methode for login user as anon
//                         onTap: () async {
//                           await _auth.signInAnonymously();
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 200,
//                           decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 190, 190, 190),
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(width: 2, color: const Color.fromARGB(255, 0, 255, 187))),
//                           child: const Center(
//                             child: Text(
//                               "LOGIN AS GUEST",
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }