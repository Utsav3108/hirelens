import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../registration.dart'; // Import your RegUser model

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the GoogleSignIn instance
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;

  // Required scopes for your application
  static const List<String> _scopes = ['email'];

  // Initialize Google Sign-In (call this in your app's initState or main)
  Future<void> initializeGoogleSignIn() async {
    await _googleSignIn.initialize();
  }

  // 🔹 Login existing user with email and password
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    print("✌️ Attempting login with email $email, password $password");

    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("✅ Logged in user: ${creds.user?.email ?? '-'}");
      return creds;
    } on FirebaseAuthException catch (e) {
      print("❌ Login failed: ${e.message}");
      rethrow;
    }
  }

  // 🔹 Register new user in Firebase Auth
  // and then save user data in Firestore if Auth succeeds
  Future<UserCredential> register({
    required RegUser user,
    required String password,
  }) async {
    try {
      print("➡️ Attempting registration for ${user.email}");

      // Step 1️⃣: Create Firebase user
      final registeredUser = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      final email = registeredUser.user?.email;
      if (email == null) throw Exception("Email is null after registration.");

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

  // 🔹 Save user object to Firestore
  Future<void> saveUserToFirestore(RegUser user, String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set(user.toJson());
      print("✅ Firestore user data saved for $userId");
    } catch (e) {
      print("❌ Failed to save user to Firestore: $e");
      rethrow;
    }
  }

  // 🔹 Sign in using Google (Modern API)
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print("➡️ Attempting Google Sign-In...");

      // Check if the platform supports authentication
      if (!_googleSignIn.supportsAuthenticate()) {
        throw Exception("Google Sign-In is not supported on this platform");
      }

      // Authenticate the user
      final googleUser = await _googleSignIn.authenticate();

      // Check if user already exists in Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(googleUser.email)
          .get();

      if (userDoc.exists) {
        // Get authorization for required scopes
        final GoogleSignInClientAuthorization? authorization = await googleUser
            .authorizationClient
            .authorizationForScopes(_scopes);

        if (authorization == null) {
          print("❌ Failed to get authorization");
          return null;
        }

        // Get the ID token from authorization
        final String accessToken = authorization.accessToken;

        // Create Firebase credential
        final credential = GoogleAuthProvider.credential(
          accessToken: accessToken,
        );

        // Sign in to Firebase with Google credential
        final userCredential = await _auth.signInWithCredential(credential);

        final user = userCredential.user;
        if (user == null) throw Exception("Google user data not found.");

        print("✅ Google user signed in: ${user.email}");

        return userCredential;
      } else {
        print("❌ Google user doesn't exists in Firestore");
        return null;
      }
    } on GoogleSignInException catch (e) {
      print("❌ Google Sign-In failed: ${_errorMessageFromSignInException(e)}");
      rethrow;
    } catch (e) {
      print("❌ Google Sign-In failed: $e");
      rethrow;
    }
    return null;
  }

  // 🔹 Sign out user (supports both Firebase and Google)
  Future<void> logout() async {
    try {
      // Disconnect from Google (this signs out and clears cached credentials)
      await _googleSignIn.disconnect();

      // Sign out from Firebase
      await _auth.signOut();

      print("👋 User signed out from Firebase and Google");
    } catch (e) {
      print("❌ Logout failed: $e");
      // Attempt to at least sign out from Firebase
      try {
        await _auth.signOut();
      } catch (_) {}
      rethrow;
    }
  }

  // 🔹 Get current user
  User? get currentUser => _auth.currentUser;

  // 🔹 Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 🔹 Listen to Google Sign-In authentication events
  Stream<GoogleSignInAuthenticationEvent> get googleAuthEvents =>
      _googleSignIn.authenticationEvents;

  // Helper method to convert GoogleSignInException to readable message
  String _errorMessageFromSignInException(GoogleSignInException e) {
    return switch (e.code) {
      GoogleSignInExceptionCode.canceled => 'Sign in canceled by user',
      GoogleSignInExceptionCode.interrupted => 'Network error occurred',
      GoogleSignInExceptionCode.userMismatch => 'Sign in failed',
      _ => 'GoogleSignInException ${e.code}: ${e.description}',
    };
  }
}
