import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/data/repository/mobile_form_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/main_test.mocks.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockFormProvider mockFormProvider;
  late MockDatabase mockDatabase;
  late MockNetworkInfo mockNetworkInfo;
  late MobileFormRepositoryImpl repository;

  setUp(() {
    mockFormProvider = MockFormProvider();
    mockDatabase = MockDatabase();
    mockNetworkInfo = MockNetworkInfo();
    repository = MobileFormRepositoryImpl(
      formProvider: mockFormProvider,
      database: mockDatabase,
      networkInfo: mockNetworkInfo,
    );
  });

  group('MobileFormRepositoryImpl', () {
    group('getForm', () {
      test(
        'should return FormModel when provider returns FormEntity',
        () async {
          const formId = 'test-form-1';
          final formEntity = TestDataFactory.createFormEntity(id: formId);
          when(
            mockFormProvider.getForm(formId),
          ).thenAnswer((_) async => formEntity);

          final result = await repository.getForm(formId);

          expect(result.id, formEntity.id);
          expect(result.name, formEntity.name);
          verify(mockFormProvider.getForm(formId)).called(1);
        },
      );

      test('should throw exception when provider throws', () async {
        const formId = 'test-form-1';
        when(
          mockFormProvider.getForm(formId),
        ).thenThrow(Exception('Provider error'));

        expect(() => repository.getForm(formId), throwsException);
      });
    });

    group('getForms', () {
      test(
        'should return list of FormModels when provider returns FormEntities',
        () async {
          final formEntities = TestDataFactory.createFormEntities(3);
          when(
            mockFormProvider.getForms(),
          ).thenAnswer((_) async => formEntities);

          final result = await repository.getForms();

          expect(result.length, 3);
          expect(result[0].id, 'test-form-1');
          expect(result[1].id, 'test-form-2');
          expect(result[2].id, 'test-form-3');
          verify(mockFormProvider.getForms()).called(1);
        },
      );

      test(
        'should return empty list when provider returns empty list',
        () async {
          when(mockFormProvider.getForms()).thenAnswer((_) async => []);

          final result = await repository.getForms();

          expect(result, isEmpty);
          verify(mockFormProvider.getForms()).called(1);
        },
      );
    });

    group('saveForm', () {
      test('should save to provider when internet is available', () async {
        final formModel = TestDataFactory.createFormModel();

        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockFormProvider.saveForm(any),
        ).thenAnswer((_) async => Future.value());

        await repository.saveForm(formModel);

        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockFormProvider.saveForm(any)).called(1);
        verifyNever(mockDatabase.insertForm(any));
      });

      test('should save to database when internet is not available', () async {
        final formModel = TestDataFactory.createFormModel();

        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(
          mockDatabase.insertForm(any),
        ).thenAnswer((_) async => Future.value());

        await repository.saveForm(formModel);

        verify(mockNetworkInfo.isConnected).called(1);
        verify(mockDatabase.insertForm(any)).called(1);
        verifyNever(mockFormProvider.saveForm(any));
      });
    });

    group('mapping', () {
      test('should correctly map FormEntity to FormModel', () async {
        final formEntity = TestDataFactory.createFormEntity(
          id: 'mapped-id',
          name: 'Mapped Name',
        );
        when(mockFormProvider.getForm(any)).thenAnswer((_) async => formEntity);

        final result = await repository.getForm('mapped-id');

        expect(result.id, formEntity.id);
        expect(result.name, formEntity.name);
        expect(result.elementForms, isEmpty); 
      });
    });
  });
}
