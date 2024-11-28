import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  // Toggle favorite state
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;

    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId); // Remove from Firestore
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId); // Add to Firestore
    }

    notifyListeners(); // Notify listeners to update UI
  }

  // Check if a product is in the favorites list
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  // Add a product to Firestore
  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        'isFavorite': true, // Store the favorite status in Firestore
      });
    } catch (e) {
      debugPrint("Error adding favorite: $e");
    }
  }

  // Remove a product from Firestore
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      debugPrint("Error removing favorite: $e");
    }
  }

  // Load all favorites from Firestore
  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection("userFavorite").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      debugPrint("Error loading favorites: $e");
    }
    notifyListeners();
  }

  // Static method for easy provider access
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
