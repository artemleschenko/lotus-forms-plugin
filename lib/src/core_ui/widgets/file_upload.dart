import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';

import '../core_ui.dart';

class AppFileUploadField extends FormField<PlatformFile> {
  final String? title;
  final String? hint;
  final bool isRequired;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<PlatformFile>? onFileSelected;

  AppFileUploadField({
    super.key,
    this.title,
    this.hint,
    this.isRequired = false,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onFileSelected,
    super.onSaved,
    super.validator,
    super.initialValue,
  }) : super(
         builder: (FormFieldState<PlatformFile> state) {
           final AppColors colors = AppColors.of(state.context);

           Future<void> pickFile() async {
             final FilePickerResult? result = await FilePicker.platform
                 .pickFiles();

             if (result != null) {
               final PlatformFile file = result.files.single;
               state.didChange(file);
               onFileSelected?.call(file);
             }
           }

           return FieldWrapper(
             title: title,
             isRequired: isRequired,
             errorText: state.errorText,
             child: InkWell(
               onTap: isDisabled ? null : pickFile,
               borderRadius: BorderRadius.circular(6),
               child: Container(
                 padding: const EdgeInsets.symmetric(
                   vertical: AppDimens.padding12,
                   horizontal: AppDimens.padding12,
                 ),
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
                 child: Row(
                   children: <Widget>[
                     if (prefixIcon != null) ...<Widget>[
                       prefixIcon,
                       const SizedBox(width: AppDimens.padding8),
                     ],
                     Expanded(
                       child: Text(
                         state.value?.name ?? hint ?? '',
                         style: AppFonts.normal14.copyWith(
                           color: state.value != null
                               ? (isDisabled ? colors.grey500 : colors.black)
                               : colors.grey400,
                         ),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                       ),
                     ),
                     if (suffixIcon != null) ...<Widget>[
                       const SizedBox(width: AppDimens.padding8),
                       suffixIcon,
                     ] else
                       Icon(
                         Icons.upload_file,
                         color: isDisabled ? colors.grey300 : colors.grey500,
                         size: 20,
                       ),
                   ],
                 ),
               ),
             ),
           );
         },
       );
}
