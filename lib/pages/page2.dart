import 'package:ayiconnect_web/controller/app_controller.dart';
import 'package:ayiconnect_web/responsive/app_wrapper.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_body.dart';

class PageTwo extends GetView<AppController> {
  const PageTwo({Key? key}) : super(key: key);

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
      stepperBody: PageTwoBody(),
    );
  }
}

class PageTwoBody extends GetView<AppController> {
  const PageTwoBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: controller.formKeyStepTwo,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 30),
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Obx(() => Center(
                    child: controller.pickedFile.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.memory(
                                controller.webImage.value,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 68,
                            color: Colors.grey[500],
                          ))),
              ),
              SizedBox(
                width: size.width * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    width: size.width * 0.2,
                    child: OutlinedButton(
                        onPressed: () async {
                          await controller.pickImage();
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(color: Colors.grey.withAlpha(400)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Add profile photo'),
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.grey[400],
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: size.width * 0.16),
                      child: const Text('Add a profile to make it more personal. It make a difference')),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 2),
          const SizedBox(height: 20),
          const Divider(thickness: 2),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Full Name'),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Your full name',
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
                const Text('Select your gender'),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.3),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.genders.map((gender) {
                        // get index
                        int index = controller.genders.indexOf(gender);
                        return Obx(() => InkWell(
                              onTap: () {
                                controller.selectGender(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: controller.selectedGender.value == index ? Colors.orangeAccent : null,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: controller.selectedGender.value == index
                                        ? Colors.orangeAccent
                                        : Colors.grey.withAlpha(500),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    controller.selectedGender.value == index
                                        ? Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.circle,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          )
                                        : Icon(
                                            Icons.circle_outlined,
                                            color: controller.selectedGender.value == index
                                                ? Colors.white
                                                : Colors.grey[500],
                                          ),
                                    const SizedBox(width: 10),
                                    Text(
                                      gender,
                                      style: TextStyle(
                                          color: controller.selectedGender.value == index
                                              ? Colors.white
                                              : Colors.grey[500]),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      }).toList()),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Choose your date birth'),
                const SizedBox(height: 10),
                GetPlatform.isWeb
                    ? DateTimePicker(
                        dateMask: 'MM/dd/yyyy',
                        decoration: InputDecoration(
                          hintText: 'MM/DD/YYYY',
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.grey[400],
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1, color: Colors.grey.withAlpha(400)), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1, color: Colors.grey.withAlpha(400)), //<-- SEE HERE
                          ),
                        ),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onChanged: (val) {
                          print(val);
                          controller.selectDateWeb(val);
                        },
                      )
                    : SizedBox(
                        height: 56,
                        child: OutlinedButton(
                            onPressed: () async {
                              final date = await controller.pickDate();
                              controller.selectDateMobile(date);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.grey.withAlpha(400)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => controller.selectedDate.value != DateTime.now()
                                    ? Text(
                                        DateFormat('dd/MM/yyyy').format(controller.selectedDate.value),
                                        style: TextStyle(color: Colors.grey[400]),
                                      )
                                    : Text(
                                        'MM/DD/YYYY',
                                        style: TextStyle(color: Colors.grey[400]),
                                      )),
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.grey[400],
                                )
                              ],
                            )),
                      )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Choose your date birth'),
                const SizedBox(height: 10),
                Obx(() => SizedBox(
                      width: size.width * 0.3,
                      height: 56,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                right: 0.5,
                                bottom: 0,
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(color: Colors.grey, width: 1),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                  border: Border.all(
                                    color: Colors.grey.withAlpha(400),
                                  ),
                                ),
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
                                    border: InputBorder.none,
                                  ),
                                  items: controller.countryCode.map((code) {
                                    return DropdownMenuItem(
                                      value: code,
                                      child: Text(code),
                                    );
                                  }).toList(),
                                  value: controller.selectedCountryCode.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectedCountryCode.value = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                border: Border.all(
                                  color: Colors.grey.withAlpha(400),
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  hintText: 'XXXXXXXXXXXXX',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Location *'),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.withAlpha(400),
                    ),
                  ),
                  child: Obx(
                    () => DropdownButtonFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: InputBorder.none,
                      ),
                      items: controller.dummyLocation.map((code) {
                        return DropdownMenuItem(
                          value: code,
                          child: Text(code),
                        );
                      }).toList(),
                      value: controller.findLocation.value.isEmpty ? null : controller.findLocation.value,
                      hint: Text(
                        'Find your location here',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          controller.findLocation.value = value;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select your location';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            width: size.width * 0.3,
            child: ElevatedButton(
              onPressed: () {
                if (controller.formKeyStepTwo.currentState!.validate()) {
                  controller.stepTwoDone.value = true;
                  controller.stepThree.value = true;
                  context.goNamed('page3');
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: const Text('Next'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
