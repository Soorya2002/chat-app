import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserById(String uid) async {
    try {
      final doc = await _firestore.collection('Users').doc(uid).get();
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromMap(doc.data()!);
    } catch (e) {
      print("Error fetching user: $e");
      rethrow;
    }
  }

  Stream<List<UserModel>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();
    });
  }
}
