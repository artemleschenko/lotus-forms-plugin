import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_forms_package/src/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/main_test.mocks.dart';
import '../../helpers/test_helpers.dart';

void main() {
  late MockOfflineRepository mockOfflineRepository;
  late MockFormRepository mockRemoteRepository;
  late SynchronizeUseCase synchronizeUseCase;

  setUp(() {
    mockOfflineRepository = MockOfflineRepository();
    mockRemoteRepository = MockFormRepository();
    synchronizeUseCase = SynchronizeUseCase(
      offlineRepo: mockOfflineRepository,
      remoteRepo: mockRemoteRepository,
    );
  });

  group('SynchronizeUseCase', () {
    group('watchPendingStatus', () {
      test('should return stream from offline repository', () {
        // Arrange
        final expectedStream = Stream.value(true);
        when(
          mockOfflineRepository.hasForms(),
        ).thenAnswer((_) => expectedStream);

        // Act
        final result = synchronizeUseCase.watchPendingStatus();

        // Assert
        expect(result, expectedStream);
        verify(mockOfflineRepository.hasForms()).called(1);
      });

      test('should emit false when no pending forms', () async {
        // Arrange
        when(
          mockOfflineRepository.hasForms(),
        ).thenAnswer((_) => Stream.value(false));

        // Act
        final result = await synchronizeUseCase.watchPendingStatus().first;

        // Assert
        expect(result, false);
      });

      test('should emit true when pending forms exist', () async {
        // Arrange
        when(
          mockOfflineRepository.hasForms(),
        ).thenAnswer((_) => Stream.value(true));

        // Act
        final result = await synchronizeUseCase.watchPendingStatus().first;

        // Assert
        expect(result, true);
      });
    });

    group('executeSync', () {
      test('should do nothing when no pending forms', () async {
        // Arrange
        when(mockOfflineRepository.getForms()).thenAnswer((_) async => []);

        // Act
        await synchronizeUseCase.executeSync();

        // Assert
        verify(mockOfflineRepository.getForms()).called(1);
        verifyNever(mockRemoteRepository.saveForm(any));
        verifyNever(mockOfflineRepository.deleteForm(any));
      });

      test('should sync all pending forms successfully', () async {
        // Arrange
        final pendingForms = TestDataFactory.createFormModels(3);
        when(
          mockOfflineRepository.getForms(),
        ).thenAnswer((_) async => pendingForms);
        when(
          mockRemoteRepository.saveForm(any),
        ).thenAnswer((_) async => Future.value());
        when(
          mockOfflineRepository.deleteForm(any),
        ).thenAnswer((_) async => Future.value());

        // Act
        await synchronizeUseCase.executeSync();

        // Assert
        verify(mockOfflineRepository.getForms()).called(1);

        // Verify each form was saved and deleted in order
        for (final form in pendingForms) {
          verify(mockRemoteRepository.saveForm(form)).called(1);
          verify(mockOfflineRepository.deleteForm(form.id)).called(1);
        }
      });

      test('should maintain order: save then delete for each form', () async {
        // Arrange
        final pendingForms = TestDataFactory.createFormModels(2);
        final callOrder = <String>[];

        when(
          mockOfflineRepository.getForms(),
        ).thenAnswer((_) async => pendingForms);

        when(mockRemoteRepository.saveForm(any)).thenAnswer((invocation) async {
          final form = invocation.positionalArguments[0] as FormModel;
          callOrder.add('save-${form.id}');
        });

        when(mockOfflineRepository.deleteForm(any)).thenAnswer((
          invocation,
        ) async {
          final id = invocation.positionalArguments[0] as String;
          callOrder.add('delete-$id');
        });

        // Act
        await synchronizeUseCase.executeSync();

        // Assert
        expect(callOrder, [
          'save-test-form-1',
          'delete-test-form-1',
          'save-test-form-2',
          'delete-test-form-2',
        ]);
      });

      test(
        'should rethrow exception and stop syncing when save fails',
        () async {
          // Arrange
          final pendingForms = TestDataFactory.createFormModels(3);
          when(
            mockOfflineRepository.getForms(),
          ).thenAnswer((_) async => pendingForms);

          // First form succeeds
          when(
            mockRemoteRepository.saveForm(pendingForms[0]),
          ).thenAnswer((_) async => Future.value());

          // Second form fails
          when(
            mockRemoteRepository.saveForm(pendingForms[1]),
          ).thenThrow(Exception('Network error'));

          when(
            mockOfflineRepository.deleteForm(any),
          ).thenAnswer((_) async => Future.value());

          // Act & Assert
          expect(() => synchronizeUseCase.executeSync(), throwsException);

          // Wait a bit for async operations
          await Future.delayed(Duration.zero);

          // Verify first form was saved and deleted
          verify(mockRemoteRepository.saveForm(pendingForms[0])).called(1);
          verify(
            mockOfflineRepository.deleteForm(pendingForms[0].id),
          ).called(1);

          // Verify second form save was attempted but not deleted
          verify(mockRemoteRepository.saveForm(pendingForms[1])).called(1);
          verifyNever(mockOfflineRepository.deleteForm(pendingForms[1].id));

          // Verify third form was never processed
          verifyNever(mockRemoteRepository.saveForm(pendingForms[2]));
        },
      );

      test('should not delete form when save fails', () async {
        // Arrange
        final pendingForms = TestDataFactory.createFormModels(1);
        when(
          mockOfflineRepository.getForms(),
        ).thenAnswer((_) async => pendingForms);
        when(
          mockRemoteRepository.saveForm(any),
        ).thenThrow(Exception('Save failed'));

        // Act & Assert
        expect(() => synchronizeUseCase.executeSync(), throwsException);

        await Future.delayed(Duration.zero);

        // Assert form was not deleted
        verifyNever(mockOfflineRepository.deleteForm(any));
      });
    });
  });
}
