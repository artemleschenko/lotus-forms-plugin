import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../core_ui.dart';

class FileUpload extends StatefulWidget {
  final String? title;
  final String? hint;
  final String errorText;
  final String? value;
  final ValueChanged<PlatformFile>? onFileSelected;
  final bool isRequired;
  final bool isDisabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const FileUpload({
    this.title,
    this.hint,
    this.errorText = '',
    this.value,
    this.onFileSelected,
    this.isRequired = false,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _fileName = widget.value;
  }

  @override
  void didUpdateWidget(covariant FileUpload oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _fileName = widget.value;
    }
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final PlatformFile file = result.files.single;
      setState(() {
        _fileName = file.name;
      });
      if (widget.onFileSelected != null) {
        widget.onFileSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              text: widget.title,
              style: AppFonts.medium14.copyWith(color: colors.black),
              children: widget.isRequired
                  ? <InlineSpan>[
                      WidgetSpan(
                        child: Text(
                          ' *',
                          style: AppFonts.medium14.copyWith(
                            color: colors.error400base,
                          ),
                        ),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: AppDimens.padding4),
        ],
        InkWell(
          onTap: widget.isDisabled ? null : _pickFile,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.padding12,
              horizontal: AppDimens.padding12,
            ),
            decoration: BoxDecoration(
              color: widget.isDisabled ? colors.grey50 : null,
              border: Border.fromBorderSide(
                BorderSide(
                  color: widget.isDisabled
                      ? colors.grey200
                      : widget.errorText.isEmpty
                      ? colors.grey300
                      : colors.error,
                ),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: <Widget>[
                if (widget.prefixIcon != null) ...<Widget>[
                  widget.prefixIcon!,
                  const SizedBox(width: AppDimens.padding8),
                ],
                Expanded(
                  child: Text(
                    _fileName ?? widget.hint ?? '',
                    style: AppFonts.normal14.copyWith(
                      color: _fileName != null
                          ? (widget.isDisabled ? colors.grey500 : colors.black)
                          : colors.grey400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.suffixIcon != null) ...<Widget>[
                  const SizedBox(width: AppDimens.padding8),
                  widget.suffixIcon!,
                ] else
                  Icon(
                    Icons.upload_file,
                    color: widget.isDisabled ? colors.grey300 : colors.grey500,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
        if (widget.errorText.isNotEmpty) ...<Widget>[
          const SizedBox(height: AppDimens.padding4),
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.padding4),
            child: Text(
              widget.errorText,
              style: AppFonts.normal14.copyWith(color: colors.error),
            ),
          ),
        ],
      ],
    );
  }
}
