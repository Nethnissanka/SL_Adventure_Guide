import 'package:adventure_guide/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/models/landing_model.dart';
import 'package:adventure_guide/home.dart';
import 'package:adventure_guide/app_main_screen.dart'; // Adjust the path accordingly

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
                            builder: (_) => const Wrapper(),
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
                                  builder: (_) => const Wrapper(),
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
                          //RichText(
                            // text: const TextSpan(
                            //   children: [
                            //     TextSpan(
                            //       text: "Already have an account? ",
                            //       style: TextStyle(
                            //         fontSize: 18,
                            //         fontFamily: 'Roboto',
                            //         fontWeight: FontWeight.w600,
                            //         color: Color.fromARGB(255, 255, 255, 255),
                            //       ),
                            //     ),
                                
                            //   ],
                            // ),
                          //),
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
