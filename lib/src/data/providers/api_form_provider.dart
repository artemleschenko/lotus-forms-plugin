import 'package:dio/dio.dart';
import 'package:lotus_forms_package/src/data/data.dart';

import 'form_provider.dart';
import '../../core/core.dart';

class ApiFormProvider implements FormProvider {
  const ApiFormProvider({required this.dio});
  final Dio dio;

  @override
  Future<List<FormEntity>> getForms() async {
    try {
      final response = await dio.get(ApiConstants.forms);
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw UnexpectedAppException(
        'Something went wrong',
        details: e.toString(),
      );
    }
  }

  @override
  Future<FormEntity> getForm(String formId) async {
    try {
      final response = await dio.get(
        ApiConstants.form.replaceFirst('{formId}', formId),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw UnexpectedAppException(
        'Something went wrong',
        details: e.toString(),
      );
    }
  }

  @override
  Future<FormEntity> saveForm(FormEntity form) async {
    try {
      final response = await dio.post(
        ApiConstants.form.replaceFirst('{formId}', form.id),
        data: form,
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw UnexpectedAppException(
        'Something went wrong',
        details: e.toString(),
      );
    }
  }

  Never _handleDioException(DioException e) {
    if (e.response?.statusCode == 401) {
      throw AuthorizationException(
        'Jwt token expired or invalid',
        details: e.response?.data.toString(),
      );
    } else if (e.response?.statusCode == 500) {
      throw NetworkException(
        'Internal server error',
        details: e.response?.data.toString(),
      );
    } else {
      throw NetworkException(
        'Something went wrong',
        details: e.response?.data.toString(),
      );
    }
  }
}
