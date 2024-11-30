// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

// class Favouriteprovider extends ChangeNotifier {
//   List<String> _favoriteIds = [];
 

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//    List<String> get favorites => _favoriteIds;

//   Favouriteprovider () {
//     _loadFavorites();
//   }

//   void toggleFavorite(DocumentSnapshot snapshot) async {
//     String productId = snapshot.id;

//     if (_favoriteIds.contains(productId)) {
//       _favoriteIds.remove(productId);
//       await _removeFavorite(productId);
//     } else {
//       _favoriteIds.add(productId);
//       await _addFavorite(productId);
//     }

//     notifyListeners();
//   }

//   //check if the product is in the favorite list
//   bool isExist(DocumentSnapshot snapshot) {
//     return _favoriteIds.contains(snapshot.id);
//   }
//   //add the product to the firestore
//   Future<void> _addFavorite(String productId) async {
//     try {
//       await FirebaseFirestore.instance.collection("userFavorite").doc(productId).set({
//         'isFavorite': true, // create userfav collection in firestore
//       });
//     } catch (e) {
//       print("Error adding favorite: $e");
//     }

    
    
//   }
//   //Remove a product from Firestore
//   Future<void> _removeFavorite(String productId) async {
//       try {
//         await FirebaseFirestore.instance.collection("userFavorite").doc(productId).delete();
//       } catch (e) {
//         print("Error removing favorite: $e");
//       }
//     }

//     //Load all favorites from Firestore
//     Future<void> _loadFavorites() async {
//       try {
//         QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("userFavorite").get();
//         _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
//       } catch (e) {
//         print("Error loading favorites: $e");
//       }
//       notifyListeners();
//     }
    
//     //static method to access the provider
//     static Favouriteprovider of(BuildContext context,{bool listen = true}) {
//       return Provider.of<Favouriteprovider>(
//         context,
//          listen: listen
//          );
//     }

// }