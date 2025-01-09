import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class ButtonCustom extends StatelessWidget {
  final String? title;
  final Color bgColor;
  final Color borderColor;
  final Color? textColor;
  final Function? onPressed;
  final bool? status;
  final bool disabled;
  final bool outline;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final Color disabledBorderColor;
  final Color disabledTextColor;
  final Color disabledBackgroundColor;
  final double borderRadius;
  final IconData? iconData;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsets? padding;
  final bool showRightIcon;
  final bool showLeftIcon;
  final Widget? buttonContentWidget;
  final String? trackEventName;
  final double borderWidth;
  final int titleMaxLines;
  final String? resourceID;
  final Image? imageIcon;

  const ButtonCustom({
    super.key,
    this.title,
    this.trackEventName,
    this.bgColor = primaryColor,
    this.textColor = whiteColor,
    this.borderColor = primaryColor,
    this.status = false,
    this.disabled = false,
    this.outline = false,
    required this.onPressed,
    this.fontSize = 14.0,
    this.height = 50.0,
    this.fontWeight = FontWeight.normal,
    this.width = double.infinity,
    this.disabledBorderColor = grey400Color,
    this.disabledTextColor = grey800Color,
    this.disabledBackgroundColor = grey200Color,
    this.borderRadius = 8.0,
    this.iconColor = whiteColor,
    this.iconSize = 16.0,
    this.iconData,
    this.padding,
    this.showLeftIcon = false,
    this.showRightIcon = false,
    this.buttonContentWidget,
    this.borderWidth = 1.0,
    this.titleMaxLines = 1,
    this.resourceID,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: resourceID ?? '',
      button: true,
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed: !disabled
              ? !status!
                  ? () {
                      // getIt<UtilsService>().hapticFeedbackMode(HapticFeedbackMode.Low);
                      onPressed!();
                    }
                  : null
              : null,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(disabled ? disabledBackgroundColor : bgColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                side: outline ? BorderSide(color: disabled ? disabledBorderColor : borderColor, width: borderWidth) : BorderSide.none,
              ),
            ),
          ),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: loadingButton(context),
          ),
        ),
      ),
    );
  }

  Widget loadingButton(BuildContext context) {
    if (status!) {
      return SizedBox(
        width: height * 0.35,
        height: height * 0.35,
        child: CircularProgressIndicator.adaptive(strokeWidth: 3, valueColor: AlwaysStoppedAnimation<Color?>(textColor)),
      );
    }

    if (buttonContentWidget != null) {
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: buttonContentWidget!,
          ),
        ],
      );
    }

    if (showLeftIcon || showRightIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: showRightIcon,
            replacement: Container(),
            child: Flexible(
              flex: 1,
              child: imageIcon != null
                  ? imageIcon!
                  : Icon(
                      iconData,
                      size: iconSize,
                      color: iconColor,
                    ),
            ),
          ),
          Visibility(
            visible: title != null && title!.isNotEmpty,
            child: Flexible(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(
                  left: showRightIcon ? 15.0 : 5.0,
                  right: showLeftIcon ? 15.0 : 5.0,
                ),
                child: AutoSizeText(
                  title ?? '',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: disabled ? disabledTextColor : textColor,
                    fontFamily: 'Urbanist',
                  ),
                  maxLines: titleMaxLines,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 11.0,
                ),
              ),
            ),
          ),
          Visibility(
            visible: showLeftIcon,
            replacement: Container(),
            child: Flexible(
              flex: 1,
              child: Icon(
                iconData,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ],
      );
    } else {
      return AutoSizeText(
        title ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: disabled ? disabledTextColor : textColor,
          fontFamily: 'Urbanist',
        ),
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
