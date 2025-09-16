import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/models/address.dart';

void main() {
  group('User Model Tests', () {
    late DateTime testDate;
    late Address testAddress;
    late User testUser;

    setUp(() {
      testDate = DateTime(1990, 5, 15);
      testAddress = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        isPrimary: true,
      );
      testUser = User(
        id: 'user1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: testDate,
        addresses: [testAddress],
      );
    });

    test('should create User with required fields', () {
      expect(testUser.id, 'user1');
      expect(testUser.firstName, 'Juan');
      expect(testUser.lastName, 'Pérez');
      expect(testUser.birthDate, testDate);
      expect(testUser.addresses, [testAddress]);
    });

    test('should calculate fullName correctly', () {
      expect(testUser.fullName, 'Juan Pérez');
    });

    test('should calculate initials correctly', () {
      expect(testUser.initials, 'JP');
    });

    test('should calculate age correctly', () {
      final now = DateTime.now();
      final expectedAge = now.year - testDate.year;
      final adjustedAge = now.month < testDate.month || 
          (now.month == testDate.month && now.day < testDate.day) 
          ? expectedAge - 1 
          : expectedAge;
      
      expect(testUser.age, adjustedAge);
    });

    test('should handle empty addresses list', () {
      final userWithoutAddresses = User(
        id: 'user2',
        firstName: 'Ana',
        lastName: 'García',
        birthDate: testDate,
        addresses: [],
      );

      expect(userWithoutAddresses.addresses, isEmpty);
    });

    test('should create User with copyWith method', () {
      final updatedUser = testUser.copyWith(
        firstName: 'Carlos',
      );

      expect(updatedUser.firstName, 'Carlos');
      expect(updatedUser.lastName, 'Pérez'); // unchanged
      expect(updatedUser.id, 'user1'); // unchanged
    });

    test('should handle edge case for age calculation on birthday', () {
      final today = DateTime.now();
      final birthdayToday = User(
        id: 'user3',
        firstName: 'Test',
        lastName: 'User',
        birthDate: DateTime(today.year - 25, today.month, today.day),
        addresses: [],
      );

      expect(birthdayToday.age, 25);
    });

    test('should handle single character names for initials', () {
      final singleCharUser = User(
        id: 'user4',
        firstName: 'A',
        lastName: 'B',
        birthDate: testDate,
        addresses: [],
      );

      expect(singleCharUser.initials, 'AB');
    });
  });
}
