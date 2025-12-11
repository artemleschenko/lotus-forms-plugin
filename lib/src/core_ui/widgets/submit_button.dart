import 'package:flutter/material.dart';

import '../core_ui.dart';


class SubmitButton extends StatelessWidget {
  final String submitText;
  final String? inactiveTapText;
  final Widget? icon;

  final bool isActive;
  final bool isLoading;
  final bool isExpanded;

  final Color? color;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final double? height;

  final VoidCallback onSubmit;

  const SubmitButton({
    required this.submitText,
    required this.isActive,
    required this.onSubmit,
    this.inactiveTapText,
    this.height,
    this.icon,
    this.color,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppDimens.padding10,
    ),
    this.isLoading = false,
    this.isExpanded = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 200,
      ),
      child: Material(
        key: ValueKey<bool>(isActive),
        color: isActive ? (color ?? colors.secondary400base) : colors.grey300,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: InkWell(
          onTap: onSubmit,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: Container(
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(8),
            ),
            child: _ExpandableContent(
              submitText: submitText,
              icon: icon,
              isLoading: isLoading,
              isExpanded: isExpanded,
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandableContent extends StatelessWidget {
  final String submitText;
  final Widget? icon;

  final bool isLoading;
  final bool isExpanded;

  const _ExpandableContent({
    required this.submitText,
    required this.icon,
    required this.isLoading,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Center(
            child: _Content(
              submitText: submitText,
              icon: icon,
              isLoading: isLoading,
            ),
          )
        : _Content(
            submitText: submitText,
            icon: icon,
            isLoading: isLoading,
          );
  }
}

class _Content extends StatelessWidget {
  final String submitText;
  final Widget? icon;
  final bool isLoading;

  const _Content({
    required this.submitText,
    required this.icon,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return isLoading
        ? const SizedBox(
            width: AppDimens.radius15,
            height: AppDimens.radius15,
            child: CircularProgressIndicator(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                icon!,
                const SizedBox(width: AppDimens.padding2),
              ],
              Text(
                submitText,
                style: AppFonts.semiBold14.copyWith(
                  color: colors.white,
                ),
              ),
            ],
          );
  }
}
