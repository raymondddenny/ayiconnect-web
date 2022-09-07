import 'package:ayiconnect_web/controller/app_controller.dart';
import 'package:ayiconnect_web/responsive/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../widgets/app_body.dart';

class PageOne extends GetView<AppController> {
  const PageOne({Key? key}) : super(key: key);

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
      stepperBody: PageOneBody(),
    );
  }
}

class PageOneBody extends GetView<AppController> {
  const PageOneBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 210, right: 210, top: 50, bottom: 50),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('search.png'), fit: BoxFit.cover),
                  ),
                ),
                const Text(
                  'Are you seeking care for your love one?',
                  style: TextStyle(fontSize: 28),
                ),
                const Spacer(),
                SizedBox(
                  height: 48,
                  width: size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.stepOneDone.value = true;
                      controller.stepTwo.value = true;
                      context.goNamed('page2');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    child: const Text('Find a helper'),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('portfolio.png'), fit: BoxFit.cover),
                  ),
                ),
                const Text(
                  'Or you\'re looking for a care, housekeeper, or tutor job?',
                  style: TextStyle(fontSize: 28),
                ),
                const Spacer(),
                SizedBox(
                  height: 48,
                  width: size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.stepOneDone.value = true;
                      controller.stepTwo.value = true;
                      context.goNamed('page2');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    child: const Text('Find a helper'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
