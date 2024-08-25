import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel(uid: userCredential.user!.uid, email: email);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserModel?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(uid: userCredential.user!.uid, email: email);

      await _firestore.collection('Users').doc(user.uid).set(user.toMap());

      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
