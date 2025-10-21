import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class PortfolioDetails extends StatefulWidget {
  const PortfolioDetails({super.key});

  @override
  State<PortfolioDetails> createState() => _PortfolioDetailsState();
}

class _PortfolioDetailsState extends State<PortfolioDetails> {
  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();

    if (picked != null && picked.isNotEmpty) {
      setState(() {
        // limit selection to 5
        if (picked.length > 5) {
          _selectedImages.clear();
          _selectedImages.addAll(picked.take(5));
        } else {
          _selectedImages.clear();
          _selectedImages.addAll(picked);
        }
      });
    }
  }

  Widget _buildImageBox(int index) {
    if (index < _selectedImages.length) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(_selectedImages[index].path), fit: BoxFit.cover),
      );
    } else {
      return GestureDetector(
        onTap: _pickImages,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
            color: Colors.white.withOpacity(0.05),
          ),
          child: const Icon(Icons.add_a_photo_outlined, color: Colors.white54),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = 80;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Upload your best shots 📸',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top Row (3 images)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          3,
                          (index) => SizedBox(
                            width: size,
                            height: size,
                            child: _buildImageBox(index),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Bottom Row (2 images)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          2,
                          (index) => SizedBox(
                            width: size,
                            height: size,
                            child: _buildImageBox(index + 3),
                          ),
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
    );
  }
}
