import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/core/core.dart';
import 'screens/forms_screen.dart';
import 'widgets/form_information_scope.dart';

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
    return FormInformationScope(id: widget.formId, child: const FormsScreen());
  }
}
