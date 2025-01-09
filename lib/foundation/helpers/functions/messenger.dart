import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/classes/sized_boxes.dart';
import 'package:serenita/presentation/widgets/common/button_custom.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';
import 'package:serenita/supplies/extensions/build_context_ext.dart';

Future<void> showStyledConfirmationDialog({
  required BuildContext? context,
  required Function onConfirmed,
  Function? onCanceled,
  String? confirmLabel,
  String? cancelLabel,
  String? message,
  Widget? icon,
  Color? confirmButtonColor,
}) async {
  message ??= 'sure_question';
  confirmLabel ??= 'yes';
  cancelLabel ??= 'cancel';

  final result = await showModal<bool>(
    context: context!,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: context.colorScheme.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: icon),
              const SizedBox8(),
              Center(
                child: Text(
                  message.toString(),
                  textAlign: TextAlign.center,
                  style: size16weight600.copyWith(height: 24 / 16),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Flexible(
                    child: ButtonCustom(
                      title: cancelLabel.toString(),
                      borderColor: primaryColor,
                      outline: true,
                      bgColor: context.colorScheme.surface,
                      textColor: primaryColor,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Flexible(
                    child: ButtonCustom(
                      title: confirmLabel.toString(),
                      bgColor: confirmButtonColor ?? primaryColor,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (result ?? false) {
    onConfirmed.call();
  } else {
    onCanceled?.call();
  }
}
