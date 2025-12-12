import '../../core/core.dart';

class Form extends Equatable {
  const Form({required this.id, required this.name});

  factory Form.empty() => const Form(id: '', name: '');

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
