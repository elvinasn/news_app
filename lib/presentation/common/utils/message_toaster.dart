import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/presentation/common/router/router.dart';
import 'package:news_app/presentation/common/utils/extensions.dart';

enum ToastType {
  success,
  error,
}

class MessageToaster {
  static bool _isToastShown = false;
  static Timer? _timer;
  static FToast? _fToast;

  static void showMessage(
    String message,
    ToastType toastType, {
    int durationInSeconds = 3,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    try {
      final router = GetIt.I<AppRouter>();
      final context = router.router.routerDelegate.navigatorKey.currentContext;
      if (context == null) return;

      void hideToast() {
        _fToast?.removeCustomToast();
        _isToastShown = false;
        _timer?.cancel();
      }

      if (_isToastShown) {
        hideToast();
      }

      final Color iconColor;
      IconData toastIcon;
      switch (toastType) {
        case ToastType.success:
          iconColor = context.colors.green;
          toastIcon = Icons.check;

        case ToastType.error:
          iconColor = context.colors.red;
          toastIcon = Icons.error;
      }

      _fToast = FToast();
      _fToast!
          .init(router.router.routerDelegate.navigatorKey.currentContext!)
          .showToast(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: GestureDetector(
                onTap: hideToast,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  padding: const EdgeInsets.fromLTRB(16, 12, 14, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.white,
                    border: Border.all(
                      color: context.colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          toastIcon,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          message,
                          style: context.styles.body2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gravity: gravity,
            toastDuration: Duration(seconds: durationInSeconds),
          );

      _isToastShown = true;
      _timer = Timer.periodic(Duration(seconds: durationInSeconds), (timer) {
        _isToastShown = false;
        timer.cancel();
      });
    } catch (e) {
      return;
    }
  }
}
