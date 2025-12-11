import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../core/core.dart';
import '../theme/theme.dart';
import 'app_text_field.dart';

enum AppDateTimeFieldType { date, time }

class AppDateTimeField extends StatefulWidget {
  final String hint;
  final String title;

  final DateTime? dateTime;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialDate;

  final bool isDisabled;
  final bool isRequired;
  final AppDateTimeFieldType type;

  final Color? fillColor;

  final ValueChanged<DateTime> onChanged;
  final VoidCallback? onClear;

  const AppDateTimeField({
    required this.hint,
    required this.title,
    required this.type,
    required this.onChanged,
    this.fillColor,
    this.dateTime,
    this.minimumDate,
    this.maximumDate,
    this.initialDate,
    this.isRequired = true,
    this.isDisabled = false,
    this.onClear,
    super.key,
  });

  @override
  State<AppDateTimeField> createState() => _AppDateTimeFieldState();
}

class _AppDateTimeFieldState extends State<AppDateTimeField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final DateTime? dateTime = widget.dateTime;
    _controller.text = dateTime != null ? _dateFormat().format(dateTime) : '';
  }

  @override
  void didUpdateWidget(covariant AppDateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.dateTime != widget.dateTime) {
      final DateTime? dateTime = widget.dateTime;
      _controller.text = dateTime != null ? _dateFormat().format(dateTime) : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: widget.isDisabled ? null : () => _showDialog(context),
          child: IgnorePointer(
            child: AppTextField(
              controller: _controller,
              isDisabled: widget.isDisabled,
              hint: widget.hint,
              title: widget.title,
              isRequired: widget.isRequired,
              fillColor: widget.fillColor,
            ),
          ),
        ),
        if (_controller.text.isNotEmpty)
          IconButton(
            onPressed: _clear,
            icon: SvgPicture.asset(
              AppImages.cross,
              package: 'lotus_forms_package',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                AppColors.of(context).grey500,
                BlendMode.srcIn,
              ),
            ),
          )
        else
          IconButton(
            onPressed: () => _showDialog(context),
            icon: SvgPicture.asset(
              _postfixIcon(),
              package: 'lotus_forms_package',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                AppColors.of(context).grey500,
                BlendMode.srcIn,
              ),
            ),
          ),
      ],
    );
  }

  String _postfixIcon() {
    return switch (widget.type) {
      AppDateTimeFieldType.date => AppImages.calendar,
      AppDateTimeFieldType.time => AppImages.clock,
    };
  }

  Future<void> _showDialog(BuildContext context) async {
    DateTime? dateTime;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        final CupertinoDatePickerMode mode = _pickerMode();
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime:
                  widget.dateTime ?? widget.initialDate ?? DateTime.now(),
              minimumDate: widget.minimumDate,
              maximumDate: widget.maximumDate,
              mode: mode,
              use24hFormat: false,
              showDayOfWeek: mode == CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime value) {
                dateTime = value;
              },
            ),
          ),
        );
      },
    );

    if (dateTime != null) {
      widget.onChanged.call(dateTime ?? widget.initialDate ?? DateTime.now());
    } else {
      if (_controller.text.isEmpty) {
        widget.onChanged.call(
          widget.dateTime ?? widget.initialDate ?? DateTime.now(),
        );
      }
    }
  }

  CupertinoDatePickerMode _pickerMode() {
    return switch (widget.type) {
      AppDateTimeFieldType.date => CupertinoDatePickerMode.date,
      AppDateTimeFieldType.time => CupertinoDatePickerMode.time,
    };
  }

  DateFormat _dateFormat() {
    return switch (widget.type) {
      AppDateTimeFieldType.date => DateFormat(DateFormatConsts.MM_dd_yyyy),
      AppDateTimeFieldType.time => DateFormat(DateFormatConsts.hh_mm_a),
    };
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
  }
}
