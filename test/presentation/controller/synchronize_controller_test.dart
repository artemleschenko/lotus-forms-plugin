import 'package:flutter_test/flutter_test.dart';
import 'package:lotus_forms_package/src/presentation/controller/synchronize_controller.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/main_test.mocks.dart';

void main() {
  late MockSynchronizeUseCase mockUseCase;
  late SynchronizeController controller;

  setUp(() {
    mockUseCase = MockSynchronizeUseCase();
    controller = SynchronizeController(useCase: mockUseCase);
  });

  group('SynchronizeController', () {
    group('sync', () {
      test('should call useCase.executeSync', () async {
        // Arrange
        when(mockUseCase.executeSync()).thenAnswer((_) async => Future.value());

        // Act
        await controller.sync();

        // Assert
        verify(mockUseCase.executeSync()).called(1);
      });

      test('should propagate exceptions from useCase', () async {
        // Arrange
        when(mockUseCase.executeSync()).thenThrow(Exception('Sync error'));

        // Act & Assert
        expect(() => controller.sync(), throwsException);
      });

      test('should complete successfully when useCase succeeds', () async {
        // Arrange
        when(mockUseCase.executeSync()).thenAnswer((_) async => Future.value());

        // Act
        final future = controller.sync();

        // Assert
        await expectLater(future, completes);
      });
    });

    group('hasData', () {
      test('should return stream from useCase.watchPendingStatus', () {
        // Arrange
        final expectedStream = Stream.value(true);
        when(
          mockUseCase.watchPendingStatus(),
        ).thenAnswer((_) => expectedStream);

        // Act
        final result = controller.hasData();

        // Assert
        expect(result, expectedStream);
        verify(mockUseCase.watchPendingStatus()).called(1);
      });

      test('should emit false when no pending data', () async {
        // Arrange
        when(
          mockUseCase.watchPendingStatus(),
        ).thenAnswer((_) => Stream.value(false));

        // Act
        final result = await controller.hasData().first;

        // Assert
        expect(result, false);
      });

      test('should emit true when pending data exists', () async {
        // Arrange
        when(
          mockUseCase.watchPendingStatus(),
        ).thenAnswer((_) => Stream.value(true));

        // Act
        final result = await controller.hasData().first;

        // Assert
        expect(result, true);
      });

      test('should emit multiple values from stream', () async {
        // Arrange
        when(
          mockUseCase.watchPendingStatus(),
        ).thenAnswer((_) => Stream.fromIterable([false, true, false]));

        // Act
        final results = await controller.hasData().toList();

        // Assert
        expect(results, [false, true, false]);
      });
    });
  });
}
