import 'package:flutter/material.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/custom_multiple_select.dart';

class WorkDetails extends StatelessWidget {
  final bool isUserSolo;

  WorkDetails({super.key, required this.isUserSolo});

  final List<String> photographyType = [
    "Wedding",
    "Event",
    "Fashion",
    "Product",
    "Portrait",
  ];

  final List<String> availabitiy = ["Freelance", "Full time"];

  final List<String> editors = ["Lightroom", "Photoshop"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isUserSolo) ...[
            const Text(
              "Tell us about your Work Experience.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),

            CustomMultiSelectField(
              placeholder: "Select services you provide",
              options: photographyType,
              onSelectionChanged: (values) {
                print("Selected photography types: $values");
              },
            ),
            SizedBox(height: 20),

            CustomTextField(
              placeholder: "Years of experience",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            CustomTextField(
              placeholder: "Select your availability",
              isSelection: true,
              menuItems: availabitiy,
            ),
            SizedBox(height: 20),
            //
            CustomMultiSelectField(
              placeholder: "Select editors you use",
              options: editors,
              onSelectionChanged: (values) {
                print("Selected editors types: $values");
              },
            ),
          ] else ...[
            const Text(
              "Verify studio with GST Number",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 60),

            CustomTextField(
              placeholder: "Enter your GST Number",
              enableVerification: true,
              validator: isValidGST,
            ),

            SizedBox(height: 40),

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
