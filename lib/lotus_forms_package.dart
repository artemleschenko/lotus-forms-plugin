import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/core/core.dart';
import 'package:lotus_forms_package/src/core_ui/core_ui.dart';

class FormsRunnerWidget extends StatelessWidget {
  const FormsRunnerWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    AppDI.init();
    return Container(
      color: AppColors.of(context).primaryBg,
      child: ListView(
        shrinkWrap: true,
        children: [
          AppTextField(),
          AppTextField(),
          AppTextField(),
          AppDateTimeField(
            hint: 'hint',
            title: 'title',
            type: AppDateTimeFieldType.date,
            onChanged: (time) {},
          ),

          CustomCheckbox(isActive: true, onChanged: (value) {}),
          CustomCheckbox(isActive: false, onChanged: (value) {}),
          SubmitButton(submitText: 'Text', isActive: true, onSubmit: () {}),
        ],
      ),
    );
  }
}
