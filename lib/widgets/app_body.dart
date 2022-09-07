import 'package:ayiconnect_web/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBody extends GetView<AppController> {
  final Widget stepperBody;
  const AppBody({
    Key? key,
    required this.stepperBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StepperBar(),
          Expanded(child: stepperBody),
        ],
      ),
    );
  }
}

class StepperBar extends GetView<AppController> {
  const StepperBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 120, right: 120, top: 20, bottom: 20),
      color: Colors.blueAccent,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: controller.stepOne.value ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: controller.stepOneDone.value
                        ? Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.done))
                        : const Text('1')),
              ),
              const SizedBox(height: 4),
              Text(
                'Select your role',
                style: TextStyle(color: controller.stepOne.value ? Colors.white : Colors.grey[300], fontSize: 12),
              )
            ],
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  height: 1,
                  color: Colors.grey[100],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          const SizedBox(width: 2),
          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: controller.stepTwo.value ? Colors.white : Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                    child: controller.stepTwoDone.value
                        ? Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.done))
                        : const Text('2')),
              ),
              const SizedBox(height: 4),
              Text(
                'Personal Information',
                style: TextStyle(color: controller.stepTwo.value ? Colors.white : Colors.grey[300], fontSize: 12),
              )
            ],
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  height: 1,
                  color: Colors.grey[100],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          const SizedBox(width: 2),
          Column(
            children: [
              Obx(() => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: controller.stepThree.value ? Colors.white : Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                        child: controller.stepThreeDone.value
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.done))
                            : const Text('3')),
                  )),
              const SizedBox(height: 4),
              Text(
                'Professional Information',
                style: TextStyle(color: controller.stepThree.value ? Colors.white : Colors.grey[300], fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
