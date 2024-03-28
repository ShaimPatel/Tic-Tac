import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.1,
            width: Get.width * 0.2,
          )
        ],
      ),
    );
  }
}
