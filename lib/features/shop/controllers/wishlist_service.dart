import 'package:ethnic_elegance/features/shop/models/wishlist/wishlist_item.dart';
import 'package:ethnic_elegance/sharepreferences.dart';
import 'package:firebase_database/firebase_database.dart';

class WishlistService {
  final Future<String?> userId = getData('key');
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<void> addToWishlist(WishlistItem item) async {
    await databaseReference.child('Project/wishlist').push().set(item.toJson());
  }

  Future<void> removeFromWishlist(String wishlistItemId) async {
    await databaseReference.child('Project/wishlist').child(wishlistItemId).remove();
  }

  Stream<DataSnapshot> getWishlist() {
    return databaseReference
        .child('Project/wishlist')
        .orderByChild('userId')
        .equalTo(userId)
        .onValue
        .map((event) => event.snapshot);
  }
}

