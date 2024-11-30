//my_app_home_screen.dart
import 'package:adventure_guide/view_all_items.dart';
import 'package:adventure_guide/widgets/banner2.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/widgets/const.dart';
import 'package:adventure_guide/widgets/banner.dart';
import 'package:adventure_guide/widgets/places_display.dart';
import 'package:adventure_guide/widgets/my_icon_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  State<MyAppHomeScreen> createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State<MyAppHomeScreen> {
  // ignore: non_constant_identifier_names
  String Category = "All";
  // for category
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("App-Category");
  // for all itesm display
  Query get fileteredRecipes =>
      FirebaseFirestore.instance.collection("destinations").where(
            'Category',
            isEqualTo: Category,
          );
  Query get allRecipes => FirebaseFirestore.instance.collection("destinations");
  Query get selectedRecipes =>
      Category == "All" ? allRecipes : fileteredRecipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerParts(),
                    mySearchBar(),
                    // for banner
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // for category

                    selectedCategory(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Places",
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ViewAllItems(),
                              ),
                            );
                          },
                          child: const Text(
                            "View all",
                            style: TextStyle(
                              color: kBannerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
              StreamBuilder(
                stream: selectedRecipes.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> recipes =
                        snapshot.data?.docs ?? [];
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, left: 15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: recipes
                              .map((e) => PlacesDisplay(documentSnapshot: e))
                              .toList(),
                        ),
                      ),
                    );
                  }
                  // it means if snapshot has date then show the date otherwise show the progress bar
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Banner2(),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: Text(
                        "Newly Added",
                        style: TextStyle(
                          fontSize: 20,
                          
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    allCategory(),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                    ),
                    
                    
                  ],
                ),
              ),
              StreamBuilder(
  stream: allRecipes.orderBy('Rate', descending: true).snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final List<DocumentSnapshot> recipes = snapshot.data?.docs ?? [];
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: recipes
                .map((e) => PlacesDisplay(documentSnapshot: e))
                .toList(),
          ),
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  },
),


              // StreamBuilder(
              //   stream: selectedRecipes.snapshots(),
              //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //     if (snapshot.hasData) {
              //       final List<DocumentSnapshot> recipes =
              //           snapshot.data?.docs ?? [];
              //       return Padding(
              //         padding: const EdgeInsets.only(top: 5, left: 15),
              //         child: SingleChildScrollView(
              //           scrollDirection: Axis.horizontal,
              //           child: Row(
              //             children: recipes
              //                 .map((e) => PlacesDisplay(documentSnapshot: e))
              //                 .toList(),
              //           ),
              //         ),
              //       );
              //     }
              //     // it means if snapshot has date then show the date otherwise show the progress bar
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      Category = streamSnapshot.data!.docs[index]['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          Category == streamSnapshot.data!.docs[index]['name']
                              ? const Color.fromARGB(255, 22, 101, 76)
                              : Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      streamSnapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        color:
                            Category == streamSnapshot.data!.docs[index]['name']
                                ? Colors.white
                                : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // it means if snapshot has date then show the date otherwise show the progress bar
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    
  }
 StreamBuilder<QuerySnapshot<Object?>> allCategory() {
  return StreamBuilder(
    stream: categoriesItems.snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      if (streamSnapshot.hasData) {
        // Filter for the "All" category
        final allCategoryData = streamSnapshot.data!.docs
            .where((doc) => doc['name'] == 'All')
            .toList();

        if (allCategoryData.isEmpty) {
          return const Center(
            child: Text(
              'Category "All" not found',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: allCategoryData.length,
          itemBuilder: (context, index) {
            final itemName = allCategoryData[index]['name'];

            // return GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       Category = itemName;
            //     });
            //   },
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(25),
              //     color: Category == itemName
              //         ? const Color.fromARGB(255, 22, 101, 76)
              //         : Colors.white,
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 20,
              //     vertical: 10,
              //   ),
              //   margin: const EdgeInsets.only(bottom: 10),
              //   child: Text(
              //     itemName,
              //     style: TextStyle(
              //       color: Category == itemName
              //           ? Colors.white
              //           : Colors.grey.shade600,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
            // );
          },
        );
      }

      // If the snapshot doesn't have data, show a progress indicator
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}


  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(Iconsax.search_normal),
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "Search any places",
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Poppins',
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        const Text(
          "Explore \nthe Nature?",
          style: TextStyle(
            fontSize:50,
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 6, 76, 72),
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const Spacer(),
        MyIconButton(
          icon: Iconsax.notification,
          pressed: () {},
        ),
      ],
    );
  }
}
