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
      const DistrictScreen(), // Distric wise Screen
      const FavoriteScreen(), // Fav Screen
      const ProfileScreen(), // Profile Screen
      const SettingsScreen(),// Settings Screen
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
            icon: Icon(selectedIndex == 1 ? Iconsax.location : Iconsax.location),
            label: "Districts",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 2 ? Iconsax.heart5 : Iconsax.heart),
            label: "Favourites",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(selectedIndex == 3 ? Iconsax.profile : Iconsax.profile1),
          //   label: "Profile",
          // ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 3 ? Iconsax.user : Iconsax.user),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 4 ? Iconsax.setting_21 : Iconsax.setting_2),
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


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the Profile screen.'),
    );
  }
}
class DistrictScreen extends StatelessWidget {
  const DistrictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is the District screen.'),
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
