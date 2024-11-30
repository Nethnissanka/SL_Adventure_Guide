// // favorite_screen.dart is a screen that displays the user's favorite destinations.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/Provider/favorite_provider.dart';
import 'package:adventure_guide/widgets/const.dart';
import 'package:iconsax/iconsax.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;

    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 76, 72),
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: favoriteItems.isEmpty
          ? const Center(
              child: Text(
                "No Favorites yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'arial'
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                String favorite = favoriteItems[index];

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("destinations")
                      .doc(favorite)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text("Error loading favorites"),
                      );
                    }

                    var favoriteItem = snapshot.data!;

                    final name = favoriteItem['Name'] ?? "Unknown";
                    final district = favoriteItem['District'] ?? "Unknown";
                    final likes = favoriteItem['Likes']?.toString() ?? "0";
                     final rate = favoriteItem['Rate']?.toString() ?? "0";
                    // final imageUrl = favoriteItem['pic'] ??
                    //     'https://via.placeholder.com/150';

                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                // Image section
                                Container(
                                  width: 180,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        favoriteItem['pic'],
                                        // ??
                                        //     'https://via.placeholder.com/150'
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Text section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 24,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.location,
                                            size: 16,
                                            color:
                                                Color.fromARGB(255, 4, 69, 61),
                                          ),
                                          Text(
                                            "$district ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 96, 96, 96),
                                            ),
                                          ),
                                          
                                          const Icon(
                                            Iconsax.star1,
                                            size: 16,
                                            color: Color.fromARGB(255, 236, 223, 40),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "$rate ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            "$likes Reviews",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              color: Color.fromARGB(
                                                  255, 31, 31, 31),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Delete button
                        Positioned(
                          top: 50,
                          right: 35,
                          child: GestureDetector(
                            onTap: () {
                              provider.toggleFavorite(favoriteItem);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 70, 68, 68),
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:adventure_guide/Provider/favorite_provider.dart';
// import 'package:adventure_guide/widgets/const.dart';
// import 'package:iconsax/iconsax.dart';

// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Access the FavoriteProvider to get favorite items
//     final provider = FavoriteProvider.of(context);
//     final favoriteItems = provider.favorites;

//     return Scaffold(
//       backgroundColor: kbackgroundColor,
//       appBar: AppBar(
//         backgroundColor: kbackgroundColor,
//         centerTitle: true,
//         title: const Text(
//           "Favorites",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: favoriteItems.isEmpty
//           ? const Center(
//               child: Text(
//                 "No Favorites yet",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           : ListView.builder(
//               itemCount: favoriteItems.length,
//               itemBuilder: (context, index) {
//                 // Get the favorite destination ID
//                 String favoriteId = favoriteItems[index];

//                 return FutureBuilder<DocumentSnapshot>(
//                   future: FirebaseFirestore.instance
//                       .collection("destinations")
//                       .doc(favoriteId)
//                       .get(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }

//                     if (!snapshot.hasData || snapshot.data == null) {
//                       return const Center(
//                         child: Text("Error loading favorites"),
//                       );
//                     }

//                     var favoriteItem = snapshot.data!;

//                     // Safely access fields to avoid null errors
//                     final name = favoriteItem['Name'] ?? "Unknown";
//                     final district = favoriteItem['District'] ?? "Unknown";
//                     final likes = favoriteItem['Likes']?.toString() ?? "0";
//                     final imageUrl = favoriteItem['image'] ??
//                         'https://via.placeholder.com/150'; // Default image

//                     // Return the favorite item UI
//                     return Stack(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: Colors.white,
//                             ),
//                             child: Row(
//                               children: [
//                                 // Image section
//                                 Container(
//                                   width: 100,
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(20),
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: NetworkImage(imageUrl),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 // Text section
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       name,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Iconsax.flash_1,
//                                           size: 16,
//                                           color: Colors.grey,
//                                         ),
//                                         Text(
//                                           "$district ",
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         const Text(
//                                           " · ",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w900,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                         const Icon(
//                                           Iconsax.clock,
//                                           size: 16,
//                                           color: Colors.grey,
//                                         ),
//                                         const SizedBox(width: 5),
//                                         Text(
//                                           "$likes Likes",
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12,
//                                             color: Colors.grey,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Delete button
//                         Positioned(
//                           top: 50,
//                           right: 35,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 provider.toggleFavorite(favoriteItem);
//                               });
//                             },
//                             child: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                               size: 25,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
