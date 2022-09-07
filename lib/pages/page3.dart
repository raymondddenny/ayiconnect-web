import 'package:ayiconnect_web/controller/app_controller.dart';
import 'package:ayiconnect_web/responsive/app_wrapper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_body.dart';

class PageThree extends GetView<AppController> {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppResponsiveWrapper(
      desktopScaffold: const Desktop(),
      mobileScaffold: Container(),
    );
  }
}

class Desktop extends GetView<AppController> {
  const Desktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppBody(
      stepperBody: PageThreeBody(),
    );
  }
}

class PageThreeBody extends GetView<AppController> {
  const PageThreeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: controller.formKeyStepThree,
      child: ListView(
        padding: const EdgeInsets.only(left: 210, right: 210, top: 50, bottom: 50),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Occupation'),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add your occupation',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.grey.withAlpha(400)), //<-- SEE HERE
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 2, color: Colors.blue), //<-- SEE HERE
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Company'),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add your company name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 1, color: Colors.grey.withAlpha(400)), //<-- SEE HERE
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: 2, color: Colors.blue), //<-- SEE HERE
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fluently spoken language(s) *'),
                const SizedBox(height: 10),
                SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 46,
                          child: Obx(() => OutlinedButton(
                              onPressed: () async {
                                await controller.showMultiSelect(context: context, size: size).then((_) {
                                  if (controller.selectedLanguages.isEmpty) {
                                    controller.isSelectedLanguagesEmpty.value = true;
                                  } else {
                                    controller.isSelectedLanguagesEmpty.value = false;
                                  }
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1,
                                    color: controller.isSelectedLanguagesEmpty.value
                                        ? Colors.red
                                        : Colors.grey.withAlpha(400)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.selectedLanguages.isNotEmpty
                                        ? controller.selectedLanguages.join(', ')
                                        : 'Add language',
                                    style: TextStyle(
                                        color: controller.selectedLanguages.isNotEmpty
                                            ? Colors.black
                                            : Colors.grey.withAlpha(400),
                                        fontSize: 16),
                                  ),
                                  Icon(Icons.add_circle_outline, color: Colors.grey.withAlpha(400)),
                                ],
                              ))),
                        ),
                        Obx(() => controller.isSelectedLanguagesEmpty.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(height: 10),
                                  Text(
                                    'Please choose language.',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              )
                            : const SizedBox())
                      ],
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preferred service'),
                const SizedBox(height: 10),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.withAlpha(400),
                    ),
                  ),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                    ),
                    items: controller.preferredServices.map((code) {
                      return DropdownMenuItem(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    value: controller.selectedPreferredServices.value.isEmpty
                        ? null
                        : controller.selectedPreferredServices.value,
                    hint: Text(
                      'Add your preferred service',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedPreferredServices.value = value;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tell us about you *'),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: controller.isAboutYouEmpty.value ? Colors.red : Colors.grey.withAlpha(400),
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.aboutYouController,
                            decoration: InputDecoration(
                              hintText:
                                  'Provide some brief about yourself, so helper can get to know your a little better before your connection.',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            maxLength: 100,
                            onChanged: (value) {
                              controller.isAboutYouEmpty.value = false;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                controller.isAboutYouEmpty.value = true;
                                return;
                              }
                              controller.isAboutYouEmpty.value = false;
                              return null;
                            },
                          ),
                        )),
                    Obx(() => controller.isAboutYouEmpty.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 10),
                              Text(
                                'Please fill this field.',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          )
                        : const SizedBox())
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            width: size.width * 0.3,
            child: ElevatedButton(
              onPressed: () async {
                if (controller.formKeyStepThree.currentState!.validate()) {
                  if (controller.selectedLanguages.isEmpty) {
                    controller.isSelectedLanguagesEmpty.value = true;
                  } else {
                    controller.isSelectedLanguagesEmpty.value = false;
                  }

                  if (controller.isAboutYouEmpty.value == false && controller.selectedLanguages.isNotEmpty) {
                    controller.stepThreeDone.value = true;
                    controller.stepThree.value = true;

                    await CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: "Your registration is successful",
                    ).then((value) {
                      context.go('/page3?isRegistered=true');
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Submit'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
