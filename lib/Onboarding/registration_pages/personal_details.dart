import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';

class PersonalDetails extends StatefulWidget {
  final bool isUserSolo;
  final RegUser user;
  final Map<String, bool> errors;

  const PersonalDetails({
    super.key,
    required this.isUserSolo,
    required this.user,
    required this.errors,
  });

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
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hasError: widget.errors['firstName'] ?? false,
                    controller: firstController,
                    placeholder: "First name",
                    onValueChange: (firstname) {
                      widget.user.firstName = firstname;
                      setState(() {
                        widget.errors['firstName'] = firstname.isEmpty;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    hasError: widget.errors['lastName'] ?? false,
                    onValueChange: (lastName) {
                      widget.user.lastName = lastName;
                      setState(() {
                        widget.errors['lastName'] = lastName.isEmpty;
                      });
                    },
                    controller: lastController,
                    placeholder: "Last name",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hasError: widget.errors['email'] ?? false,
              controller: emailController,
              placeholder: "Enter your email",
              onValueChange: (email) {
                widget.user.email = email;
                setState(() {
                  widget.errors['email'] =
                      email.isEmpty || !isValidEmail(email);
                });
              },
              enableVerification: true,
              validator: isValidEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hasError: widget.errors['password'] ?? false,
              controller: passwdController,
              placeholder: "Enter your password",
              isSecure: true,
              onValueChange: (password) {
                widget.user.password = password;
                setState(() {
                  widget.errors['password'] = password.isEmpty;
                  if (confirmPasswdController.text.isNotEmpty) {
                    widget.errors['confirmPassword'] =
                        confirmPasswdController.text != password;
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hasError: widget.errors['confirmPassword'] ?? false,
              controller: confirmPasswdController,
              placeholder: "Confirm your password",
              isSecure: true,
              onValueChange: (confirmPass) {
                widget.user.confirmPassword = confirmPass;
                setState(() {
                  widget.errors['confirmPassword'] =
                      confirmPass != widget.user.password;
                });
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
            const SizedBox(height: 20),
            CustomTextField(
              controller: gstController,
              placeholder: "Enter your studio's GST Number",
              enableVerification: true,
              validator: isValidGST,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              keyboardType: TextInputType.number,
              placeholder: "Owner's email address",
              enableVerification: true,
              validator: (value) => value.length == 10,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: passwdController,
              placeholder: "Enter your password",
              isSecure: true,
            ),
            const SizedBox(height: 20),
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
