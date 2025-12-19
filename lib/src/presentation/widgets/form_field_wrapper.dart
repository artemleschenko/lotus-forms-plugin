import 'package:flutter/material.dart';

import '../../core_ui/core_ui.dart';

class FieldWrapper extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final String? errorText;
  final Widget child;

  const FieldWrapper({
    super.key,
    this.title,
    this.isRequired = false,
    this.errorText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          RichText(
            text: TextSpan(
              text: title,
              style: AppFonts.medium14.copyWith(color: colors.black),
              children: isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: AppFonts.medium14.copyWith(
                          color: colors.error400base,
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: AppDimens.padding4),
        ],
        child,
        if (errorText != null && errorText!.isNotEmpty) ...[
          const SizedBox(height: AppDimens.padding4),
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.padding4),
            child: Text(
              errorText!,
              style: AppFonts.normal14.copyWith(color: colors.error),
            ),
          ),
        ],
      ],
    );
  }
}
