import 'package:flutter/material.dart';

class AppResponsiveWrapper extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget desktopScaffold;
  const AppResponsiveWrapper({
    Key? key,
    required this.mobileScaffold,
    required this.desktopScaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileScaffold;
      } else {
        return desktopScaffold;
      }
    }));
  }
}
