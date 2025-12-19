import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lotus_forms_package/src/core_ui/theme/theme.dart';
import 'package:lotus_forms_package/src/presentation/widgets/form_field_wrapper.dart';

class SignatureController extends ChangeNotifier {
  final List<Offset?> _points = [];
  Color penColor;
  double strokeWidth;

  SignatureController({this.penColor = Colors.black, this.strokeWidth = 3.5});

  List<Offset?> get points => _points;

  bool get isEmpty => _points.isEmpty;

  void addPoint(Offset? point) {
    _points.add(point);
    notifyListeners();
  }

  void clear() {
    _points.clear();
    notifyListeners();
  }
}

class AppSignatureField extends FormField<List<Offset?>> {
  final String? title;
  final bool isRequired;
  final SignatureController controller;

  AppSignatureField({
    super.key,
    this.title,
    this.isRequired = false,
    required this.controller,
    super.onSaved,
    super.validator,
  }) : super(
         initialValue: controller.points,
         builder: (FormFieldState<List<Offset?>> state) {
           final AppColors colors = AppColors.of(state.context);

           return FieldWrapper(
             title: title,
             isRequired: isRequired,
             errorText: state.errorText,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Container(
                   height: 200,
                   decoration: BoxDecoration(
                     color: colors.primaryBg,
                     borderRadius: BorderRadius.circular(6),
                     border: Border.all(
                       color: state.hasError ? colors.error : colors.grey300,
                     ),
                   ),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(6),
                     child: _SignatureDrawingArea(
                       controller: controller,
                       onChanged: () => state.didChange(controller.points),
                     ),
                   ),
                 ),
                 _SignatureActions(
                   controller: controller,
                   onClear: () {
                     controller.clear();
                     state.didChange(null);
                   },
                 ),
               ],
             ),
           );
         },
       );
}

class _SignatureDrawingArea extends StatelessWidget {
  final SignatureController controller;
  final VoidCallback onChanged;

  const _SignatureDrawingArea({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return GestureDetector(
          onPanStart: (details) => _addPoint(context, details.globalPosition),
          onPanUpdate: (details) => _addPoint(context, details.globalPosition),
          onPanEnd: (_) {
            controller.addPoint(null);
            onChanged();
          },
          child: RepaintBoundary(
            child: CustomPaint(
              size: Size.infinite,
              painter: _SignaturePainter(
                points: controller.points,
                strokeColor: controller.penColor,
                strokeWidth: controller.strokeWidth,
              ),
            ),
          ),
        );
      },
    );
  }

  void _addPoint(BuildContext context, Offset globalPos) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPos = box.globalToLocal(globalPos);
    controller.addPoint(localPos);
  }
}

class _SignatureActions extends StatelessWidget {
  final SignatureController controller;
  final VoidCallback onClear;

  const _SignatureActions({required this.controller, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onClear,
        icon: SvgPicture.asset(
          AppImages.trash,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(colors.grey500, BlendMode.srcIn),
          package: 'lotus_forms_package',
        ),
        label: Text(
          'Clear',
          style: AppFonts.medium14.copyWith(color: colors.grey500),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final Color strokeColor;
  final double strokeWidth;

  _SignaturePainter({
    required this.points,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SignaturePainter oldDelegate) {
    return true;
  }
}
