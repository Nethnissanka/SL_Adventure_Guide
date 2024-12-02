//app_main_screen.dart
import 'package:adventure_guide/districtScreen.dart';
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
                Icon(selectedIndex == 1 ? Iconsax.location : Iconsax.location),
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
            icon: Icon(
                selectedIndex == 4 ? Iconsax.setting_21 : Iconsax.setting_2),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 76, 72),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage(
                  'https://img.freepik.com/premium-photo/happy-world-photography-day-celebration_979658-1732.jpg', // Replace with your image URL
                ),
              ),
              const SizedBox(height: 16),

              // User Name
              const Text(
                'Shezna Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Email
              const Text(
                'sheznadoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Add edit profile functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 6, 76, 72),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Add logout functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
