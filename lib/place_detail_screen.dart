import 'package:adventure_guide/Provider/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/widgets/my_icon_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class DestinationDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const DestinationDetailScreen({super.key, required this.documentSnapshot});

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: goToDestination(provider),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // for image
                Container(
                  height: MediaQuery.of(context).size.height / 2.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.documentSnapshot['pic'],
                      ),
                    ),
                  ),
                ),
                // for back button
                Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      MyIconButton(
                          icon: Icons.arrow_back_ios_new,
                          color: const Color.fromARGB(255, 230, 193, 46),
                          pressed: () {
                            Navigator.pop(context);
                          }),
                      const Spacer(),
                      MyIconButton(
                        color: Colors.white,
                        icon: Iconsax.notification,
                        pressed: () {},
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0, right: 0, top:MediaQuery.of(context).size.height / 2.1 - 30,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                      
                    ),
                  ),
                ),
              ],
            ),

            //for drag handle
            Center(
              child: Container(
                // margin: const EdgeInsets.only(top: 5),
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Destination Title and Details
                  Text(
                    widget.documentSnapshot['Name'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        size: 22,
                        color: Color.fromARGB(255, 6, 74, 65),
                      ),
                      Text(
                        "${widget.documentSnapshot['District']} ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Rating
                  Row(
                    children: [
                      const Icon(
                        Iconsax.star1,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "${widget.documentSnapshot['Rate']} ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Likes/Reviews count
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        "${widget.documentSnapshot['Likes']} Reviews",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.documentSnapshot['Description'],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 55, 55, 55),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height:
                          30), // Add some space between description and new places

                  // New Places Section
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recommended",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  'destinations') // Adjust your collection name if needed
                              .orderBy('Likes',
                                  descending:
                                      true) // Use 'addedDate' to show the most recent places
                              .limit(3) // Limit to 3 places
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text(
                                      'No newly added places. Stay tuned for more!'));
                            }

                            return Column(
                              children: snapshot.data!.docs.map((document) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    color: Colors.white,
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 5),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          document['pic'],
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        document['Name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      subtitle: Text(
                                        document['District'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Colors.grey[700],
                                      ),
                                      onTap: () {
                                        // Implement navigation to another screen if needed
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton goToDestination(FavoriteProvider provider) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 10, 78, 68),
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 13),
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text(
              "Go to Destination",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
              ),
            ),
            onPressed: () {
              provider.toggleFavorite(widget.documentSnapshot);
            },
            icon: Icon(
              provider.isExist(widget.documentSnapshot)
                  ? Iconsax.heart5
                  : Iconsax.heart,
              color: provider.isExist(widget.documentSnapshot)
                  ? const Color.fromARGB(255, 197, 32, 101)
                  : Colors.black,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}













// import 'package:adventure_guide/Provider/favorite_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:adventure_guide/widgets/my_icon_button.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:provider/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class DestinationDetailScreen extends StatefulWidget {
//   final DocumentSnapshot<Object?> documentSnapshot;
//   const DestinationDetailScreen({super.key, required this.documentSnapshot});

//   @override
//   State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
// }

// class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = FavoriteProvider.of(context);

//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: goToDestination(provider),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 // Carousel for images
//                 // CarouselSlider(
//                 //   items: List.generate(
//                 //     widget.documentSnapshot['image'].length,
//                 //     (index) => Image.network(
//                 //       widget.documentSnapshot['image'][index],
//                 //       fit: BoxFit.cover,
//                 //       width: double.infinity,
//                 //     ),
//                 //   ),
//                 //   options: CarouselOptions(
//                 //     autoPlay: true,
//                 //     enlargeCenterPage: true,
//                 //     aspectRatio: 16 / 9,
//                 //     viewportFraction: 1,
//                 //   ),
//                 // ),
//                 CarouselSlider(
//   items: List.generate(
//     widget.documentSnapshot['image'].length,
//     (index) {
//       // Print the URL to the console to check if it is correct
//       print(widget.documentSnapshot['image'][index]);

//       String imageUrl = widget.documentSnapshot['image'][index];
//       return Image.network(
//         imageUrl,
//         fit: BoxFit.cover,
//         width: double.infinity,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) {
//             return child;
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Center(child: Icon(Icons.error));  // Show an error icon if the image fails to load
//         },
//       );
//     },
//   ),
//   options: CarouselOptions(
//     autoPlay: true,
//     enlargeCenterPage: true,
//     aspectRatio: 16 / 9,
//     viewportFraction: 1,
//   ),
// ),

//                 // for back button
//                 Positioned(
//                   top: 40,
//                   left: 10,
//                   right: 10,
//                   child: Row(
//                     children: [
//                       MyIconButton(
//                           icon: Icons.arrow_back_ios_new,
//                           color: const Color.fromARGB(255, 230, 193, 46),
//                           pressed: () {
//                             Navigator.pop(context);
//                           }),
//                       const Spacer(),
//                       MyIconButton(
//                         color: Colors.white,
//                         icon: Iconsax.notification,
//                         pressed: () {},
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Destination Title and Details
//                   Text(
//                     widget.documentSnapshot['Name'],
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       const Icon(
//                         Iconsax.location,
//                         size: 22,
//                         color: Color.fromARGB(255, 6, 74, 65),
//                       ),
//                       Text(
//                         "${widget.documentSnapshot['District']} ",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   // Rating
//                   Row(
//                     children: [
//                       const Icon(
//                         Iconsax.star1,
//                         color: Colors.amberAccent,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         "${widget.documentSnapshot['Rate']} ",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   // Likes/Reviews count
//                   Row(
//                     children: [
//                       const SizedBox(width: 5),
//                       Text(
//                         "${widget.documentSnapshot['Likes']} Reviews",
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   // Description
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           widget.documentSnapshot['Description'],
//                           style: const TextStyle(
//                             fontSize: 18,
//                             color: Color.fromARGB(255, 55, 55, 55),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),  // Add some space between description and new places
                  
//                   // New Places Section
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Recommended",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('destinations') // Adjust your collection name if needed
//                               .orderBy('Likes', descending: true) // Use 'addedDate' to show the most recent places
//                               .limit(3) // Limit to 3 places
//                               .snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const Center(child: CircularProgressIndicator());
//                             }

//                             if (snapshot.hasError) {
//                               return Center(child: Text('Error: ${snapshot.error}'));
//                             }

//                             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                               return const Center(child: Text('No newly added places. Stay tuned for more!'));
//                             }

//                             return Column(
//                               children: snapshot.data!.docs.map((document) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                   child: Card(
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     color: Colors.white,
//                                     child: ListTile(
//                                       contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                                       leading: ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: Image.network(
//                                           document['pic'],
//                                           width: 90,
//                                           height: 90,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       title: Text(
//                                         document['Name'],
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                       subtitle: Text(
//                                         document['District'],
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.grey[600],
//                                         ),
//                                       ),
//                                       trailing: Icon(
//                                         Icons.arrow_forward_ios,
//                                         size: 18,
//                                         color: Colors.grey[700],
//                                       ),
//                                       onTap: () {
//                                         // Implement navigation to another screen if needed
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 40,)
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   FloatingActionButton goToDestination(FavoriteProvider provider) {
//     return FloatingActionButton.extended(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       onPressed: () {},
//       label: Row(
//         children: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 10, 78, 68),
//               padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 13),
//               foregroundColor: Colors.white,
//             ),
//             onPressed: () {},
//             child: const Text(
//               "Go to Destination",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Poppins',
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             style: IconButton.styleFrom(
//               shape: CircleBorder(
//                 side: BorderSide(
//                   color: Colors.grey.shade300,
//                   width: 2,
//                 ),
//               ),
//             ),
//             onPressed: () {
//               provider.toggleFavorite(widget.documentSnapshot);
//             },
//             icon: Icon(
//               provider.isExist(widget.documentSnapshot)
//                   ? Iconsax.heart5
//                   : Iconsax.heart,
//               color: provider.isExist(widget.documentSnapshot)
//                   ? const Color.fromARGB(255, 197, 32, 101)
//                   : Colors.black,
//               size: 22,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
