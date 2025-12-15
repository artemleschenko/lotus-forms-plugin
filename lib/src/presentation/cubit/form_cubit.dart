import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

part 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  final GetFormUseCase _getFormUseCase;
  final SaveFormUseCase _saveFormUseCase;

  FormCubit({
    required GetFormUseCase getFormUseCase,
    required SaveFormUseCase saveFormUseCase,
  }) : _getFormUseCase = getFormUseCase,
       _saveFormUseCase = saveFormUseCase,
       super(FormState(form: FormEntity.empty()));

  Future<void> getForm(String formId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final form = await _getFormUseCase.execute(formId);
      emit(state.copyWith(form: form, isLoading: false));
    } on PackageException catch (e) {
      emit(state.copyWith(error: e.message, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Something went wrong', isLoading: false));
    }
  }

  Future<void> saveForm(FormEntity form) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _saveFormUseCase.execute(form);
      emit(state.copyWith(isLoading: false));
    } on PackageException catch (e) {
      emit(state.copyWith(error: e.message, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Something went wrong', isLoading: false));
    }
  }
}
