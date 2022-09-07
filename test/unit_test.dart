import 'package:ayiconnect_web/controller/app_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.put(AppController(isUnitTest: true));
  });

  group('test account controller', () {
    setUp(() {});
    test(
      'should return app controller initial state',
      () async {
        // arrange

        final tc = Get.find<AppController>();
        // act

        // assert
        expect(tc.stepOne.value, true);
        expect(tc.stepOneDone.value, false);
        expect(tc.stepTwo.value, false);
        expect(tc.stepTwoDone.value, false);
        expect(tc.stepThree.value, false);
        expect(tc.stepThreeDone.value, false);
        expect(tc.selectedGender.value, -1);
        expect(tc.genders, ['Male', 'Female', 'Others']);
        expect(tc.selectedDateString.value, '');
        expect(tc.selectedCountryCode.value, '+62');
        expect(tc.findLocation.value, '');
        expect(tc.countryCode, ['+62', '+65', '+1']);
        expect(tc.findLocation.value, '');
        expect(tc.dummyLocation, ['Bandung, Indonesia', 'Tangerang, Indonesia', 'Jakarta, Indonesia']);
        expect(tc.pickedFile.value, null);
        expect(tc.listLanguage, ['English', 'Indonesia', 'Mandarin', 'German', 'Dutch', 'Spanish']);
        expect(tc.selectedLanguages, <String>[]);
        expect(tc.listLanguage, ['English', 'Indonesia', 'Mandarin', 'German', 'Dutch', 'Spanish']);
        expect(tc.preferredServices, ['Child Care', 'Senior Care', 'Home Care', 'Other Services']);
        expect(tc.selectedPreferredServices.value, '');
        expect(tc.isAboutYouEmpty.value, false);
        expect(tc.isSelectedLanguagesEmpty.value, false);
      },
    );
    test(
      'should reset field & state related to change pin',
      () async {
        // arrange
        final tc = Get.find<AppController>();

        // act
        tc.selectGender(1);

        // assert
        expect(tc.selectedGender.value, 1);
      },
    );
  });
}
