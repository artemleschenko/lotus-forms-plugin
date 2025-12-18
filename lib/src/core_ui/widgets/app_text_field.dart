import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../presentation/widgets/form_field_wrapper.dart';
import '../core_ui.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final String? hint;
  final Widget? postfixIcon;
  final TextEditingController? controller;
  final List<TextInputFormatter> formatters;
  final int? maxlines;
  final int? maxLength;
  final String? Function(String?)? validator;
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
    this.validator,
    this.maxlines = 1,
    this.isObscured = false,
    this.isRequired = false,
    this.isDisabled = false,
    this.postfixIcon,
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

    return FormField<String>(
      validator: validator,
      initialValue: controller?.text,
      builder: (FormFieldState<String> state) {
        return FieldWrapper(
          title: title,
          isRequired: isRequired,
          errorText: state.errorText,
          child: TextFormField(
            controller: controller,
            obscureText: isObscured,
            readOnly: isDisabled,
            maxLines: maxlines,
            inputFormatters: <TextInputFormatter>[
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
              ...formatters,
            ],
            style: AppFonts.normal14.copyWith(
              color: isDisabled ? colors.grey500 : colors.black,
            ),
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            onChanged: (String value) {
              state.didChange(value);
              onChanged?.call(value);
            },
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
              hintStyle: AppFonts.normal14.copyWith(color: colors.grey400),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              enabledBorder: _outlineBorder(
                isDisabled
                    ? colors.grey200
                    : (state.hasError ? colors.error : colors.grey300),
              ),
              border: _outlineBorder(
                isDisabled
                    ? colors.grey200
                    : (state.hasError ? colors.error : colors.grey300),
              ),
              focusedBorder: _outlineBorder(
                isDisabled
                    ? colors.grey200
                    : (state.hasError ? colors.error : colors.secondary),
              ),
              errorBorder: _outlineBorder(colors.error),
              focusedErrorBorder: _outlineBorder(colors.error),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color),
    );
  }
}
