import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key});

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int activeStep = 4;

  List<String> status = ["Design", "Production", "On It's Way", "Delivered"];
  List activeStepList = [0, 1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stepper "),
      ),
      body: Container(
        height: Get.height * 0.3,
        width: 200,
        decoration: const BoxDecoration(color: Colors.white),
        child: EasyStepper(
          fitWidth: true,
          activeStep: activeStep,
          showTitle: true,
          showLoadingAnimation: true,
          activeStepBackgroundColor: Colors.grey,
          enableStepTapping: false,
          showScrollbar: false,
          activeStepTextColor: Colors.red,
          steppingEnabled: true,
          stepShape: StepShape.circle,
          maxReachedStep: 4,
          lineStyle:
              const LineStyle(lineWidth: 5, lineLength: 10.0, lineSpace: 2),
          disableScroll: true,
          steps: const [
            EasyStep(
              customStep: Icon(Icons.edit_road_outlined, color: Colors.white),
              title: "Design",
              enabled: true,
            ),
            EasyStep(
                customStep:
                    Icon(Icons.production_quantity_limits, color: Colors.white),
                title: "Production"),
            EasyStep(
                customStep: Icon(Icons.delivery_dining, color: Colors.white),
                title: "On It's Way"),
            EasyStep(
                customStep: Icon(Icons.circle_outlined, color: Colors.white),
                title: "Delivered"),
          ],
          onStepReached: (index) =>
              Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              activeStep = index;
            });
            if (kDebugMode) {
              print(activeStep);
            }
          }),
        ),
      ),
    );
  }
}
