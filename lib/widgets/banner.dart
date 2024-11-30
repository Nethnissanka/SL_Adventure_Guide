import 'package:adventure_guide/view_all_items.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/widgets/const.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 6, 76, 72),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 32,
            left: 20,
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Explore Sri Lanka's Hidden \nBeauty and Adventure",
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ViewAllItems(),
                              ),
                            );
                  },
                  child: const Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: -20,
            child: Image.asset(
              "assets/1.png",
            ),
          ),
        ],
      ),
    );
  }
}
