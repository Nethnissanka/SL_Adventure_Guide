// import 'package:flutter/material.dart';
// import 'package:adventureapp/widgets/const.dart';
// import 'package:adventureapp/models/landing_model.dart';
// import 'package:adventureapp/home.dart';

// class TravelOnBoardingScreen extends StatefulWidget {
//   const TravelOnBoardingScreen({super.key});

//   @override
//   State<TravelOnBoardingScreen> createState() => _TravelOnBoardingScreenState();
// }

// class _TravelOnBoardingScreenState extends State<TravelOnBoardingScreen> {
//   int currentIndex = 0;

//   Widget dotIndicator(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 400),
//       margin: const EdgeInsets.only(right: 6),
//       width: 30,
//       height: 5,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: index == currentIndex ? Colors.white : Colors.white54,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             onPageChanged: (value) {
//               setState(() {
//                 currentIndex = value;
//               });
//             },
//             children: List.generate(
//               onboarding.length,
//               (index) => Image.network(
//                 onboarding[index].image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const SizedBox(height: 40),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => HomeScreen(),
//                           ),
//                           (route) => false,
//                         );
//                       },
//                       child: Visibility(
//                         visible: onboarding.length - 1 != currentIndex,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 7,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.white54,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Text(
//                             "Skip",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           onboarding[currentIndex].name,
//                           style: const TextStyle(
//                             fontSize: 60,
//                             fontFamily: 'Montserrat',
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             height: 1,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           "Explore Sri Lanka's Hidden Beauty and Adventure.",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               height: 185,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       onboarding.length,
//                       dotIndicator,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ClipRRect(
//                     borderRadius: BorderRadiusDirectional.only(
//                       topStart: Radius.circular(40),
//                       topEnd: Radius.circular(40),
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.all(30),
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => HomeScreen(),
//                                   ),
//                                   (route) => false);
//                             },
//                             child: Container(
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: const Color(0xFF2E2E2E),
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Let's Get Started",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 5),
//                                     Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                       size: 22,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 18),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "Already have an account? ",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontFamily: 'Roboto',
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Login",
//                                   style: TextStyle(
//                                     color: const Color(0xFFE7B41B),
//                                     fontFamily: 'Roboto',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //pages/landing.dart

// import 'package:flutter/material.dart';
// // import 'package:adventureapp/widgets/const.dart';
// import 'package:adventure_guide/models/landing_model.dart';
// import 'package:adventure_guide/home.dart';

// class TravelOnBoardingScreen extends StatefulWidget {
//   const TravelOnBoardingScreen({super.key});

//   @override
//   State<TravelOnBoardingScreen> createState() => _TravelOnBoardingScreenState();
// }

// class _TravelOnBoardingScreenState extends State<TravelOnBoardingScreen> {
//   int currentIndex = 0;

//   Widget dotIndicator(int index) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 400),
//       margin: const EdgeInsets.only(right: 6),
//       width: 30,
//       height: 5,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: index == currentIndex ? Colors.white : Colors.white54,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             onPageChanged: (value) {
//               setState(() {
//                 currentIndex = value;
//               });
//             },
//             children: List.generate(
//               onboarding.length,
//               (index) => Image.network(
//                 onboarding[index].image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     const SizedBox(height: 40),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => HomePage(),
//                           ),
//                           (route) => false,
//                         );
//                       },
//                       child: Visibility(
//                         visible: onboarding.length - 1 != currentIndex,
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 18,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.white54,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Text(
//                             "Skip",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           onboarding[currentIndex].name,
//                           style: const TextStyle(
//                             fontSize: 50,
//                             fontFamily: 'Montserrat',
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             height: 1.2,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text(
//                           "Explore Sri Lanka's Hidden Beauty and Adventure.",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               height: 165,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       onboarding.length,
//                       dotIndicator,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ClipRRect(
//                     borderRadius: BorderRadiusDirectional.only(
//                       topStart: Radius.circular(35),
//                       topEnd: Radius.circular(35),
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.all(25),
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => HomePage(),
//                                   ),
//                                   (route) => false);
//                             },
//                             child: Container(
//                               height: 55,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 color: const Color(0xFF2E2E2E),
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "Let's Get Started",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontFamily: 'Roboto',
//                                         fontWeight: FontWeight.w700,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Icon(
//                                       Icons.arrow_forward,
//                                       color: Colors.white,
//                                       size: 24,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 15),
//                           RichText(
//                             text: TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "Already have an account? ",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: 'Roboto',
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Login",
//                                   style: TextStyle(
//                                     color: const Color(0xFFE7B41B),
//                                     fontFamily: 'Roboto',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// pages/landing.dart

import 'package:flutter/material.dart';
import 'package:adventure_guide/models/landing_model.dart';
import 'package:adventure_guide/home.dart';

class TravelOnBoardingScreen extends StatefulWidget {
  const TravelOnBoardingScreen({super.key});

  @override
  State<TravelOnBoardingScreen> createState() => _TravelOnBoardingScreenState();
}

class _TravelOnBoardingScreenState extends State<TravelOnBoardingScreen> {
  int currentIndex = 0;

  Widget dotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(right: 6),
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: index == currentIndex ? Colors.white : Colors.white54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: List.generate(
              onboarding.length,
              (index) => Image.asset(
                onboarding[index].image, // Use Image.asset for local assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: onboarding.length - 1 != currentIndex,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  onboarding[currentIndex].name,
                  style: const TextStyle(
                    fontSize: 60,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Explore Sri Lanka's Hidden Beauty and Adventure.",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 170,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboarding.length,
                      dotIndicator,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(35),
                      topEnd: Radius.circular(35),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      // color: Colors.white,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 19, 19, 19),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Let's Get Started",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an account? ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                TextSpan(
                                  text: "Login",
                                  style: TextStyle(
                                    color: Color(0xFFE7B41B),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w900,
                                    
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
