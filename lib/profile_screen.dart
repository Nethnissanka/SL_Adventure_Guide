import 'package:flutter/material.dart';
import 'package:adventure_guide/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // Instance of AuthService
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 76, 72),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const NetworkImage(
                      'https://img.freepik.com/premium-photo/happy-world-photography-day-celebration_979658-1732.jpg',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Open profile picture picker
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 6, 76, 72),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // User Information
              const Text(
                'Shezna Doe',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'sheznadoe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Statistics Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatisticTile(Icons.flight_takeoff, 'Trips', '25'),
                      _buildStatisticTile(Icons.rate_review, 'Reviews', '14'),
                      _buildStatisticTile(Icons.favorite, 'Favorites', '8'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Feature Cards
              _buildFeatureCard(
                context,
                icon: Icons.settings,
                title: 'Settings',
                description: 'Manage your account settings and preferences.',
                onTap: () {
                  // Navigate to settings screen
                },
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                icon: Icons.security,
                title: 'Privacy',
                description: 'Control your data and permissions.',
                onTap: () {
                  // Navigate to privacy screen
                },
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                icon: Icons.notifications,
                title: 'Notifications',
                description: 'Manage your notifications and alerts.',
                onTap: () {
                  // Navigate to notifications screen
                },
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Edit profile functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 6, 76, 72),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
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
                  ElevatedButton(
                    onPressed: () async {
                      await _auth.signOut();
                      // Logout functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
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
              const SizedBox(height: 24),

              // Recent Activities
              const Divider(height: 32, thickness: 1, color: Colors.grey),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Activities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActivityTile(
                icon: Icons.hiking,
                title: 'Hiking Adventure at Ella Rock',
                date: 'Dec 1, 2024',
              ),
              _buildActivityTile(
                icon: Icons.campaign,
                title: 'Camping at Horton Plains',
                date: 'Nov 25, 2024',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for statistics tiles
  Widget _buildStatisticTile(IconData icon, String label, String count) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color.fromARGB(255, 6, 76, 72)),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Helper method for feature cards
  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 6, 76, 72)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // Helper method for activity tiles
  Widget _buildActivityTile(
      {required IconData icon, required String title, required String date}) {
    return ListTile(
      leading: Icon(icon, size: 32, color: const Color.fromARGB(255, 6, 76, 72)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}
