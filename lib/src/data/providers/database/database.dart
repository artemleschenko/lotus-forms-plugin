import 'package:lotus_forms_package/src/data/data.dart';

abstract interface class Database {
  Stream<bool> hasForms();
  Future<List<FormEntity>> getForms();
  Future<void> insertForm(FormEntity form);
  Future<void> deleteForm(String id);
}
