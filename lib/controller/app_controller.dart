import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../services/http_services.dart';
import '../services/location_services.dart';

class AppController extends GetxController {
  RxBool stepOne = true.obs;
  RxBool stepOneDone = false.obs;
  RxBool stepTwo = false.obs;
  RxBool stepTwoDone = false.obs;
  RxBool stepThree = false.obs;
  RxBool stepThreeDone = false.obs;
  RxInt selectedGender = (-1).obs;
  RxBool isFinishRegistered = false.obs;

  RxList genders = ['Male', 'Female', 'Others'].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedDateString = ''.obs;
  RxString selectedCountryCode = '+62'.obs;
  RxString findLocation = ''.obs;
  RxList<String> countryCode = ['+62', '+65', '+1'].obs;
  RxList<String> dummyLocation = ['Bandung, Indonesia', 'Tangerang, Indonesia', 'Jakarta, Indonesia'].obs;
  Rx<Uint8List> webImage = Uint8List(8).obs;
  Rxn<File> pickedFile = Rxn<File>();
  RxList<String> listLanguage = ['English', 'Indonesia', 'Mandarin', 'German', 'Dutch', 'Spanish'].obs;
  RxList<String> selectedLanguages = <String>[].obs;
  RxList<String> preferredServices = ['Child Care', 'Senior Care', 'Home Care', 'Other Services'].obs;
  RxString selectedPreferredServices = ''.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController aboutYouController = TextEditingController();

  RxBool isAboutYouEmpty = false.obs;
  RxBool isSelectedLanguagesEmpty = false.obs;

  bool isUnitTest = false;
  AppController({
    required this.isUnitTest,
  });
  final formKeyStepTwo = GlobalKey<FormState>();
  final formKeyStepThree = GlobalKey<FormState>();

  void selectGender(int index) {
    selectedGender.value = index;
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(1970),
        lastDate: DateTime(2022),
      );

  void selectDateMobile(DateTime? date) {
    if (date == null) {
      return;
    } else if (date != selectedDate.value) {
      selectedDate.value = date;
    }
  }

  void selectDateWeb(String date) {
    selectedDateString.value = date;
  }

  Future<void> pickImage() async {
    if (GetPlatform.isWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var file = await image.readAsBytes();
        webImage.value = file;
        pickedFile.value = File('a');
      }
    } else {
      debugPrint('not selected image');
    }
  }

  Future<void> showMultiSelect({required BuildContext context, required Size size}) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
            height: size.width * 0.3,
            width: size.width * 0.3,
            items: listLanguage.map((e) => MultiSelectItem(e, e)).toList(),
            initialValue: selectedLanguages,
            onConfirm: (values) {
              selectedLanguages.value = values;
              if (context.canPop()) {
                context.pop();
              }
            });
      },
    );
  }

  void resetController() {
    fullNameController.clear();
    phoneController.clear();
    occupationController.clear();
    aboutYouController.clear();
    selectedLanguages.clear();
    selectedPreferredServices.value = '';
    selectedGender.value = -1;
    selectedDate.value = DateTime.now();
    selectedDateString.value = '';
    selectedCountryCode.value = '+62';
    findLocation.value = '';
    webImage.value = Uint8List(8);
    pickedFile.value = null;
  }

  @override
  void onInit() async {
    if (!isUnitTest) {
      await LocationServices.initService().then((_) async {
        return await LocationServices.checkPermission().then((_) async => await LocationServices.checkServiceEnable()
            .then((_) async => LocationServices.getLocation().then((_) async {
                  if (LocationServices.locationData != null) {
                    // get city and country
                    await HttpServices.getCityAndCountry().then((value) {
                      final resultLocation = value;

                      if (resultLocation == ', Indonesia') {
                        findLocation.value = '';
                        return;
                      }
                      findLocation.value = value;
                      debugPrint('findLocation: $findLocation');
                    });
                  }
                })));
      });
    }
    super.onInit();
  }
}
