import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/viewmodels/user_form_viewmodel.dart';

void main() {
  group('UserFormViewModel Tests', () {
    late UserFormViewModel viewModel;
    late DateTime testDate;

    setUp(() {
      viewModel = UserFormViewModel();
      testDate = DateTime(1990, 5, 15);
    });

    test('should initialize with empty state', () {
      expect(viewModel.state.firstName, '');
      expect(viewModel.state.lastName, '');
      expect(viewModel.state.birthDate, isNull);
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
      expect(viewModel.state.isValid, false);
    });

    test('should update first name and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateFirstName('Juan');

      expect(viewModel.state.firstName, 'Juan');
      expect(viewModel.state.error, isNull);
    });

    test('should update last name and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateLastName('Pérez');

      expect(viewModel.state.lastName, 'Pérez');
      expect(viewModel.state.error, isNull);
    });

    test('should update birth date and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.birthDate, testDate);
      expect(viewModel.state.error, isNull);
    });

    test('should validate form correctly when all fields are filled', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.isValid, true);
    });

    test('should invalidate form when first name is empty', () {
      viewModel.updateFirstName('');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when last name is empty', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('');
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when birth date is null', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when birth date is in the future', () {
      final futureDate = DateTime.now().add(const Duration(days: 1));
      
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(futureDate);

      expect(viewModel.state.isValid, false);
    });

    test('should handle whitespace in names correctly', () {
      viewModel.updateFirstName('  Juan  ');
      viewModel.updateLastName('  Pérez  ');
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.isValid, true);
    });

    test('should invalidate form with only whitespace names', () {
      viewModel.updateFirstName('   ');
      viewModel.updateLastName('   ');
      viewModel.updateBirthDate(testDate);

      expect(viewModel.state.isValid, false);
    });

    test('should create user successfully when form is valid', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(testDate);

      final user = viewModel.createUser();

      expect(user.firstName, 'Juan');
      expect(user.lastName, 'Pérez');
      expect(user.birthDate, testDate);
      expect(user.id, isNotEmpty);
    });

    test('should trim whitespace when creating user', () {
      viewModel.updateFirstName('  Juan  ');
      viewModel.updateLastName('  Pérez  ');
      viewModel.updateBirthDate(testDate);

      final user = viewModel.createUser();

      expect(user.firstName, 'Juan');
      expect(user.lastName, 'Pérez');
    });

    test('should throw exception when creating user with invalid form', () {
      viewModel.updateFirstName('Juan');
      // Missing last name and birth date

      expect(() => viewModel.createUser(), throwsException);
    });

    test('should reset form to initial state', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(testDate);
      viewModel.setError('Test error');
      viewModel.setLoading(true);

      viewModel.reset();

      expect(viewModel.state.firstName, '');
      expect(viewModel.state.lastName, '');
      expect(viewModel.state.birthDate, isNull);
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
      expect(viewModel.state.isValid, false);
    });

    test('should set error correctly', () {
      viewModel.setError('Test error message');

      expect(viewModel.state.error, 'Test error message');
    });

    test('should set loading state correctly', () {
      viewModel.setLoading(true);
      expect(viewModel.state.isLoading, true);

      viewModel.setLoading(false);
      expect(viewModel.state.isLoading, false);
    });

    test('should generate unique IDs for different users', () {
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(testDate);

      final user1 = viewModel.createUser();
      
      // Small delay to ensure different timestamp
      Future.delayed(const Duration(milliseconds: 1));
      
      final user2 = viewModel.createUser();

      expect(user1.id, isNot(equals(user2.id)));
    });

    test('should validate form after each field update', () {
      expect(viewModel.state.isValid, false);

      viewModel.updateFirstName('Juan');
      expect(viewModel.state.isValid, false);

      viewModel.updateLastName('Pérez');
      expect(viewModel.state.isValid, false);

      viewModel.updateBirthDate(testDate);
      expect(viewModel.state.isValid, true);
    });

    test('should handle edge case birth date (today)', () {
      final today = DateTime.now();
      final todayMidnight = DateTime(today.year, today.month, today.day);
      
      viewModel.updateFirstName('Juan');
      viewModel.updateLastName('Pérez');
      viewModel.updateBirthDate(todayMidnight);

      // Birth date today should be valid since todayMidnight is technically before DateTime.now()
      expect(viewModel.state.isValid, true);
    });
  });
}
