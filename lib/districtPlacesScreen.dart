import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/Provider/favorite_provider.dart';
import 'package:adventure_guide/place_detail_screen.dart';
import 'package:iconsax/iconsax.dart';

class DistrictPlacesScreen extends StatelessWidget {
  final String districtId;

  const DistrictPlacesScreen({super.key, required this.districtId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 76, 72),
        centerTitle: true,
        

        title: Text('District Places', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'arial'
          ),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('destinations') // Your Firestore collection for places
            .where('districtId', isEqualTo: districtId) // Filter places by districtId
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No places found for this district.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final place = snapshot.data!.docs[index];
              return PlacesDisplay(documentSnapshot: place);
            },
          );
        },
      ),
    );
  }
}

class PlacesDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const PlacesDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    // Access the FavoriteProvider using 'FavoriteProvider.of(context)'
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailScreen(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 20),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: documentSnapshot['pic'],
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(documentSnapshot['pic']), // pic from firestore
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  documentSnapshot['Name'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Iconsax.location,
                      size: 16,
                      color: Color.fromARGB(255, 5, 94, 25),
                    ),
                    Text(
                      "${documentSnapshot['District']} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Icon(
                      Iconsax.star1,
                      size: 16,
                      color: Color.fromARGB(255, 230, 193, 46),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${documentSnapshot['Likes']} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Favorite button
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    provider.toggleFavorite(documentSnapshot); // Trigger favorite toggle
                  },
                  child: Icon(
                    provider.isExist(documentSnapshot)
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color: provider.isExist(documentSnapshot)
                        ? const Color.fromARGB(255, 184, 7, 45)
                        : Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
