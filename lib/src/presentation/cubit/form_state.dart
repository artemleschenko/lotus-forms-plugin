import 'package:equatable/equatable.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';

enum FormStatus { initial, loading, success, failure }

class FormState extends Equatable {
  const FormState({
    this.status = FormStatus.initial,
    this.schema,
    this.values = const {},
    this.error,
  });

  final FormStatus status;
  final FormModel? schema;
  final Map<String, dynamic> values;
  final String? error;

  FormState copyWith({
    FormStatus? status,
    FormModel? schema,
    Map<String, dynamic>? values,
    String? error,
  }) {
    return FormState(
      status: status ?? this.status,
      schema: schema ?? this.schema,
      values: values ?? this.values,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, schema, values, error];
}
