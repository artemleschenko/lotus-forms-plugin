import 'package:lotus_forms_package/src/data/data.dart';

abstract class Database {
  Future<bool> hasForms();
  Future<List<FormEntity>> getForms();
  Future<void> insertForm(FormEntity form);
}
