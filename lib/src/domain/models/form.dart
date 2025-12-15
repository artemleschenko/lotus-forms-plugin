import 'package:lotus_forms_package/src/core/core.dart';

class FormModel extends Equatable {
  const FormModel({required this.id, required this.name});

  factory FormModel.empty() => const FormModel(id: '', name: '');

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
