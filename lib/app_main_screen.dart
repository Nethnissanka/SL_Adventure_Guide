//app_main_screen.dart
import 'package:adventure_guide/favorite_screen.dart';
import 'package:adventure_guide/my_app_home_screen.dart';
import 'package:adventure_guide/widgets/const.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Make sure to add the iconsax package to your pubspec.yaml

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;

  // List of pages to navigate to
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const MyAppHomeScreen(), // Main Home Screen
      const FavoriteScreen(), // Travel Blog Screen
      const FavoriteScreen(), // Profile Screen
      const SettingsScreen(), // Settings Screen
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 6, 76, 72),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon:
                Icon(selectedIndex == 1 ? Iconsax.calendar5 : Iconsax.location),
            label: "Travel Blog",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 2 ? Iconsax.heart5 : Iconsax.heart),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  navBarPage(iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: kprimaryColor,
      ),
    );
  }
}

// Dummy screens for demonstration


class TravelBlogScreen extends StatelessWidget {
  const TravelBlogScreen(IconData calendar5, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Travel Blog screen.'),
    );
  }
}



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Settings screen.'),
    );
  }
}
