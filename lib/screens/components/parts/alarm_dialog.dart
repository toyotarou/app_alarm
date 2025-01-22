// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../../../extensions/extensions.dart';
import '../../home_screen.dart';

Future<void> AlarmDialog({
  required BuildContext context,
  required Widget widget,
  double paddingTop = 0,
  double paddingRight = 0,
  double paddingBottom = 0,
  double paddingLeft = 0,
  bool clearBarrierColor = false,
  bool? executeFunctionWhenDialogClose,
  Isar? isar,
  DateTime? date,
}) {
  // ignore: inference_failure_on_function_invocation
  return showDialog(
    context: context,
    barrierColor: clearBarrierColor ? Colors.transparent : Colors.blueGrey.withOpacity(0.3),
    builder: (_) {
      return Container(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight, bottom: paddingBottom, left: paddingLeft),
        child: Dialog(
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: const EdgeInsets.all(30),
          child: widget,
        ),
      );
    },
    // ignore: always_specify_types
  ).then((value) {
    // ignore: use_if_null_to_convert_nulls_to_bools
    if (executeFunctionWhenDialogClose == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ModalRoute<Object?>? route = ModalRoute.of(context);
        if (route != null && route.isCurrent) {
          if (isar != null && date != null) {
            Navigator.pushReplacement(
              context,
              // ignore: inference_failure_on_instance_creation, always_specify_types
              MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(isar: isar, baseYm: date.yyyymm),
              ),
            );
          }
        }
      });
    }
  });
}
