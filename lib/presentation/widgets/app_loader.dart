import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader {
  static void show(BuildContext context) {
    context.loaderOverlay.show();
  }

  static void hide(BuildContext context) {
    context.loaderOverlay.hide();
  }

  static Widget overlayWidget() {
    return const Center(
      child: SpinKitFadingCircle(color: Colors.white, size: 50),
    );
  }

  static Widget wrap({required Widget child}) {
    return LoaderOverlay(
      // ignore: deprecated_member_use
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) => overlayWidget(),
      child: child,
    );
  }
}
