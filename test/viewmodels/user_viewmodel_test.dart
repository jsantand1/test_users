import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/viewmodels/user_viewmodel.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/models/address.dart';

void main() {
  group('UserViewModel Tests', () {
    late UserViewModel viewModel;
    late User testUser1;
    late User testUser2;
    late Address testAddress;

    setUp(() {
      viewModel = UserViewModel();
      
      testUser1 = User(
        id: 'user1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(1990, 5, 15),
        addresses: [],
      );

      testUser2 = User(
        id: 'user2',
        firstName: 'Ana',
        lastName: 'García',
        birthDate: DateTime(1985, 8, 20),
        addresses: [],
      );

      testAddress = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        isPrimary: true,
      );
    });

    test('should initialize with empty state', () {
      expect(viewModel.state.users, isEmpty);
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
    });

    test('should add user successfully', () async {
      await viewModel.addUser(testUser1);

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first, testUser1);
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
    });

    test('should add multiple users', () async {
      await viewModel.addUser(testUser1);
      await viewModel.addUser(testUser2);

      expect(viewModel.state.users.length, 2);
      expect(viewModel.state.users, contains(testUser1));
      expect(viewModel.state.users, contains(testUser2));
    });

    test('should update user successfully', () async {
      await viewModel.addUser(testUser1);
      
      final updatedUser = testUser1.copyWith(firstName: 'Carlos');
      await viewModel.updateUser(updatedUser);

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first.firstName, 'Carlos');
      expect(viewModel.state.users.first.id, testUser1.id);
    });

    test('should not update non-existent user', () async {
      await viewModel.addUser(testUser1);
      
      final nonExistentUser = testUser2.copyWith(id: 'non-existent');
      await viewModel.updateUser(nonExistentUser);

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first, testUser1);
    });

    test('should delete user successfully', () async {
      await viewModel.addUser(testUser1);
      await viewModel.addUser(testUser2);
      
      await viewModel.deleteUser(testUser1.id);

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first, testUser2);
    });

    test('should handle delete non-existent user', () async {
      await viewModel.addUser(testUser1);
      
      await viewModel.deleteUser('non-existent');

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first, testUser1);
    });

    test('should add address to user successfully', () async {
      await viewModel.addUser(testUser1);
      
      await viewModel.addAddressToUser(testUser1.id, testAddress);

      final updatedUser = viewModel.state.users.first;
      expect(updatedUser.addresses.length, 1);
      expect(updatedUser.addresses.first, testAddress);
    });

    test('should update user address successfully', () async {
      final userWithAddress = testUser1.copyWith(addresses: [testAddress]);
      await viewModel.addUser(userWithAddress);
      
      final updatedAddress = testAddress.copyWith(municipality: 'Envigado');
      await viewModel.updateUserAddress(testUser1.id, updatedAddress);

      final updatedUser = viewModel.state.users.first;
      expect(updatedUser.addresses.length, 1);
      expect(updatedUser.addresses.first.municipality, 'Envigado');
    });

    test('should delete user address successfully', () async {
      final userWithAddress = testUser1.copyWith(addresses: [testAddress]);
      await viewModel.addUser(userWithAddress);
      
      await viewModel.deleteUserAddress(testUser1.id, testAddress.id);

      final updatedUser = viewModel.state.users.first;
      expect(updatedUser.addresses, isEmpty);
    });

    test('should clear error', () async {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.clearError();

      expect(viewModel.state.error, isNull);
    });

    test('should get user by id', () async {
      await viewModel.addUser(testUser1);
      await viewModel.addUser(testUser2);

      final foundUser = viewModel.getUserById(testUser1.id);
      expect(foundUser, testUser1);
    });

    test('should return null for non-existent user id', () {
      final foundUser = viewModel.getUserById('non-existent');
      expect(foundUser, isNull);
    });

    test('should set loading state during operations', () async {
      final future = viewModel.addUser(testUser1);
      
      // Check loading state is set immediately
      expect(viewModel.state.isLoading, true);
      
      await future;
      
      // Check loading state is cleared after operation
      expect(viewModel.state.isLoading, false);
    });

    test('should handle operations on non-existent user gracefully', () async {
      await viewModel.addAddressToUser('non-existent', testAddress);
      await viewModel.updateUserAddress('non-existent', testAddress);
      await viewModel.deleteUserAddress('non-existent', 'addr1');

      expect(viewModel.state.users, isEmpty);
      expect(viewModel.state.isLoading, false);
    });

    test('should maintain state consistency during multiple operations', () async {
      await viewModel.addUser(testUser1);
      await viewModel.addUser(testUser2);
      await viewModel.addAddressToUser(testUser1.id, testAddress);
      await viewModel.updateUser(testUser2.copyWith(firstName: 'Updated'));
      await viewModel.deleteUser(testUser1.id);

      expect(viewModel.state.users.length, 1);
      expect(viewModel.state.users.first.firstName, 'Updated');
      expect(viewModel.state.users.first.id, testUser2.id);
    });
  });
}
