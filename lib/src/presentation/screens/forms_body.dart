import 'package:flutter/material.dart';

import '../../core_ui/core_ui.dart';

class FormsBody extends StatelessWidget {
  const FormsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.of(context).primaryBg,
      child: ListView(
        shrinkWrap: true,
        children: [
          // TODO: Add real forms
          // Just a placeholder for now
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
