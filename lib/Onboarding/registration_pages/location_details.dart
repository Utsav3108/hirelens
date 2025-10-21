import 'package:flutter/material.dart';

import '../Widgets/CustomTextFields.dart';

class LocationDetails extends StatelessWidget {
  final bool isUserSolo;

  const LocationDetails({super.key, required this.isUserSolo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Tell us where you live?",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 20),

        CustomTextField(
          isSelection: true,
          menuItems: ["Ahmedabad", "Nikol"],
          onMenuItemSelected: (value) {
            print("item 1 selected");
          },
          placeholder: isUserSolo
              ? "Enter your address"
              : "Enter name of studio",
        ),
        SizedBox(height: 20),

        CustomTextField(
          placeholder: isUserSolo
              ? "Enter the city you live in"
              : "Area or locality",
        ),

        CustomTextField(
          placeholder: "Enter Pin code",
          isSelection: true,
          menuItems: ["345677", "567888"],
          onMenuItemSelected: (value) {
            print("item 1 selected");
          },
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
