import '../../core/core.dart';

class FormEntity extends Equatable {
  const FormEntity({required this.id, required this.name});

  factory FormEntity.empty() => const FormEntity(id: '', name: '');

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
