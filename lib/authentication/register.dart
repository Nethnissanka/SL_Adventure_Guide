import 'package:flutter/material.dart';
import 'package:adventure_guide/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  String error = "";
  bool _isPasswordVisible = false;

  // Custom color palette based on the specified main color
  final Color _primaryColor = Color.fromRGBO(6, 74, 68, 1);
  final Color _lightPrimaryColor = Color.fromRGBO(9, 105, 97, 1);
  final Color _darkPrimaryColor = Color.fromRGBO(4, 53, 48, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'assets/3.avif',
                    height: 200,
                  ),
                ),
                SizedBox(height: 24),

                Text(
                  "Create an Account",
                  style: GoogleFonts.poppins(
                    color: _primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Explore Sri Lanka's Hidden Beauty",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 18,
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
                          prefixIcon: Icon(Icons.email_outlined, color: _primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: _primaryColor, width: 2),
                          ),
                        ),
                        style: GoogleFonts.poppins(color: Colors.black87),
                        validator: (val) => val!.isEmpty ? "Enter a valid email" : null,
                        onChanged: (val) => setState(() => email = val),
                      ),
                      SizedBox(height: 16),

                      // Password Input
                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock_outline, color: _primaryColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible 
                                ? Icons.visibility 
                                : Icons.visibility_off,
                              color: _primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: _primaryColor, width: 2),
                          ),
                        ),
                        style: GoogleFonts.poppins(color: Colors.black87),
                        validator: (val) => val!.length < 6
                            ? "Password must be at least 6 characters"
                            : null,
                        onChanged: (val) => setState(() => password = val),
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

                      // Register Button
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Please enter a valid email!";
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          "REGISTER",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Social Login
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Or continue with",
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      SizedBox(height: 16),
                      OutlinedButton.icon(
                        icon: Image.asset('assets/google.png', height: 24),
                        label: Text(
                          "Sign up with Google",
                          style: GoogleFonts.poppins(color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Implement Google Sign-Up
                        },
                      ),

                      // Login Option
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () => widget.toggle(),
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.poppins(
                                color: _primaryColor,
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


// class Register extends StatefulWidget {
//   final Function toggle;
//   const Register({Key? key, required this.toggle}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
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
//       backgroundColor: bgBlack,
//       appBar: AppBar(
//         title: const Text("REGISTER"),
//         elevation: 0,
//         backgroundColor: bgBlack,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 10),
//           child: Column(
//             children: [
//               //descrption
//               const Text("Explore Sri Lanka Hidden Beauty",
  
//                 style: descriptionStyle,
//               ),

//               Center(
//                 child: Image.asset(
//                   'assets/Picture1.png',
//                   height: 200,
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
//                         style: TextStyle(color: const Color.fromARGB(255, 27, 27, 27)),
//                         decoration:
//                             textInputDecoration.copyWith(hintText: "Password"),
//                         validator: (val) => val!.length < 6
//                             ? "Password must be at least 6 characters"
//                             : null,
//                         onChanged: (val) {
//                           setState(() {
//                             password = val;
//                           });
//                         },
//                       ),
//                       //google
//                       const SizedBox(height: 20),
//                       //error text
//                       Text(
//                         error,
//                         style: TextStyle(color: Colors.red),
//                       ),
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
//                             //go to the signin page
//                             onTap: () {
//                               widget.toggle();
//                             },
//                             child: const Text(
//                               "LOGIN",
//                               style: TextStyle(
//                                   color: mainBlue, fontWeight: FontWeight.w600),
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
//                               .registerWithEmailAndPassword(email, password);

//                           if (result == null) {
//                             //error
//                             setState(() {
//                               error = "please enter a valid email!";
//                             });
//                           }
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 200,
//                           decoration: BoxDecoration(
//                               color: bgBlack,
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(width: 2, color: mainYellow)),
//                           child: const Center(
//                               child: Text(
//                             "REGISTER",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500),
//                           )),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       //anon
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