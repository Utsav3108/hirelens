import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';

class PersonalDetails extends StatefulWidget {
  final bool isUserSolo;
  RegUser user;

  PersonalDetails({super.key, required this.isUserSolo, required this.user});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController firstController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwdController = TextEditingController();

  final TextEditingController confirmPasswdController = TextEditingController();

  final TextEditingController gstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.isUserSolo) ...[
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
                Expanded(
                  child: CustomTextField(
                    controller: firstController,
                    placeholder: "First name",
                    onValueChange: (firstname) {
                      widget.user.firstName = firstname;
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    controller: lastController,
                    placeholder: "Last name",
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            CustomTextField(
              controller: emailController,
              placeholder: "Enter your email",
              onValueChange: (email) {
                widget.user.email = email;
              },
              enableVerification: true,
              validator: isValidEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),

            CustomTextField(
              controller: passwdController,
              placeholder: "Enter your password",
              isSecure: true,
              onValueChange: (password) {
                widget.user.password = password;
              },
            ),
            SizedBox(height: 20),

            CustomTextField(
              controller: confirmPasswdController,
              placeholder: "Confirm your password",
              isSecure: true,
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

            SizedBox(height: 20),

            CustomTextField(
              controller: gstController,
              placeholder: "Enter your studio's GST Number",
              enableVerification: true,
              validator: isValidGST,
            ),

            SizedBox(height: 20),

            CustomTextField(
              controller: emailController,
              keyboardType: TextInputType.number,
              placeholder: "Owner's email address",
              enableVerification: true,
              validator: (value) => value.length == 10,
            ),
            SizedBox(height: 20),

            CustomTextField(
              controller: passwdController,
              placeholder: "Enter your password",
              isSecure: true,
            ),
            SizedBox(height: 20),

            CustomTextField(
              controller: confirmPasswdController,
              placeholder: "Confirm your password",
              isSecure: true,
            ),
          ],
        ],
      ),
    );
  }
}
