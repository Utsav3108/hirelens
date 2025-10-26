import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/custom_multiple_select.dart';

class WorkDetails extends StatefulWidget {
  final bool isUserSolo;
  final RegUser user;
  final Map<String, bool> errors;

  const WorkDetails({
    super.key,
    required this.isUserSolo,
    required this.user,
    required this.errors,
  });

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  final ScrollController scrollController = ScrollController();

  final TextEditingController yearsController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();

  late final RegUser user = widget.user;

  final List<String> photographyType = [
    "Wedding",
    "Event",
    "Fashion",
    "Product",
    "Portrait",
  ];

  final List<String> availability = ["Freelance", "Full time"];

  final List<String> editors = [
    "Lightroom",
    "Photoshop",
    "Final Cut Pro",
    "Filmora",
    "VN Editor",
  ];

  final GlobalKey _editorFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double viewHeight = constraints.maxHeight;

        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Tell us about your Work Experience.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              CustomMultiSelectField(
                required: true,
                hasError: widget.errors["services"],
                placeholder: "Select services you provide",
                options: photographyType,
                scrollController: scrollController,
                viewHeight: viewHeight,
                onSelectionChanged: (services) {
                  print("Selected photography types: $services");

                  setState(() {
                    widget.errors["services"] = services.isEmpty;
                  });

                  user.workEx.services = services;
                },
              ),
              const SizedBox(height: 20),

              CustomTextField(
                onValueChange: (exp) => user.workEx.yearsOfExperience = exp,
                controller: yearsController,
                placeholder: "Years of experience",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              CustomTextField(
                controller: availabilityController,
                placeholder: "Select your availability",
                isSelection: true,
                menuItems: availability,
                onMenuItemSelected: (status) =>
                    user.workEx.availability = status,
              ),
              const SizedBox(height: 20),

              CustomMultiSelectField(
                key: _editorFieldKey,
                placeholder: "Select editors you use",
                options: editors,
                scrollController: scrollController,
                viewHeight: viewHeight,
                onSelectionChanged: (editors) {
                  print("Selected editors types: $editors");
                  user.workEx.editors = editors;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
