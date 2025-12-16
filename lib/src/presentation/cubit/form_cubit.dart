import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lotus_forms_package/src/presentation/cubit/form_state.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

class FormCubit extends Cubit<FormState> {
  final GetFormUseCase _getFormUseCase;
  final SaveFormUseCase _saveFormUseCase;

  FormCubit({
    required GetFormUseCase getFormUseCase,
    required SaveFormUseCase saveFormUseCase,
  }) : _getFormUseCase = getFormUseCase,
       _saveFormUseCase = saveFormUseCase,
       super(FormState());

  Future<void> getForm(String formId) async {
    emit(state.copyWith(status: FormStatus.loading));
    try {
      final form = await _getFormUseCase.execute(formId);
      emit(state.copyWith(schema: form, status: FormStatus.success));
    } on PackageException catch (e) {
      emit(state.copyWith(error: e.message, status: FormStatus.failure));
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Something went wrong',
          status: FormStatus.failure,
        ),
      );
    }
  }

  Future<void> saveForm(FormModel form) async {
    emit(state.copyWith(status: FormStatus.loading));

    try {
      await _saveFormUseCase.execute(form);
      emit(state.copyWith(status: FormStatus.success));
    } on PackageException catch (e) {
      emit(state.copyWith(error: e.message, status: FormStatus.failure));
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Something went wrong',
          status: FormStatus.failure,
        ),
      );
    }
  }
}
