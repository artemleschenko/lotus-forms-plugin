import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';

import '../core_ui.dart';

class AppUploadImageField extends FormField<XFile> {
  final String? title;
  final String? hint;
  final bool isRequired;
  final bool isDisabled;
  final double height;
  final double width;
  final Widget? placeholderImage;
  final ValueChanged<XFile>? onImageSelected;

  AppUploadImageField({
    super.key,
    this.title,
    this.hint,
    this.isRequired = false,
    this.isDisabled = false,
    this.height = 150,
    this.width = double.infinity,
    this.placeholderImage,
    this.onImageSelected,
    super.onSaved,
    super.validator,
    super.initialValue,
  }) : super(
         builder: (FormFieldState<XFile> state) {
           final AppColors colors = AppColors.of(state.context);

           Future<void> pickImage() async {
             final ImagePicker picker = ImagePicker();
             final XFile? image = await picker.pickImage(
               source: ImageSource.gallery,
             );

             if (image != null) {
               state.didChange(image);
               onImageSelected?.call(image);
             }
           }

           Widget content;
           if (state.value != null) {
             content = kIsWeb
                 ? Image.network(
                     state.value!.path,
                     fit: BoxFit.cover,
                     width: double.infinity,
                     height: double.infinity,
                   )
                 : Image.file(
                     File(state.value!.path),
                     fit: BoxFit.cover,
                     width: double.infinity,
                     height: double.infinity,
                   );
           } else if (placeholderImage != null) {
             content = placeholderImage;
           } else {
             content = Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Icon(
                     Icons.image,
                     color: isDisabled ? colors.grey300 : colors.grey400,
                     size: 24,
                   ),
                   if (hint != null) ...<Widget>[
                     const SizedBox(height: AppDimens.padding4),
                     Text(
                       hint,
                       style: AppFonts.normal12.copyWith(
                         color: isDisabled ? colors.grey300 : colors.grey400,
                       ),
                       textAlign: TextAlign.center,
                     ),
                   ],
                 ],
               ),
             );
           }

           return FieldWrapper(
             title: title,
             isRequired: isRequired,
             errorText: state.errorText,
             child: InkWell(
               onTap: isDisabled ? null : pickImage,
               borderRadius: BorderRadius.circular(6),
               child: Container(
                 height: height,
                 width: width,
                 decoration: BoxDecoration(
                   color: isDisabled ? colors.grey50 : null,
                   border: Border.all(
                     color: isDisabled
                         ? colors.grey200
                         : state.hasError
                         ? colors.error
                         : colors.grey300,
                   ),
                   borderRadius: BorderRadius.circular(6),
                 ),
                 clipBehavior: Clip.hardEdge,
                 child: content,
               ),
             ),
           );
         },
       );
}
