import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import 'package:hirelens/Onboarding/repos/onboarding_repo.dart';

class WelcomePage extends StatefulWidget {
  final RegUser user;

  const WelcomePage({super.key, required this.user});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthRepo _authRepo = AuthRepo();
  late Future<void> _registrationFuture;

  @override
  void initState() {
    super.initState();
    _registrationFuture = _registerUser();
  }

  Future<void> _registerUser() async {
    print("❤️Welcome page register method called");
    await _authRepo.register(user: widget.user, password: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    print("Data of user to be registered");
    widget.user.printAsJson();

    return FutureBuilder(
      future: _registrationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          );
        }
        if (snapshot.hasError) {
          return Text("Your request has some error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          final first = widget.user.firstName;
          final last = widget.user.lastName;

          return mainScreen(firstName: first, lastName: last);
        }
        return mainScreen(firstName: "-", lastName: "-");
      },
    );
  }

  Widget mainScreen({required String firstName, required String lastName}) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Image.asset(
          "assets/images/Welcome-Page-Image.png",
          width: 200,
          height: 200,
          fit: BoxFit.fitHeight,
        ),
        const Spacer(),
        Text(
          "Welcome $firstName $lastName",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Your next great shot starts right here — with Hirelens.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
