import 'package:flutter/material.dart';

import '../core_ui.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isActive;
  final void Function(bool isActive) onChanged;

  const CustomCheckbox({
    required this.isActive,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);
    return SizedBox(
      height: 22,
      width: 22,
      child: Checkbox(
        side: BorderSide(width: 1.5, color: colors.grey300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius5),
        ),
        value: isActive,
        activeColor: colors.secondary400base,
        onChanged: (bool? value) {
          onChanged(value ?? false);
        },
      ),
    );
  }
}
