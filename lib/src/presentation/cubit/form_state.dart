part of 'form_cubit.dart';

class FormState extends Equatable {
  const FormState({
    required this.form,
    this.isLoading = false,
    this.error = '',
  });

  final Form form;
  final bool isLoading;
  final String error;

  FormState copyWith({Form? form, bool? isLoading, String? error}) {
    return FormState(
      form: form ?? this.form,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [form, isLoading, error];
}
