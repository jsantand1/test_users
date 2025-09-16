import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/models/address.dart';

void main() {
  group('Address Model Tests', () {
    late Address testAddress;

    setUp(() {
      testAddress = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        isPrimary: true,
        additionalInfo: 'Apartamento 101',
      );
    });

    test('should create Address with all fields', () {
      expect(testAddress.id, 'addr1');
      expect(testAddress.country, 'Colombia');
      expect(testAddress.department, 'Antioquia');
      expect(testAddress.municipality, 'Medellín');
      expect(testAddress.streetAddress, 'Calle 123 #45-67');
      expect(testAddress.isPrimary, true);
      expect(testAddress.additionalInfo, 'Apartamento 101');
    });

    test('should create Address without optional additionalInfo', () {
      final addressWithoutInfo = Address(
        id: 'addr2',
        country: 'Colombia',
        department: 'Cundinamarca',
        municipality: 'Bogotá',
        streetAddress: 'Carrera 15 #85-30',
        isPrimary: false,
      );

      expect(addressWithoutInfo.additionalInfo, isNull);
      expect(addressWithoutInfo.isPrimary, false);
    });

    test('should create Address with copyWith method', () {
      final updatedAddress = testAddress.copyWith(
        municipality: 'Envigado',
        isPrimary: false,
        additionalInfo: 'Casa 2',
      );

      expect(updatedAddress.municipality, 'Envigado');
      expect(updatedAddress.isPrimary, false);
      expect(updatedAddress.additionalInfo, 'Casa 2');
      expect(updatedAddress.country, 'Colombia'); // unchanged
      expect(updatedAddress.id, 'addr1'); // unchanged
    });

    test('should handle empty strings', () {
      final addressWithEmptyStrings = Address(
        id: '',
        country: '',
        department: '',
        municipality: '',
        streetAddress: '',
        isPrimary: false,
      );

      expect(addressWithEmptyStrings.id, '');
      expect(addressWithEmptyStrings.country, '');
      expect(addressWithEmptyStrings.department, '');
      expect(addressWithEmptyStrings.municipality, '');
      expect(addressWithEmptyStrings.streetAddress, '');
    });

    test('should handle copyWith with null additionalInfo', () {
      final updatedAddress = testAddress.copyWith(
        additionalInfo: null,
      );

      expect(updatedAddress.additionalInfo, isNull);
      expect(updatedAddress.streetAddress, 'Calle 123 #45-67'); // unchanged
    });

    test('should maintain immutability', () {
      final originalAddress = Address(
        id: 'addr3',
        country: 'Colombia',
        department: 'Valle del Cauca',
        municipality: 'Cali',
        streetAddress: 'Avenida 6N #25-50',
        isPrimary: true,
      );

      final modifiedAddress = originalAddress.copyWith(
        isPrimary: false,
      );

      expect(originalAddress.isPrimary, true);
      expect(modifiedAddress.isPrimary, false);
      expect(originalAddress.id, modifiedAddress.id);
    });
  });
}
