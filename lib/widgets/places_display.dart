// widgets/places_display.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/Provider/favorite_provider.dart';
import 'package:iconsax/iconsax.dart';

class PlacesDisplay extends StatelessWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const PlacesDisplay({super.key, required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    // Access the FavoriteProvider using 'FavoriteProvider.of(context)'
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
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
                        image: NetworkImage(
                          documentSnapshot['pic'], // pic from firestore
                        ),
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
                      "${documentSnapshot['Rate']} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    
                    
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      "${documentSnapshot['Likes']} ",
                      style: const TextStyle(
                        
                        fontSize: 12,
                        color: Color.fromARGB(255, 31, 31, 31),
                      ),
                    ),
                    const SizedBox(width: 5),
                                const Text(
                                  "Reviews",
                                  style: TextStyle(color: Color.fromARGB(255, 31, 31, 31),),
                                  
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
                    provider.toggleFavorite(
                        documentSnapshot); // Trigger favorite toggle
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
