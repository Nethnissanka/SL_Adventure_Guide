import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomInfoWindows extends StatefulWidget {
  const CustomInfoWindows({super.key});

  @override
  State<CustomInfoWindows> createState() => _CustomInfoWindowsState();
}

class _CustomInfoWindowsState extends State<CustomInfoWindows> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> markers = {};
  final List<LatLng> latlongPoint = [
    const LatLng(8.0362, 79.8283), // Puttalam
    const LatLng(6.9802, 81.0577), // Badulla
    const LatLng(5.94851, 80.53528), // Matara
  ];

  final List<String> locationNames = [
    "Baththangunduwa",
    "Bomburu Ella",
    "Blue Beach Island",
  ];

  final List<String> locationImages = [
    "https://th.bing.com/th/id/R.d045cffeaafaf843b2b973b3ba25abdf?rik=HsxBT2biFZ88Og&riu=http%3a%2f%2fwww.kalpitiyatours.com%2fimg%2fguestphotos%2fcamping%2fcamping-2.jpg&ehk=u6UO9s%2bwUB477NemiXry3myStYs217%2bzgtEJ36517LI%3d&risl=&pid=ImgRaw&r=0",
    "https://thumbs.dreamstime.com/b/bomburu-ella-fantastic-waterfall-hill-side-sri-lanka-fantastic-cascade-hill-side-sri-lanka-drizzling-to-251681973.jpg",
    "https://th.bing.com/th/id/OIP.Qdf1RUf9iwiUK1mUOfMw6AHaFB?rs=1&pid=ImgDetMain",
  ];

  @override
  void initState() {
    super.initState();
    displayInfo();
  }

  displayInfo() {
    for (int i = 0; i < latlongPoint.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: latlongPoint[i],
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                width: 250,
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        locationImages[i],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      locationNames[i],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "(5)",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              latlongPoint[i],
            );
          },
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Destination Map",
          style: TextStyle(fontSize: 24, color: Colors.white,
          fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 47, 43),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(7.8731, 80.7718), // Centered on Sri Lanka
              zoom: 7,
            ),
            markers: markers,
            onTap: (argument) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 180,
            width: 250,
            offset: 50,
          ),
        ],
      ),
      
    );
  }
}
