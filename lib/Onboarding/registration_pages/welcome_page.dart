import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Welcome Utsav Pandya",
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
