import 'package:flutter/material.dart';
import '../Utils/validation.dart';
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
    "Lighroom",
    "Photoshp",
    "Final Cut ro",
    "Lightroom",
    "Photoshop",
    "Final Cut Pro",
    "Lighroom",
    "Photoshp",
    "Final Cut ro",
  ];

  void scrollIntoVisibleArea(GlobalKey targetKey, double viewHeight) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final context = targetKey.currentContext;
      if (context == null) return;

      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final position = box.localToGlobal(Offset.zero);
      final bottomY = position.dy + box.size.height;

      // ✅ if the bottom of target widget is below visible height (350),
      // scroll just enough to make it visible
      if (bottomY > viewHeight) {
        final offset = scrollController.offset + (bottomY - viewHeight);

        print("==> Scroll Positions : ${scrollController.position}");
        print(
          "==> maxScrollExtent: ${scrollController.position.maxScrollExtent}",
        );
        print(
          "==> minScrollExtent: ${scrollController.position.minScrollExtent}",
        );
        print("==> extentTotal: ${scrollController.position.extentTotal}");
        print("==> outOfRange: ${scrollController.position.outOfRange}");
        print("==> offset: ${scrollController.offset}");

        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

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
