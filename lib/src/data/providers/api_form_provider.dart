import 'package:dio/dio.dart';

import 'form_provider.dart';
import '../../core/core.dart';

class ApiFormProvider implements FormProvider {
  const ApiFormProvider({required this.dio});
  final Dio dio;

  @override
  Future<void> getForms() async {
    try {
      final response = await dio.get(ApiConstants.forms);
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
  Future<void> getForm(String formId) async {
    try {
      final response = await dio.get(
        ApiConstants.form.replaceFirst('{formId}', formId),
      );
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw UnexpectedAppException(
        'Something went wrong',
        details: e.toString(),
      );
    }
  }

  void _handleDioException(DioException e) {
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
