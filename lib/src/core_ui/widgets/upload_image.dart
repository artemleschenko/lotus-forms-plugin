import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core_ui.dart';

class UploadImage extends StatefulWidget {
  final String? title;
  final String? hint;
  final String errorText;
  final Widget? image;
  final ValueChanged<XFile>? onImageSelected;
  final bool isRequired;
  final bool isDisabled;
  final double height;
  final double width;

  const UploadImage({
    this.title,
    this.hint,
    this.errorText = '',
    this.image,
    this.onImageSelected,
    this.isRequired = false,
    this.isDisabled = false,
    this.height = 100,
    this.width = 100,
    super.key,
  });

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    Widget? content;
    if (_imageFile != null) {
      content = Image.file(
        File(_imageFile!.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (widget.image != null) {
      content = widget.image;
    } else {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.image,
              color: widget.isDisabled ? colors.grey300 : colors.grey400,
              size: 24,
            ),
            if (widget.hint != null) ...<Widget>[
              const SizedBox(height: AppDimens.padding4),
              Text(
                widget.hint!,
                style: AppFonts.normal12.copyWith(
                  color: widget.isDisabled ? colors.grey300 : colors.grey400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    }

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
          onTap: widget.isDisabled ? null : _pickImage,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: widget.height,
            width: widget.width,
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
            clipBehavior: Clip.hardEdge,
            child: content,
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
