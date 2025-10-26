import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';

import '../Utils/validation.dart';
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

  final TextEditingController gstController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.isUserSolo
              ? "Tell us where you live?"
              : "Tell us about your studio.",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),

        // GST Field (only for studios)
        if (!widget.isUserSolo) ...[
          CustomTextField(
            controller: gstController,
            placeholder: "Enter your studio's GST Number",
            enableVerification: true,
            validator: isValidGST,
            hasError:
                widget.errors["gst"] ??
                false || !isValidGST(widget.user.studio.gstNumber),
            onValueChange: (gstNumber) {
              widget.user.studio.gstNumber = gstNumber;
              setState(() {
                widget.errors["gst"] = !isValidGST(gstNumber);
              });
            },
          ),
          const SizedBox(height: 20),
        ],

        CustomTextField(
          hasError: widget.errors['address'] ?? false,
          onValueChange: (addressOrStudioName) {
            if (widget.isUserSolo) {
              widget.user.address.address = addressOrStudioName;
              setState(() {
                widget.errors['address'] =
                    addressOrStudioName != widget.user.address.address;
              });
            } else {
              widget.user.studio.studioName = addressOrStudioName;
              setState(() {
                widget.errors['address'] =
                    addressOrStudioName != widget.user.studio.studioName;
              });
            }
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
