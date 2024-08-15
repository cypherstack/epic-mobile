import 'dart:async';
import 'dart:math';

import 'package:epicpay/utilities/logger.dart';
import 'package:epicpay/utilities/theme/stack_colors.dart';
import 'package:epicpay/widgets/background.dart';
import 'package:epicpay/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<StackColors>()!.background,
        body: Container(
          color: Theme.of(context).extension<StackColors>()!.background,
          child: Center(
            child: SizedBox(
              width: min(size.width, size.height) * 0.5,
              child: const LoadingIndicator(),
            ),
            // child: Image(
            //   image: AssetImage(
            //     Assets.png.splash,
            //   ),
            //   width: MediaQuery.of(context).size.width * 0.5,
            // ),
          ),
        ),
      ),
    );
  }
}

Future<T> minWaitFuture<T>(
  Future<T> future, {
  required Duration delay,
}) async {
  final results = await Future.wait(
    [
      future,
      Future<dynamic>.delayed(delay),
    ],
  );

  return results.first as T;
}

Future<T?> showLoading<T>({
  required Future<T> whileFuture,
  required BuildContext context,
  bool rootNavigator = false,
  bool opaqueBG = false,
  void Function(Exception)? onException,
  Duration? delay,
  Duration? timeout,
}) async {
  final size = MediaQuery.of(context).size;
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: Theme.of(context)
              .extension<StackColors>()!
              .overlay
              .withOpacity(opaqueBG ? 1.0 : 0.6),
          child: Center(
            child: SizedBox(
              width: min(size.width, size.height) * 0.5,
              child: const LoadingIndicator(),
            ),
          ),
        ),
      ),
    ),
  );

  Exception? ex;
  T? result;

  try {
    if (delay != null) {
      result = timeout == null
          ? await minWaitFuture<T?>(whileFuture, delay: delay)
          : await minWaitFuture(whileFuture, delay: delay).timeout(timeout,
              onTimeout: () => throw Exception("showLoading timed out"));
    } else {
      result = timeout == null
          ? await whileFuture
          : await whileFuture.timeout(timeout,
              onTimeout: () => throw Exception("showLoading timed out"));
    }
  } catch (e, s) {
    Logging.instance.log(
      "showLoading caught: $e\n$s",
      level: LogLevel.Warning,
    );
    ex = e is Exception ? e : Exception(e.toString());
  }

  if (context.mounted) {
    Navigator.of(context, rootNavigator: rootNavigator).pop();
    if (ex != null) {
      onException?.call(ex);
    }
  }

  return result;
}
