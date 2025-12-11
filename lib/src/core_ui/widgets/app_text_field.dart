import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core_ui.dart';


class AppTextField extends StatelessWidget {
  final String? title;
  final String? hint;
  final String errorText;
  final Widget? postfixIcon;
  final TextEditingController? controller;
  final List<TextInputFormatter> formatters;
  final int? maxlines;
  final int? maxLength;

  final Color? fillColor;

  final bool isObscured;
  final bool isRequired;
  final bool isDisabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;

  final ValueChanged<String>? onChanged;

  const AppTextField({
    this.hint,
    this.title,
    this.formatters = const <TextInputFormatter>[],
    this.maxlines = 1,
    this.isObscured = false,
    this.isRequired = false,
    this.isDisabled = false,
    this.postfixIcon,
    this.errorText = '',
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.onChanged,
    this.maxLength,
    this.fillColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...[
          RichText(
            text: TextSpan(
              text: title,
              style: AppFonts.medium14.copyWith(
                color: colors.black,
              ),
              children: isRequired
                  ? <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          ' *',
                          style: AppFonts.medium14.copyWith(
                            color: colors.error400base,
                          ),
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(
            height: AppDimens.padding4,
          ),
        ],
        TextField(
          controller: controller,
          obscureText: isObscured,
          readOnly: isDisabled,
          maxLines: maxlines,
          inputFormatters: <TextInputFormatter>[
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
            ...formatters,
          ],
          style: AppFonts.normal14.copyWith(
            color: isDisabled ? colors.grey500 : colors.black,
          ),
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          onChanged: onChanged,
          cursorColor: colors.black,
          decoration: InputDecoration(
            fillColor: isDisabled ? colors.grey50 : fillColor,
            filled: isDisabled || fillColor != null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppDimens.padding8,
              horizontal: AppDimens.padding12,
            ),
            suffixIconConstraints: const BoxConstraints(),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: postfixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.padding8,
                    ),
                    child: postfixIcon,
                  )
                : null,
            hintText: hint,
            hintStyle: AppFonts.normal14.copyWith(
              color: colors.grey400,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDisabled ? colors.grey200 : errorText.isEmpty ? colors.grey300 : colors.error,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDisabled ? colors.grey200 : errorText.isEmpty ? colors.grey300 : colors.error,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDisabled ? colors.grey200 : errorText.isEmpty ? colors.secondary : colors.error,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: colors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: colors.error,
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty) ...<Widget>[
          const SizedBox(
            height: AppDimens.padding4,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimens.padding4,
            ),
            child: Text(
              errorText,
              style: AppFonts.normal14.copyWith(
                color: colors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
