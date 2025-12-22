import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../core_ui/core_ui.dart';

class FormsBody extends StatefulWidget {
  const FormsBody({super.key});

  @override
  State<FormsBody> createState() => _FormsBodyState();
}

class _FormsBodyState extends State<FormsBody> {
  final SignatureController _controller = SignatureController();
  final _formKey = GlobalKey<FormState>();

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: implement onSubmit
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.of(context).primaryBg,
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.MARGIN_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimens.MARGIN_16,
              children: [
                AppDateTimeField(
                  title: "Date",
                  type: AppDateTimeFieldType.date,
                  isRequired: true,
                  hint: 'Date of birth',
                  validator: FormValidators.date,
                  onChanged: (DateTime value) {},
                ),
                AppTextField(
                  title: "Email",
                  hint: 'example@gmail.com',
                  isRequired: true,
                  validator: FormValidators.email,
                ),
                AppSignatureField(
                  title: "Signature",
                  isRequired: true,
                  controller: _controller,
                  validator: FormValidators.signature,
                ),
                AppFileUploadField(
                  title: "File",
                  isRequired: true,
                  validator: FormValidators.file,
                ),
                AppUploadImageField(
                  title: "Image",
                  isRequired: true,
                  validator: FormValidators.image,
                ),
                SubmitButton(
                  submitText: 'Submit Form',
                  onSubmit: onSubmit,
                  isActive: true,
                ),
                AppSingleChoice<String>(
                  isRequired: true,
                  title: "Select Plan",
                  options: ["Option 1", "Option 2", "Option 3"],
                  labelBuilder: (str) => str,
                  validator: (plan) =>
                      plan == null ? 'Selection required' : null,
                ),
                AppMultipleChoice<String>(
                  isRequired: false,
                  title: "Select Plan",
                  options: ["Option 1", "Option 2", "Option 3"],
                  labelBuilder: (str) => str,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
