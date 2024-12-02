import 'package:flutter/material.dart';
import 'google_map.dart'; // Import the Google Map screen

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Blog'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to GoogleMapFlutter when button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GoogleMapFlutter()),
            );
          },
          child: const Text('Go To Destination'),
        ),
      ),
    );
  }
}
