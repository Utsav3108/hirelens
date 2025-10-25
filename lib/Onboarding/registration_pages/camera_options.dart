import 'package:flutter/material.dart';
import 'package:hirelens/Onboarding/registration.dart';
import '../Widgets/custom_multiple_select.dart';

class CameraOptions extends StatelessWidget {
  final bool isUserSolo;
  final RegUser user;

  CameraOptions({super.key, required this.isUserSolo, required this.user});

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

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                required: true,
                placeholder: "Select camera brands",
                options: cameraCompanies,
                scrollController: controller,
                viewHeight: constraints.maxHeight,
                onSelectionChanged: (brands) {
                  // handle selected cameras
                  print("Selected cameras: $brands");
                  user.cameraDetails.cameraBrand = brands;
                },
              ),
              const SizedBox(height: 20),

              CustomMultiSelectField(
                placeholder: "Select lens",
                options: lensType,
                scrollController: controller,
                viewHeight: constraints.maxHeight,
                onSelectionChanged: (lens) {
                  // handle selected cameras
                  print("Selected lens: $lens");
                  user.cameraDetails.lens = lens;
                },
              ),
              const SizedBox(height: 20),

              CustomMultiSelectField(
                placeholder: "Select additional gears",
                options: gears,
                scrollController: controller,
                viewHeight: constraints.maxHeight,
                onSelectionChanged: (gears) {
                  print("Selected gears: $gears");
                  user.cameraDetails.additionalGears = gears;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
