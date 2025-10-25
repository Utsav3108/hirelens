import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../registration.dart'; // Import your RegUser model

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Login existing user with email and password
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("✅ Logged in user: ${creds.user?.email ?? "-"}");
      return creds;
    } on FirebaseAuthException catch (e) {
      print("❌ Login failed: ${e.message}");
      rethrow;
    }
  }

  /// 🔹 Register new user in Firebase Auth
  /// and then save user data in Firestore if Auth succeeds
  Future<UserCredential> register({
    required RegUser user,
    required String password,
  }) async {
    try {
      print("➡️Attempting registration for ${user.email}");

      // Step 1️⃣: Create Firebase user
      final registeredUser = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      final email = registeredUser.user?.email;
      if (email == null) throw Exception("email is null after registration.");

      print("✅ Firebase user created: $email");

      // Step 2️⃣: Save user data to Firestore
      await saveUserToFirestore(user, email);

      print("✅ User saved in Firestore with ID: $email");

      return registeredUser;
    } on FirebaseAuthException catch (e) {
      print("❌ Registration failed: ${e.message}");
      rethrow;
    } catch (e) {
      print("❌ Unexpected error during registration: $e");
      rethrow;
    }
  }

  /// 🔹 Save user object to Firestore
  Future<void> saveUserToFirestore(RegUser user, String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set(user.toJson());
      print("✅ Firestore user data saved for $userId");
    } catch (e) {
      print("❌ Failed to save user to Firestore: $e");
      rethrow;
    }
  }

  /// 🔹 logout method
  Future<void> logout() async {
    await _auth.signOut();
    print("👋 User signed out");
  }
}
