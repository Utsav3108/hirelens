import 'package:flutter/material.dart';

class StudioSoloSelector extends StatelessWidget {
  final double size;
  VoidCallback onStudioTap;
  VoidCallback onSoloTap;

  StudioSoloSelector({
    super.key,
    required this.onStudioTap,
    required this.onSoloTap,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 120,
      child: Column(
        children: [
          const Text(
            "Tell us, Who are you?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---- Studio ----
              GestureDetector(
                onTap: onStudioTap,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          scale: 1,
                          image: AssetImage('assets/images/studio.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Studio",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // ---- Separator ----
              Container(
                width: 2,
                height: size - 50,
                color: Colors.white.withOpacity(0.1),
                margin: const EdgeInsets.symmetric(horizontal: 30),
              ),

              // ---- Solo ----
              GestureDetector(
                onTap: onSoloTap,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        image: const DecorationImage(
                          scale: 1,
                          image: AssetImage('assets/images/solo.jpg'),
                          fit: BoxFit.fitWidth,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Solo",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
