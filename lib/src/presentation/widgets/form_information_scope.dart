import 'package:flutter/material.dart';

class FormInformationScope extends InheritedWidget {
  const FormInformationScope({
    super.key,
    required super.child,
    required this.id,
  });

  final String id;

  static FormInformationScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormInformationScope>()!;
  }

  @override
  bool updateShouldNotify(covariant FormInformationScope oldWidget) =>
      oldWidget.id != id;
}
