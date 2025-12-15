import 'package:drift/drift.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'connection.dart' as impl;

part 'database_impl.g.dart';

@DriftDatabase(include: {"sql/schema.drift"})
class DatabaseImpl extends _$DatabaseImpl implements Database {
  DatabaseImpl({
    required this.dbName,
    required this.inMemory,
    required this.logStatements,
  }) : super(
         impl.connect(dbName, inMemory: inMemory, logStatements: logStatements),
       );

  final String dbName;
  final bool inMemory;
  final bool logStatements;

  @override
  int get schemaVersion => 1;

  @override
  Future<List<FormEntity>> getForms() async {
    final forms = await _getForms().get();
    return forms
        .map((form) => FormEntity(id: form.id, name: form.name))
        .toList();
  }

  @override
  Future<void> insertForm(FormEntity form) {
    return _insertForm(form.id, form.name);
  }

  @override
  Stream<bool> hasForms() {
    return _hasForms().watchSingle();
  }

  @override
  Future<void> deleteForm(String id) {
    return _deleteForm(id);
  }
}
