import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/states/address_form_state.dart';

void main() {
  group('AddressFormState Tests', () {
    late AddressFormState initialState;

    setUp(() {
      initialState = const AddressFormState();
    });

    test('should create AddressFormState with default values', () {
      expect(initialState.country, '');
      expect(initialState.department, '');
      expect(initialState.municipality, '');
      expect(initialState.streetAddress, '');
      expect(initialState.additionalInfo, '');
      expect(initialState.isPrimary, false);
      expect(initialState.isLoading, false);
      expect(initialState.error, isNull);
      expect(initialState.isValid, false);
    });

    test('should create AddressFormState with custom values', () {
      final customState = AddressFormState(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        additionalInfo: 'Apartamento 101',
        isPrimary: true,
        isLoading: true,
        error: 'Test error',
        isValid: true,
      );

      expect(customState.country, 'Colombia');
      expect(customState.department, 'Antioquia');
      expect(customState.municipality, 'Medellín');
      expect(customState.streetAddress, 'Calle 123 #45-67');
      expect(customState.additionalInfo, 'Apartamento 101');
      expect(customState.isPrimary, true);
      expect(customState.isLoading, true);
      expect(customState.error, 'Test error');
      expect(customState.isValid, true);
    });

    test('should copy state with updated country', () {
      final updatedState = initialState.copyWith(country: 'Colombia');

      expect(updatedState.country, 'Colombia');
      expect(updatedState.department, '');
      expect(updatedState.municipality, '');
      expect(updatedState.streetAddress, '');
      expect(updatedState.additionalInfo, '');
      expect(updatedState.isPrimary, false);
    });

    test('should copy state with updated department', () {
      final updatedState = initialState.copyWith(department: 'Cundinamarca');

      expect(updatedState.country, '');
      expect(updatedState.department, 'Cundinamarca');
      expect(updatedState.municipality, '');
    });

    test('should copy state with updated municipality', () {
      final updatedState = initialState.copyWith(municipality: 'Bogotá');

      expect(updatedState.municipality, 'Bogotá');
      expect(updatedState.country, '');
      expect(updatedState.department, '');
    });

    test('should copy state with updated streetAddress', () {
      final updatedState = initialState.copyWith(streetAddress: 'Carrera 15 #85-30');

      expect(updatedState.streetAddress, 'Carrera 15 #85-30');
      expect(updatedState.country, '');
    });

    test('should copy state with updated additionalInfo', () {
      final updatedState = initialState.copyWith(additionalInfo: 'Casa 2');

      expect(updatedState.additionalInfo, 'Casa 2');
      expect(updatedState.streetAddress, '');
    });

    test('should copy state with updated isPrimary', () {
      final updatedState = initialState.copyWith(isPrimary: true);

      expect(updatedState.isPrimary, true);
      expect(updatedState.country, '');
    });

    test('should copy state with updated isLoading', () {
      final updatedState = initialState.copyWith(isLoading: true);

      expect(updatedState.isLoading, true);
      expect(updatedState.isPrimary, false);
    });

    test('should copy state with updated error', () {
      final updatedState = initialState.copyWith(error: 'Validation error');

      expect(updatedState.error, 'Validation error');
      expect(updatedState.isLoading, false);
    });

    test('should copy state with updated isValid', () {
      final updatedState = initialState.copyWith(isValid: true);

      expect(updatedState.isValid, true);
      expect(updatedState.country, '');
    });

    test('should copy state with multiple updates', () {
      final updatedState = initialState.copyWith(
        country: 'Colombia',
        department: 'Valle del Cauca',
        municipality: 'Cali',
        streetAddress: 'Avenida 6N #25-50',
        additionalInfo: 'Torre B, Piso 5',
        isPrimary: true,
        isLoading: true,
        error: 'Processing...',
        isValid: false,
      );

      expect(updatedState.country, 'Colombia');
      expect(updatedState.department, 'Valle del Cauca');
      expect(updatedState.municipality, 'Cali');
      expect(updatedState.streetAddress, 'Avenida 6N #25-50');
      expect(updatedState.additionalInfo, 'Torre B, Piso 5');
      expect(updatedState.isPrimary, true);
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
      final originalState = AddressFormState(
        country: 'Original Country',
        department: 'Original Department',
        isValid: false,
        isPrimary: false,
      );

      final modifiedState = originalState.copyWith(
        country: 'Modified Country',
        isValid: true,
        isPrimary: true,
      );

      expect(originalState.country, 'Original Country');
      expect(originalState.isValid, false);
      expect(originalState.isPrimary, false);
      expect(modifiedState.country, 'Modified Country');
      expect(modifiedState.isValid, true);
      expect(modifiedState.isPrimary, true);
      expect(modifiedState.department, 'Original Department'); // inherited
    });

    test('should handle empty string values correctly', () {
      final stateWithEmptyStrings = AddressFormState(
        country: '',
        department: '',
        municipality: '',
        streetAddress: '',
        additionalInfo: '',
      );

      expect(stateWithEmptyStrings.country, '');
      expect(stateWithEmptyStrings.department, '');
      expect(stateWithEmptyStrings.municipality, '');
      expect(stateWithEmptyStrings.streetAddress, '');
      expect(stateWithEmptyStrings.additionalInfo, '');
    });
  });
}
