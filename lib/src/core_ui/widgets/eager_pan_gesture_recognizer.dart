import 'package:flutter/gestures.dart';

/// A gesture recognizer that takes control of the pan gesture as soon as it is detected.
/// Take control from other gesture detectors 'ex. ListView'
class EagerPanGestureRecognizer extends PanGestureRecognizer {
  EagerPanGestureRecognizer({super.debugOwner});

  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    // Take control of the gesture
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'eager pan';
}
