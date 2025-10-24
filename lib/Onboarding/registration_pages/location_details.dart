import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';

import '../Widgets/CustomTextFields.dart';

class LocationDetails extends StatelessWidget {
  final bool isUserSolo;

  final RegUser user;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  LocationDetails({super.key, required this.isUserSolo, required this.user});

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
          onValueChange: (address) {
            user.address.address = address;
          },
          controller: addressController,
          placeholder: isUserSolo
              ? "Enter your address"
              : "Enter name of studio",
        ),
        SizedBox(height: 20),

        CustomTextField(
          onValueChange: (area) => user.address.city = area,
          controller: areaController,
          placeholder: isUserSolo
              ? "Enter the city you live in"
              : "Area or locality",
        ),
        SizedBox(height: 20),

        CustomTextField(
          onValueChange: (pincode) => user.address.pincode = pincode,
          controller: pincodeController,
          placeholder: "Enter Pin code",
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
