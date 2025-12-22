import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';

import '../../core/core.dart';
import '../theme/theme.dart';
import 'app_text_field.dart';

enum AppDateTimeFieldType { date, time }

class AppDateTimeField extends StatelessWidget {
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
  final String? Function(DateTime?)? validator;

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
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors.of(context);

    return FormField<DateTime>(
      validator: validator,
      initialValue: dateTime,
      builder: (FormFieldState<DateTime> state) {
        final String textValue = state.value != null
            ? _dateFormat().format(state.value!)
            : '';

        return FieldWrapper(
          title: title,
          isRequired: isRequired,
          errorText: state.errorText,
          child: Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              GestureDetector(
                onTap: isDisabled ? null : () => _showDialog(context, state),
                child: AbsorbPointer(
                  child: AppTextField(
                    hint: hint,
                    isRequired: isRequired,
                    isDisabled: isDisabled,
                    fillColor: fillColor,
                    controller: TextEditingController(text: textValue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: textValue.isNotEmpty && !isDisabled
                    ? IconButton(
                        onPressed: () {
                          state.didChange(null);
                          onClear?.call();
                        },
                        icon: SvgPicture.asset(
                          AppImages.cross,
                          package: 'lotus_forms_package',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            colors.grey500,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: isDisabled
                            ? null
                            : () => _showDialog(context, state),
                        icon: SvgPicture.asset(
                          _postfixIcon(),
                          package: 'lotus_forms_package',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            colors.grey500,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _postfixIcon() {
    return switch (type) {
      AppDateTimeFieldType.date => AppImages.calendar,
      AppDateTimeFieldType.time => AppImages.clock,
    };
  }

  DateFormat _dateFormat() {
    return switch (type) {
      AppDateTimeFieldType.date => DateFormat(DateFormatConsts.MM_dd_yyyy),
      AppDateTimeFieldType.time => DateFormat(DateFormatConsts.hh_mm_a),
    };
  }

  Future<void> _showDialog(
    BuildContext context,
    FormFieldState<DateTime> state,
  ) async {
    final isCupertino =
        !kIsWeb && Theme.of(context).platform == TargetPlatform.iOS;
    final DateTime initial = state.value ?? initialDate ?? DateTime.now();
    final colors = AppColors.of(context);

    if (isCupertino) {
      // IOS
      DateTime selected = initial;
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                initialDateTime: selected,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                mode: type == AppDateTimeFieldType.date
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime value) => selected = value,
              ),
            ),
          );
        },
      );
      state.didChange(selected);
      onChanged.call(selected);
    } else {
      // Android, Desktop, Web
      Widget themeBuilder(BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colors.secondary400base,
              onPrimary: colors.white,
              onSurface: colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colors.secondary400base,
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius10),
              ),
              dividerColor: colors.grey100,
            ),
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radius10),
              ),
            ),
          ),
          child: child!,
        );
      }

      if (type == AppDateTimeFieldType.date) {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: minimumDate ?? DateTime(1900),
          lastDate: maximumDate ?? DateTime(2100),
          builder: themeBuilder,
        );
        if (picked != null) {
          state.didChange(picked);
          onChanged.call(picked);
        }
      } else {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initial),
          builder: themeBuilder,
        );
        if (picked != null) {
          final now = DateTime.now();
          final result = DateTime(
            now.year,
            now.month,
            now.day,
            picked.hour,
            picked.minute,
          );
          state.didChange(result);
          onChanged.call(result);
        }
      }
    }
  }
}
