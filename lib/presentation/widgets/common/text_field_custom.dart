import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boilerplate/foundation/helpers/classes/sized_boxes.dart';
import 'package:boilerplate/supplies/constants/theme_globals.dart';

class TextFieldCustom extends StatefulWidget {
  final String? labelText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final double paddingBottom;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final Icon? prefixIcon;
  final Color borderColor;
  final Color labelColor;
  final void Function()? onTap;
  final bool showInputTitle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? inputFillColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final List<Widget>? leftChildren;
  final String? placeholder;
  final Color placeholderColor;
  final double placeholderFontSize;
  final FontWeight placeholderFontWeight;
  final List<String>? autofillHints;
  final int textFieldMaxLines;
  final bool alignLabelWithHint;
  final String? labelDescription;
  final double labelDescriptionFontSize;
  final FontWeight labelDescriptionFontWeight;
  final double hintLetterSpacing;
  final TextDecoration labelTextDecoration;
  final double textFieldBorderWidth;
  final int labelTextMaxLines;
  final bool isLastInput;
  final bool showOverlay;
  final bool? isBottomPanel;

  const TextFieldCustom({
    super.key,
    required this.labelText,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.obscureText = false,
    this.enabled = true,
    this.paddingBottom = 20.0,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.inputFormatters,
    this.hint = '',
    this.prefixIcon,
    this.onTap,
    this.borderColor = grey400Color,
    this.labelColor = grey400Color,
    this.showInputTitle = false,
    this.floatingLabelBehavior,
    this.inputFillColor,
    this.labelFontSize = 14.0,
    this.labelFontWeight = FontWeight.normal,
    this.leftChildren,
    this.placeholder,
    this.placeholderColor = grey400Color,
    this.placeholderFontSize = 14.0,
    this.placeholderFontWeight = FontWeight.normal,
    this.autofillHints,
    this.textFieldMaxLines = 1,
    this.alignLabelWithHint = false,
    this.labelDescription,
    this.labelDescriptionFontSize = 12.0,
    this.labelDescriptionFontWeight = FontWeight.normal,
    this.hintLetterSpacing = 0,
    this.labelTextDecoration = TextDecoration.none,
    this.textFieldBorderWidth = 1.0,
    this.labelTextMaxLines = 2,
    this.isLastInput = false,
    this.showOverlay = true,
    this.isBottomPanel = false,
    error,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.showInputTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: AutoSizeText(
                      widget.labelText ?? '',
                      style: TextStyle(
                        fontSize: widget.labelFontSize,
                        fontWeight: widget.labelFontWeight,
                        color: showError ? errorColor : null,
                        decoration: widget.labelTextDecoration,
                      ),
                      maxLines: widget.labelTextMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Visibility(
                    visible: widget.leftChildren != null && widget.leftChildren!.isNotEmpty,
                    child: Flexible(
                      flex: 1,
                      child: Column(
                        children: widget.leftChildren ?? [],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox6(),
              Visibility(
                visible: widget.labelDescription != null && widget.labelDescription!.isNotEmpty,
                replacement: Container(),
                child: Column(
                  children: [
                    AutoSizeText(
                      widget.labelDescription ?? '',
                      style: TextStyle(
                        fontSize: widget.labelDescriptionFontSize,
                        fontWeight: widget.labelDescriptionFontWeight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox6(),
                  ],
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          onSaved: widget.onSaved,
          textInputAction: widget.textInputAction,
          validator: (value) {
            String? errorMessage = widget.validator != null ? widget.validator!(value) : null;

            if (errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    showError = true;
                  });
                }
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    showError = false;
                  });
                }
              });
            }

            return errorMessage;
          },
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          controller: widget.controller,
          cursorColor: primaryColor,
          cursorHeight: 17.0,
          onFieldSubmitted: widget.onFieldSubmitted,
          initialValue: widget.initialValue,
          onTap: () {
            Scrollable.ensureVisible(context, alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd);
            widget.onTap?.call();
          },
          autofillHints: widget.autofillHints,
          maxLines: widget.textFieldMaxLines,
          style: TextStyle(
            color: showError ? errorColor : null,
            fontSize: 14.0,
            height: 17 / 14,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            alignLabelWithHint: widget.alignLabelWithHint,
            hintStyle: TextStyle(
              color: widget.placeholderColor,
              fontSize: widget.placeholderFontSize,
              fontWeight: widget.placeholderFontWeight,
              letterSpacing: widget.hintLetterSpacing,
            ),
            suffixIcon: showError
                ? const Icon(
                    Icons.error_outline_rounded,
                    color: errorColor,
                    size: 20.0,
                  )
                : null,
            errorMaxLines: 3,
            errorStyle: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: errorColor,
            ),
            contentPadding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
            enabled: widget.enabled,
            labelText: widget.placeholder ?? widget.labelText,
            labelStyle: TextStyle(
              color: showError ? errorColor : widget.placeholderColor,
              fontSize: widget.placeholderFontSize,
              fontWeight: widget.placeholderFontWeight,
              letterSpacing: widget.hintLetterSpacing,
            ),
            prefixIcon: widget.prefixIcon,
            suffix: widget.suffixIcon,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            fillColor: widget.inputFillColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: primaryColor,
                width: widget.textFieldBorderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: widget.borderColor,
                width: 0.5,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: grey400Color,
                width: 0.5,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: errorColor,
                width: 0.5,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: errorColor,
                width: 0.5,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 0.5,
              ),
            ),
            focusColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
