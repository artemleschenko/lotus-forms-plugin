import 'dart:async';
import 'package:lotus_forms_package/src/data/data.dart';

class FakeDatabase implements Database {
  final List<FormEntity> _forms = [];
  final _controller = StreamController<bool>.broadcast();

  FakeDatabase() {
    _updateStream();
  }

  void _updateStream() {
    _controller.add(_forms.isNotEmpty);
  }

  @override
  Future<List<FormEntity>> getForms() async {
    return List.from(_forms);
  }

  @override
  Future<void> insertForm(FormEntity form) async {
    final index = _forms.indexWhere((element) => element.id == form.id);
    if (index != -1) {
      _forms[index] = form;
    } else {
      _forms.add(form);
    }
    _updateStream();
  }

  @override
  Future<void> deleteForm(String id) async {
    _forms.removeWhere((element) => element.id == id);
    _updateStream();
  }

  @override
  Stream<bool> hasForms() {
    // Return current state immediately then listen for updates
    return _controller.stream.startWith(_forms.isNotEmpty);
  }
}

extension StreamStartWith<T> on Stream<T> {
  Stream<T> startWith(T value) async* {
    yield value;
    yield* this;
  }
}
