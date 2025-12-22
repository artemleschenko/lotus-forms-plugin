import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';
import '../../core_ui/core_ui.dart';

class AppSingleChoice<T> extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final List<T> options;
  final String Function(T) labelBuilder;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;

  const AppSingleChoice({
    required this.options,
    required this.labelBuilder,
    this.title,
    this.isRequired = false,
    this.initialValue,
    this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return FormField<T>(
      initialValue: initialValue,
      validator: validator,
      builder: (FormFieldState<T> state) {
        return FieldWrapper(
          title: title,
          isRequired: isRequired,
          errorText: state.errorText,
          child: RadioGroup<T>(
            groupValue: state.value,
            onChanged: (T? newValue) {
              state.didChange(newValue);
              onChanged?.call(newValue);
            },
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: AppDimens.padding16,
              runSpacing: AppDimens.padding8,
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    state.didChange(option);
                    onChanged?.call(option);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 22,
                        width: 22,
                        child: Radio<T>(
                          value: option,
                          activeColor: colors.secondary400base,
                        ),
                      ),
                      const SizedBox(width: AppDimens.padding8),
                      Text(
                        labelBuilder(option),
                        style: AppFonts.normal14.copyWith(color: colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
