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
  final ScrollController _controller = ScrollController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController studioNameController = TextEditingController();

  final TextEditingController gstController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
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
              hasError: widget.errors["gst"] ?? false,
              onValueChange: (gstNumber) {
                widget.user.studio.gstNumber = gstNumber;
                setState(() {
                  widget.errors["gst"] =
                      gstNumber.isEmpty || !isValidGST(gstNumber);
                });
              },
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hasError: widget.errors['studio_name'] ?? false,
              controller: studioNameController,
              placeholder: "Enter name of studio",
              onValueChange: (studioName) {
                widget.user.studio.studioName = studioName;
                setState(() {
                  widget.errors['studio_name'] =
                      studioName != widget.user.studio.studioName;
                });
              },
            ),

            const SizedBox(height: 20),
          ],

          CustomTextField(
            hasError: widget.errors['address'] ?? false,
            controller: addressController,
            placeholder: widget.isUserSolo
                ? "Enter your address"
                : "Enter landmark",
            onValueChange: (address) {
              widget.user.address.address = address;
              setState(() {
                widget.errors['address'] =
                    address != widget.user.address.address;
              });
            },
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
            onEditingCompleted: (city) {
              final duration = Duration(milliseconds: 300);
              final curve = Curves.easeInOut;
              final offset = _controller.position.maxScrollExtent;

              _controller.animateTo(offset, duration: duration, curve: curve);
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hasError: widget.errors['pincode'] ?? false,
            onValueChange: (pincode) {
              widget.user.address.pincode = pincode;
              setState(() {
                widget.errors['pincode'] =
                    pincode != widget.user.address.pincode ||
                    widget.user.address.pincode.length != 6;
              });
            },
            controller: pincodeController,
            placeholder: "Enter Pin code",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
