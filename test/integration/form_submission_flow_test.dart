import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_forms_package/src/data/data.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';
import 'package:lotus_forms_package/src/presentation/controller/synchronize_controller.dart';
import 'package:mockito/mockito.dart';

import '../helpers/fake_database.dart';
import '../helpers/main_test.mocks.dart';
import '../helpers/test_helpers.dart';

void main() {
  // Dependencies
  late MockFormProvider mockRemoteProvider;
  late FakeDatabase fakeDatabase;
  late MockNetworkInfo mockNetworkInfo;

  // System Under Test components
  late MobileFormRepositoryImpl formRepository;
  late OfflineRepositoryImpl offlineRepository;
  late SynchronizeUseCase syncUseCase;
  late SynchronizeController syncController;

  setUp(() async {
    // 1. Setup mocks
    mockRemoteProvider = MockFormProvider();
    mockNetworkInfo = MockNetworkInfo();

    // 2. Setup fake in-memory database
    fakeDatabase = FakeDatabase();

    // 3. Setup Repositories
    formRepository = MobileFormRepositoryImpl(
      formProvider: mockRemoteProvider,
      database: fakeDatabase,
      networkInfo: mockNetworkInfo,
    );

    offlineRepository = OfflineRepositoryImpl(fakeDatabase);

    // 4. Setup Domain & Presentation
    syncUseCase = SynchronizeUseCase(
      offlineRepo: offlineRepository,
      remoteRepo: formRepository,
    );

    syncController = SynchronizeController(useCase: syncUseCase);
  });

  group('Form Submission Flow Integration Test', () {
    test('Scenario 1: Online Submission', () async {
      // Given: Internet is available
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteProvider.saveForm(any),
      ).thenAnswer((_) async => Future.value());

      // When: User saves a form
      final form = TestDataFactory.createFormModel(id: 'online-form');
      await formRepository.saveForm(form);

      // Then:
      // 1. Form should be sent to remote provider
      verify(mockRemoteProvider.saveForm(any)).called(1);

      // 2. Form should NOT be in local database
      final localForms = await fakeDatabase.getForms();
      expect(localForms, isEmpty);

      // 3. Sync status should be false (no pending data)
      final hasData = await syncController.hasData().first;
      expect(hasData, false);
    });

    test('Scenario 2: Offline Storage', () async {
      // Given: Internet is NOT available
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // When: User saves a form
      final form = TestDataFactory.createFormModel(id: 'offline-form');
      await formRepository.saveForm(form);

      // Then:
      // 1. Form should NOT be sent to remote provider
      verifyNever(mockRemoteProvider.saveForm(any));

      // 2. Form should be in local database
      final localForms = await fakeDatabase.getForms();
      expect(localForms.length, 1);
      expect(localForms.first.id, 'offline-form');

      // 3. Sync status should be true (has pending data)
      final hasData = await syncController.hasData().first;
      expect(hasData, true);
    });

    test('Scenario 3: Auto-sync after reconnection', () async {
      // Given:
      // 1. Internet was offline and forms were saved
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final form1 = TestDataFactory.createFormModel(id: 'form-1');
      final form2 = TestDataFactory.createFormModel(id: 'form-2');

      await formRepository.saveForm(form1);
      await formRepository.saveForm(form2);

      // Verify they are in DB
      var localForms = await fakeDatabase.getForms();
      expect(localForms.length, 2);

      // 2. Internet becomes available
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteProvider.saveForm(any),
      ).thenAnswer((_) async => Future.value());

      // When: Sync is triggered (e.g. by a background worker or manually)
      await syncController.sync();

      // Then:
      // 1. All forms should be sent to remote
      verify(mockRemoteProvider.saveForm(any)).called(2);
      // Verify specific forms if needed (requires capturing arguments)

      // 2. Local database should be empty
      localForms = await fakeDatabase.getForms();
      expect(localForms, isEmpty);

      // 3. Sync status should be false
      final hasData = await syncController.hasData().first;
      expect(hasData, false);
    });

    test('Scenario 4: Partial Sync Failure', () async {
      // Given: 2 forms in local DB
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final form1 = TestDataFactory.createFormModel(id: 'success-form');
      final form2 = TestDataFactory.createFormModel(id: 'fail-form');

      await formRepository.saveForm(form1);
      await formRepository.saveForm(form2);

      // When: Sync runs
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // First form succeeds
      when(
        mockRemoteProvider.saveForm(
          argThat(predicate<FormEntity>((f) => f.id == 'success-form')),
        ),
      ).thenAnswer((_) async => Future.value());

      // Second form fails
      when(
        mockRemoteProvider.saveForm(
          argThat(predicate<FormEntity>((f) => f.id == 'fail-form')),
        ),
      ).thenThrow(Exception('Network Error'));

      // Act: Try to sync
      try {
        await syncController.sync();
      } catch (e) {
        // Expected exception
      }

      // Then:
      // 1. First form should be removed from DB
      // 2. Second form should remain in DB
      final localForms = await fakeDatabase.getForms();
      expect(localForms.length, 1);
      expect(localForms.first.id, 'fail-form');

      // 3. Sync status should still be true
      final hasData = await syncController.hasData().first;
      expect(hasData, true);
    });
  });
}
