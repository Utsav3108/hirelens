import 'package:flutter/material.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/custom_multiple_select.dart';

class CameraOptions extends StatelessWidget {
  final bool isUserSolo;

  CameraOptions({super.key, required this.isUserSolo});

  final List<String> cameraCompanies = [
    "Canon",
    "Nikon",
    "Sony",
    "Fujifilm",
    "Panasonic",
    "Leica",
    "Olympus",
    "Pentax",
    "GoPro",
    "DJI",
    "Blackmagic",
    "Sigma",
  ];

  final List<String> cameraType = ["DSLR", "Mirrorless"];
  final List<String> lensType = ["24-70mm f/2.8", "50mm f/1.8"];
  final List<String> photographyType = [
    "Wedding",
    "Event",
    "Fashion",
    "Product",
    "Portrait",
  ];
  final List<String> gears = ["Gimbal", "Drone", "Lighting"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isUserSolo) ...[
            const Text(
              "Tell us about your camera setup.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            CustomMultiSelectField(
              placeholder: "Select camera brands",
              options: cameraCompanies,
              onSelectionChanged: (values) {
                // handle selected cameras
                print("Selected cameras: $values");
              },
            ),
            const SizedBox(height: 20),

            CustomMultiSelectField(
              placeholder: "Select lens",
              options: lensType,
              onSelectionChanged: (values) {
                // handle selected cameras
                print("Selected lens: $values");
              },
            ),
            const SizedBox(height: 20),

            CustomMultiSelectField(
              placeholder: "Select additional gears",
              options: gears,
              onSelectionChanged: (values) {
                print("Selected gears: $values");
              },
            ),
            const SizedBox(height: 20),
          ] else ...[
            const Text(
              "Verify studio with GST Number",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            CustomTextField(
              placeholder: "Enter your GST Number",
              enableVerification: true,
              validator: isValidGST,
            ),
            const SizedBox(height: 40),
            CustomTextField(
              keyboardType: TextInputType.number,
              placeholder: "Owner's Phone number",
              enableVerification: true,
              validator: (value) => value.length == 10,
            ),
          ],
        ],
      ),
    );
  }
}
