import 'package:ayiconnect_web/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/app_controller.dart';

void main() {
  // setPathUrlStrategy();
  Get.put(AppController(isUnitTest: false));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
  }
}
