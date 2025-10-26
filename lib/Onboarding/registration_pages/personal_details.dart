import 'package:flutter/material.dart';
import '../Utils/validation.dart';
import '../Widgets/CustomTextFields.dart';
import '../registration.dart';

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
    final bool isSolo = widget.isUserSolo;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tell us a bit about yourself.",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Name Fields
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hasError: widget.errors['firstName'] ?? false,
                  controller: firstController,
                  placeholder: isSolo ? "First name" : "Owner's first name",
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
                  controller: lastController,
                  placeholder: isSolo ? "Last name" : "Owner's last name",
                  onValueChange: (lastname) {
                    widget.user.lastName = lastname;
                    setState(() {
                      widget.errors['lastName'] = lastname.isEmpty;
                    });
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Email
          CustomTextField(
            hasError: widget.errors['email'] ?? false,
            controller: emailController,
            placeholder: isSolo ? "Enter your email" : "Owner's email address",
            enableVerification: true,
            validator: isValidEmail,
            keyboardType: TextInputType.emailAddress,
            onValueChange: (email) {
              widget.user.email = email;
              setState(() {
                widget.errors['email'] = email.isEmpty || !isValidEmail(email);
              });
            },
          ),

          const SizedBox(height: 20),

          // Password
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

          // Confirm Password
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
        ],
      ),
    );
  }
}
