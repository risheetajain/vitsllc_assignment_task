import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/decoration.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  final String? title;
  final bool? isCompulsory;
  final TextEditingController? controller;
  final String? hintText;
  final String? counterText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? border;
  final Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChange;
  final void Function(String?)? onSubmitted;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int? maxLength;
  final int? minLength;
  final int? minLines;
  final int? maxLines;
  final bool isShowCounterText;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final TextStyle? titleStyle;
  final String? suffixText;
  final String? initialValue;
  final TextStyle? suffixStyle;
  final bool? filled;
  final Color? fillColor;
  final AutovalidateMode? autovalidateMode;

  const CustomTextFieldWithTitle({
    super.key,
    this.title,
    this.minLines,
    this.isCompulsory,
    this.controller,
    thisintText,
    this.counterText,
    this.keyboardType,
    this.textInputAction,
    this.textInputFormatter,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.border,
    this.onTap,
    this.onSaved,
    this.onChange,
    this.onSubmitted,
    this.validator,
    this.maxLines,
    this.readOnly = false,
    this.maxLength,
    this.minLength,
    this.isShowCounterText = false,
    this.textCapitalization,
    this.focusNode,
    this.titleStyle,
    this.suffixText,
    this.suffixStyle,
    this.initialValue,
    this.filled,
    this.fillColor,
    this.autovalidateMode,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: title != null && title!.isNotEmpty ? title! : '',
              children: [
                if (isCompulsory ?? false)
                  const TextSpan(text: "*", style: TextStyle(color: Colors.red))
              ]),
          style: titleStyle ??
              TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: 10),
        CustomTextField(
            controller: controller,
            hintText: hintText!,
            counterText: counterText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textInputFormatter: textInputFormatter,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            obscureText: obscureText,
            border: border,
            onTap: onTap,
            onSaved: onSaved,
            onChange: onChange,
            onSubmitted: onSubmitted,
            validator: validator,
            readOnly: readOnly,
            minLines: minLines,
            maxLength: maxLength,
            maxLines: maxLines,
            isShowCounterText: isShowCounterText,
            textCapitalization: textCapitalization,
            suffixStyle: suffixStyle,
            suffixText: suffixText,
            initialValue: initialValue,
            filled: filled,
            autovalidateMode: autovalidateMode,
            fillColor: fillColor),
        const SizedBox(height: 5),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? counterText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? border;
  final EdgeInsets? padding;
  final String? Function(String?)? validator;
  final Color? cursorColor;
  final InputDecoration? decoration;
  final bool? filled;
  final bool? isRequired;
  final double? height;
  final double? width;
  final int? maxLength;
  final TextDirection? textDirection;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChange;
  final void Function(String)? onSubmitted;
  final Function()? onTap;
  final bool readOnly;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization? textCapitalization;
  final bool isShowCounterText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Color? hintTextColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final String? initialValue;
  final Color? fillColor;
  final int? minLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    thisintText,
    this.counterText,
    thiseight,
    this.textInputAction,
    this.keyboardType,
    this.filled,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.border,
    this.padding,
    this.cursorColor,
    this.decoration,
    this.onSaved,
    this.validator,
    this.width,
    this.maxLength,
    this.textDirection,
    this.textInputFormatter,
    this.floatingLabelBehavior,
    this.maxLines,
    this.onChange,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.autovalidateMode,
    this.errorText,
    this.isRequired = false,
    this.textCapitalization,
    this.isShowCounterText = false,
    this.labelStyle,
    this.style,
    thisintTextColor,
    this.borderColor,
    this.focusedBorderColor,
    this.suffixText,
    this.suffixStyle,
    this.initialValue,
    this.fillColor,
    this.minLines,
    this.hintText,
    this.height,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters =
        (textInputFormatter != null && textInputFormatter!.isNotEmpty)
            ? [NoSpaceInputFormatter(), ...textInputFormatter!]
            : [NoSpaceInputFormatter()];
    return SizedBox(
      // height: height ?? 55,
      width: width,
      child: TextFormField(
        autofillHints: const [
          AutofillHints.name,
        ],
        style: style ??
            TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
        textAlign: TextAlign.start,
        cursorColor: cursorColor ?? Theme.of(context).colorScheme.onBackground,
        onSaved: onSaved,
        autofocus: false,
        expands: false,
        initialValue: initialValue,
        onChanged: onChange,
        onFieldSubmitted: onSubmitted,
        obscureText: obscureText ?? false,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        maxLength: maxLength,
        textDirection: textDirection,
        textInputAction: textInputAction ?? TextInputAction.next,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
        enableSuggestions: true,
        minLines: minLines,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        decoration: decoration ??
            inputdecoration(context).copyWith(
              labelText: hintText,
              suffixText: suffixText,
              suffixStyle: suffixStyle,

              counterText: isShowCounterText ? counterText : '',

              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              // hintStyle: Theme.of(context).textThemeeadlineSmall,
              errorText: errorText,
              // fillColor: Theme.of(context).colorScheme.onSurface,
              filled: filled ?? true,
              fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
            ),
      ),
    );
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == ' ') {
      return oldValue;
    }
    final trimmedText = newValue.text.trimLeft();

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: newValue.selection.baseOffset),
    );
  }
}
