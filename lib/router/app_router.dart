import 'package:ayiconnect_web/pages/page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controller/app_controller.dart';
import '../pages/page1.dart';
import '../pages/page2.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/page1',
        name: 'page1',
        builder: (context, state) {
          final appController = Get.find<AppController>();
          appController.stepOne.value = true;
          appController.stepOneDone.value = false;
          appController.stepTwo.value = false;
          appController.stepTwo.value = false;
          appController.stepThree.value = false;
          appController.stepThreeDone.value = false;
          return const PageOne();
        },
      ),
      GoRoute(
        path: '/page2',
        name: 'page2',
        builder: (context, state) {
          final appController = Get.find<AppController>();
          appController.stepOne.value = true;
          appController.stepOneDone.value = true;
          appController.stepTwo.value = true;
          appController.stepTwoDone.value = false;
          appController.stepThree.value = false;
          appController.stepThreeDone.value = false;
          return const PageTwo();
        },
      ),
      GoRoute(
        path: '/page3',
        name: 'page3',
        builder: (context, state) {
          final appController = Get.find<AppController>();

          appController.stepOne.value = true;
          appController.stepOneDone.value = true;
          appController.stepTwo.value = true;
          appController.stepTwoDone.value = true;
          appController.stepThree.value = false;
          appController.stepThreeDone.value = false;
          return const PageThree();
        },
      ),
    ],
    errorBuilder: (context, state) {
      // use a post frame callback to perform your navigation after
      // the build frame has finished
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        router.go('/');
      });

      // you must return a widget anyway
      return const SizedBox.shrink();
    },
    initialLocation: '/page1',

    // turn off the # in the URLs on the web
    urlPathStrategy: UrlPathStrategy.path,
    redirect: (state) {
      final query = state.queryParams['isRegistered'];
      if (query == 'true') {
        return '/page1';
      } else if (state.location == '/') {
        return '/page1';
      }
      return null;
    },
    // routerNeglect: true,
    // TODO: how to handle navigation history? clear etc.
  );
}
