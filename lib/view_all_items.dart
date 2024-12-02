//view_all_items.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adventure_guide/widgets/const.dart';
import 'package:adventure_guide/widgets/places_display.dart';
import 'package:adventure_guide/widgets/my_icon_button.dart';
import 'package:iconsax/iconsax.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({super.key});

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  final CollectionReference destinations =
      FirebaseFirestore.instance.collection("destinations");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        automaticallyImplyLeading: false, // it removes the appbar back button
        elevation: 0,
        actions: [
          const SizedBox(width: 15),
          MyIconButton(
            color: Colors.black, // MyIconButton is a custom widget
            icon: Icons.arrow_back_ios_new,
            pressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const Text(
            "Recommended",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          MyIconButton(
            color: Colors.black,
            icon: Iconsax.notification,
            pressed: () {},
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Column(
          children: [
            const SizedBox(height:40),
            StreamBuilder(
              stream: destinations.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: SizedBox(
                        height: 290,
                        child: PlacesDisplay(documentSnapshot: documentSnapshot),
                        ),
                      );
                    },
                  );
                }
                // Show a progress bar while loading data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}






//