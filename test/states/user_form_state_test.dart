import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/states/user_form_state.dart';

void main() {
  group('UserFormState Tests', () {
    late UserFormState initialState;
    late DateTime testDate;

    setUp(() {
      testDate = DateTime(1990, 5, 15);
      initialState = const UserFormState();
    });

    test('should create UserFormState with default values', () {
      expect(initialState.firstName, '');
      expect(initialState.lastName, '');
      expect(initialState.birthDate, isNull);
      expect(initialState.isLoading, false);
      expect(initialState.error, isNull);
      expect(initialState.isValid, false);
    });

    test('should create UserFormState with custom values', () {
      final customState = UserFormState(
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: testDate,
        isLoading: true,
        error: 'Test error',
        isValid: true,
      );

      expect(customState.firstName, 'Juan');
      expect(customState.lastName, 'Pérez');
      expect(customState.birthDate, testDate);
      expect(customState.isLoading, true);
      expect(customState.error, 'Test error');
      expect(customState.isValid, true);
    });

    test('should copy state with updated firstName', () {
      final updatedState = initialState.copyWith(firstName: 'Carlos');

      expect(updatedState.firstName, 'Carlos');
      expect(updatedState.lastName, '');
      expect(updatedState.birthDate, isNull);
      expect(updatedState.isLoading, false);
      expect(updatedState.error, isNull);
      expect(updatedState.isValid, false);
    });

    test('should copy state with updated lastName', () {
      final updatedState = initialState.copyWith(lastName: 'García');

      expect(updatedState.firstName, '');
      expect(updatedState.lastName, 'García');
      expect(updatedState.birthDate, isNull);
    });

    test('should copy state with updated birthDate', () {
      final updatedState = initialState.copyWith(birthDate: testDate);

      expect(updatedState.firstName, '');
      expect(updatedState.lastName, '');
      expect(updatedState.birthDate, testDate);
    });

    test('should copy state with updated isLoading', () {
      final updatedState = initialState.copyWith(isLoading: true);

      expect(updatedState.isLoading, true);
      expect(updatedState.firstName, '');
      expect(updatedState.lastName, '');
    });

    test('should copy state with updated error', () {
      final updatedState = initialState.copyWith(error: 'Validation error');

      expect(updatedState.error, 'Validation error');
      expect(updatedState.isLoading, false);
    });

    test('should copy state with updated isValid', () {
      final updatedState = initialState.copyWith(isValid: true);

      expect(updatedState.isValid, true);
      expect(updatedState.firstName, '');
      expect(updatedState.lastName, '');
    });

    test('should copy state with multiple updates', () {
      final updatedState = initialState.copyWith(
        firstName: 'Ana',
        lastName: 'Martínez',
        birthDate: testDate,
        isLoading: true,
        error: 'Processing...',
        isValid: false,
      );

      expect(updatedState.firstName, 'Ana');
      expect(updatedState.lastName, 'Martínez');
      expect(updatedState.birthDate, testDate);
      expect(updatedState.isLoading, true);
      expect(updatedState.error, 'Processing...');
      expect(updatedState.isValid, false);
    });

    test('should handle null error in copyWith', () {
      final stateWithError = initialState.copyWith(error: 'Some error');
      final stateWithoutError = stateWithError.copyWith(error: null);

      expect(stateWithError.error, 'Some error');
      expect(stateWithoutError.error, isNull);
    });

    test('should maintain immutability', () {
      final originalState = UserFormState(
        firstName: 'Original',
        lastName: 'Name',
        isValid: false,
      );

      final modifiedState = originalState.copyWith(
        firstName: 'Modified',
        isValid: true,
      );

      expect(originalState.firstName, 'Original');
      expect(originalState.isValid, false);
      expect(modifiedState.firstName, 'Modified');
      expect(modifiedState.isValid, true);
      expect(modifiedState.lastName, 'Name'); // inherited
    });
  });
}
