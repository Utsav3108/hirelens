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
  @override
  Widget build(BuildContext context) {
    print("Data of user to be registered");
    widget.user.printAsJson();

    return FutureBuilder(
      future: saveUserToFirestore(widget.user, widget.user.email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final first = widget.user.firstName;
          final last = widget.user.lastName;

          return mainScreen(firstName: first, lastName: last);
        } else if (snapshot.hasError) {
          return Text("Your request has some error.");
        } else {
          return mainScreen(firstName: "-", lastName: "-");
        }
      },
    );
  }

  Widget mainScreen({required String firstName, required String lastName}) {
    return Column(
      children: [
        SizedBox(height: 50),
        Image.asset(
          "assets/images/Welcome-Page-Image.png",
          width: 200,
          height: 200,
          fit: BoxFit.fitHeight,
        ),
        Spacer(),
        Text(
          "Welcome $firstName $lastName",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "Your next great shot starts right here — with Hirelens.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
