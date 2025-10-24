import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../registration.dart';

Future<UserCredential> login({
  required String email,
  required String password,
}) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final creds = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  print("User : ${creds.user?.email ?? "-"}");

  return creds;
}

Future<UserCredential> register({
  required String email,
  required String password,
}) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  print("Params for registrations");
  print("Email : $email");
  print("Password : $password");

  final registeredUser = await auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  print("Registered User : ${registeredUser.user}");

  return registeredUser;
}

Future<void> saveUserToFirestore(RegUser user, String userId) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final result = await _firestore
      .collection('users')
      .doc(userId)
      .set(user.toJson());
  print("Save method returned result");
  return result;
}
