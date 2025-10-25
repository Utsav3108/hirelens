import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';

import '../Widgets/CustomTextFields.dart';

class LocationDetails extends StatefulWidget {
  final bool isUserSolo;
  final RegUser user;
  final Map<String, bool> errors;

  LocationDetails({
    super.key,
    required this.isUserSolo,
    required this.user,
    required this.errors,
  });

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final TextEditingController addressController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

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
        const SizedBox(height: 20),
        CustomTextField(
          hasError: widget.errors['address'] ?? false,
          onValueChange: (address) {
            widget.user.address.address = address;
            setState(() {
              widget.errors['address'] = address != widget.user.address.address;
            });
          },
          controller: addressController,
          placeholder: widget.isUserSolo
              ? "Enter your address"
              : "Enter name of studio",
        ),
        const SizedBox(height: 20),
        CustomTextField(
          hasError: widget.errors['city'] ?? false,
          onValueChange: (city) {
            widget.user.address.city = city;
            setState(() {
              widget.errors['city'] = city != widget.user.address.city;
            });
          },
          controller: areaController,
          placeholder: widget.isUserSolo
              ? "Enter the city you live in"
              : "Area or locality",
        ),
        const SizedBox(height: 20),
        CustomTextField(
          hasError: widget.errors['pincode'] ?? false,
          onValueChange: (pincode) {
            widget.user.address.pincode = pincode;
            setState(() {
              widget.errors['pincode'] = pincode != widget.user.address.pincode;
            });
          },
          controller: pincodeController,
          placeholder: "Enter Pin code",
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
