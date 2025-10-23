import 'package:flutter/material.dart';
import '../Widgets/CustomTextFields.dart';
import '../Widgets/custom_multiple_select.dart';

class WorkDetails extends StatefulWidget {
  final bool isUserSolo;

  const WorkDetails({super.key, required this.isUserSolo});

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  final ScrollController scrollController = ScrollController();

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
                placeholder: "Select services you provide",
                options: photographyType,
                scrollController: scrollController,
                viewHeight: viewHeight,
                onSelectionChanged: (values) {
                  print("Selected photography types: $values");
                },
              ),
              const SizedBox(height: 20),

              CustomTextField(
                placeholder: "Years of experience",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              CustomTextField(
                placeholder: "Select your availability",
                isSelection: true,
                menuItems: availability,
              ),
              const SizedBox(height: 20),

              CustomMultiSelectField(
                key: _editorFieldKey,
                placeholder: "Select editors you use",
                options: editors,
                scrollController: scrollController,
                viewHeight: viewHeight,
                onSelectionChanged: (values) {
                  print("Selected editors types: $values");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
