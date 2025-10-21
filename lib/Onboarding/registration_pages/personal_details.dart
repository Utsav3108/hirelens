import 'package:flutter/material.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';

class PersonalDetails extends StatelessWidget {
  final bool isUserSolo;

  const PersonalDetails({super.key, required this.isUserSolo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isUserSolo) ...[
          const Text(
            "Tell us a bit about yourself.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: CustomTextField(placeholder: "First name")),
              SizedBox(width: 20),
              Expanded(child: CustomTextField(placeholder: "Last name")),
            ],
          ),

          SizedBox(height: 20),

          CustomTextField(
            placeholder: "Enter your email",
            enableVerification: true,
            validator: isValidEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),

          CustomTextField(placeholder: "Enter your password", isSecure: true),
          SizedBox(height: 20),

          CustomTextField(placeholder: "Confirm your password", isSecure: true),
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
    );
  }
}
