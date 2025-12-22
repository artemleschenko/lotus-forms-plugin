import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';
import '../../core_ui/core_ui.dart';

class AppMultipleChoice<T> extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final List<T> options;
  final String Function(T) labelBuilder;
  final List<T>? initialValue;
  final ValueChanged<List<T>>? onChanged;
  final String? Function(List<T>?)? validator;

  const AppMultipleChoice({
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

    return FormField<List<T>>(
      initialValue: initialValue ?? [],
      validator: validator,
      builder: (FormFieldState<List<T>> state) {
        final currentValues = state.value ?? [];

        return FieldWrapper(
          title: title,
          isRequired: isRequired,
          errorText: state.errorText,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: AppDimens.padding16,
            runSpacing: AppDimens.padding8,
            children: options.map((option) {
              final isChecked = currentValues.contains(option);
              return GestureDetector(
                onTap: () {
                  final newList = List<T>.from(currentValues);
                  isChecked ? newList.remove(option) : newList.add(option);
                  state.didChange(newList);
                  onChanged?.call(newList);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckbox(
                      isActive: isChecked,
                      onChanged: (active) {
                        final newList = List<T>.from(currentValues);
                        active ? newList.add(option) : newList.remove(option);
                        state.didChange(newList);
                        onChanged?.call(newList);
                      },
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
        );
      },
    );
  }
}
