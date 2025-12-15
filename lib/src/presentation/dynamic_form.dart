import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/core/core.dart';
import 'screens/forms_screen.dart';

class DynamicForms extends StatefulWidget {
  const DynamicForms({super.key, required this.formId, required this.jwtToken});

  final String formId;
  final String jwtToken;

  @override
  State<DynamicForms> createState() => _DynamicFormsState();
}

class _DynamicFormsState extends State<DynamicForms> {
  @override
  void initState() {
    super.initState();
    AppDI.init(token: widget.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    return FormIdProvider(formId: widget.formId, child: const FormsScreen());
  }
}

class FormIdProvider extends InheritedWidget {
  const FormIdProvider({super.key, required this.child, required this.formId})
    : super(child: child);

  final Widget child;
  final String formId;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static String of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormIdProvider>()!.formId;
  }

  @override
  bool updateShouldNotify(covariant FormIdProvider oldWidget) {
    return oldWidget.formId != formId;
  }
}
