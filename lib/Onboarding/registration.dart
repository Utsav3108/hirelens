import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/Utils/validation.dart';
import 'package:hirelens/Onboarding/registration_pages/camera_options.dart';

import 'package:hirelens/Onboarding/registration_pages/location_details.dart';
import 'package:hirelens/Onboarding/registration_pages/personal_details.dart';
import 'package:hirelens/Onboarding/registration_pages/portfolio_details.dart';
import 'package:hirelens/Onboarding/registration_pages/studio_selection.dart';
import 'package:hirelens/Onboarding/registration_pages/welcome_page.dart';
import 'package:hirelens/Onboarding/registration_pages/work_details.dart';

import 'dart:convert';

class RegUser {
  bool isSoloPhotographer = false;
  String email = "";
  String password = "";
  String confirmPassword = "";
  String firstName = "";
  String lastName = "";

  StudioDetails studio = StudioDetails();
  Address address = Address();
  CameraDetails cameraDetails = CameraDetails();
  WorkExperience workEx = WorkExperience();

  Map<String, dynamic> toJson() => {
    'isSoloPhotographer': isSoloPhotographer,
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'studio': studio.toJson(),
    'address': address.toJson(),
    'cameraDetails': cameraDetails.toJson(),
    'workEx': workEx.toJson(),
  };

  void printAsJson() {
    final jsonStr = const JsonEncoder.withIndent('  ').convert(toJson());
    print(jsonStr);
  }
}

class StudioDetails {
  String studioName = "";
  String gstNumber = "";

  Map<String, dynamic> toJson() => {
    'studioName': studioName,
    'gstNumber': gstNumber,
  };
}

class Address {
  String address = "";
  String city = "";
  String pincode = "";

  Map<String, dynamic> toJson() => {
    'address': address,
    'city': city,
    'pincode': pincode,
  };
}

class CameraDetails {
  List<String> cameraBrand = [];
  List<String> lens = [];
  List<String> additionalGears = [];

  Map<String, dynamic> toJson() => {
    'cameraBrand': cameraBrand,
    'lens': lens,
    'additionalGears': additionalGears,
  };
}

class WorkExperience {
  List<String> services = [];
  List<String> editors = [];
  String availability = "";
  String yearsOfExperience = "0";

  Map<String, dynamic> toJson() => {
    'services': services,
    'editors': editors,
    'availability': availability,
    'yearsOfExperience': yearsOfExperience,
  };
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _controller = PageController();
  bool userIsSoloPhotographer = false;
  bool isRegistrationSuccess = false;

  late RegUser user = RegUser();
  late List<Widget> registrationPages;
  String _errorMessage = "";
  int _currentPage = 0;
  late int totalSteps;

  // Holds the error state for each field
  final Map<String, bool> _errors = {};

  void _nextPage() {
    if (_checkValidations()) {
      if (_currentPage < totalSteps - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, "/home");
        print("✅ Registration Submitted!");
      }
    }
  }

  bool _checkValidations() {
    _errors.clear();
    bool pageIsValid = true;

    // --- Validation Logic ---
    switch (_currentPage) {
      case 1: // Personal Details
        if (user.firstName.isEmpty) {
          _errors['firstName'] = true;
          pageIsValid = false;
        }
        if (user.lastName.isEmpty) {
          _errors['lastName'] = true;
          pageIsValid = false;
        }
        if (user.email.isEmpty) {
          _errors['email'] = true;
          pageIsValid = false;
        } else if (!isValidEmail(user.email)) {
          _errors['email'] = true;
          pageIsValid = false;
          _setError("Please enter valid email address");
          return pageIsValid;
        }
        if (user.password.isEmpty) {
          _errors['password'] = true;
          pageIsValid = false;
        } else if (user.password.length < 6) {
          _errors['password'] = true;
          pageIsValid = false;
          _setError("Please enter password of atleast 6 characters");
          return pageIsValid;
        }

        if (user.confirmPassword != user.password) {
          _errors['confirmPassword'] = true;
          pageIsValid = false;

          _setError("Confirm password & Password must match");

          return pageIsValid;
        }
        break;

      case 2: // Location Details

        if (!userIsSoloPhotographer) {
          if (user.studio.gstNumber.isEmpty) {
            _errors['gst'] = true;
            pageIsValid = false;
          } else if (!isValidGST(user.studio.gstNumber)) {
            _errors['gst'] = true;
            pageIsValid = false;
            _setError("Please enter valid GST Number");
            return pageIsValid;
          }

          if (user.studio.studioName.isEmpty) {
            _errors['studio_name'] = true;
            pageIsValid = false;
          }
        }

        if (user.address.address.isEmpty) {
          _errors['address'] = true;
          pageIsValid = false;
        }

        if (user.address.city.isEmpty) {
          _errors['city'] = true;
          pageIsValid = false;
        }
        if (user.address.pincode.isEmpty) {
          _errors['pincode'] = true;
          pageIsValid = false;
        } else if (user.address.pincode.length != 6) {
          _errors['pincode'] = true;
          pageIsValid = false;
          _setError("Please enter valid pincode");
          return pageIsValid;
        }
        break;

      case 3: // Camera Options
        if (user.cameraDetails.cameraBrand.isEmpty) {
          _errors['cameraBrand'] = true;
          pageIsValid = false;
        }
        break;

      case 4: // Work Details
        if (user.workEx.services.isEmpty) {
          _errors['services'] = true;
          pageIsValid = false;
        }
        break;
    }

    if (pageIsValid) {
      setState(() {});

      setState(() {
        _errorMessage = "";
      });
    } else {
      _setError("Please fill all mandatory fields");
    }

    return pageIsValid;
  }

  void _setError(String errorMessage) {
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    registrationPages = [
      Align(
        alignment: Alignment.center,
        child: StudioSoloSelector(
          onStudioTap: () {
            setState(() {
              userIsSoloPhotographer = false;
              user.isSoloPhotographer = userIsSoloPhotographer;
              _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          },
          onSoloTap: () {
            setState(() {
              userIsSoloPhotographer = true;
              user.isSoloPhotographer = userIsSoloPhotographer;
              _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
          },
        ),
      ),
      PersonalDetails(
        user: user,
        isUserSolo: userIsSoloPhotographer,
        errors: _errors,
      ),
      LocationDetails(
        user: user,
        isUserSolo: userIsSoloPhotographer,
        errors: _errors,
      ),
      CameraOptions(
        user: user,
        isUserSolo: userIsSoloPhotographer,
        errors: _errors,
      ),
      WorkDetails(
        user: user,
        isUserSolo: userIsSoloPhotographer,
        errors: _errors,
      ),
      PortfolioDetails(),
      WelcomePage(
        user: user,
        onSuccessfulRegistration: () {
          setState(() {
            isRegistrationSuccess = true;
          });
        },
      ),
    ];

    totalSteps = registrationPages.length;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 120),
                const Text(
                  "Hirelens.",
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350,
                  child: Center(
                    child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      children: registrationPages,
                    ),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 15),
                if (_currentPage > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_currentPage > 0 &&
                          _currentPage < totalSteps - 1) ...[
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(150, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Next"),
                        ),
                      ] else if (isRegistrationSuccess)
                        ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(150, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Let's go"),
                        ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
                if (_currentPage < totalSteps - 1)
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
