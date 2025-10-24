import 'package:firebase_auth/firebase_auth.dart';

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
