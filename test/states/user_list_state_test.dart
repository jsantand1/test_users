import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/states/user_list_state.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/models/address.dart';

void main() {
  group('UserListState Tests', () {
    late UserListState initialState;
    late User testUser1;
    late User testUser2;
    late List<User> testUsers;

    setUp(() {
      initialState = const UserListState();
      
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
        addresses: [
          Address(
            id: 'addr1',
            country: 'Colombia',
            department: 'Antioquia',
            municipality: 'Medellín',
            streetAddress: 'Calle 123 #45-67',
            isPrimary: true,
          ),
        ],
      );

      testUsers = [testUser1, testUser2];
    });

    test('should create UserListState with default values', () {
      expect(initialState.users, isEmpty);
      expect(initialState.isLoading, false);
      expect(initialState.error, isNull);
    });

    test('should create UserListState with custom values', () {
      final customState = UserListState(
        users: testUsers,
        isLoading: true,
        error: 'Test error',
      );

      expect(customState.users, testUsers);
      expect(customState.users.length, 2);
      expect(customState.isLoading, true);
      expect(customState.error, 'Test error');
    });

    test('should copy state with updated users', () {
      final updatedState = initialState.copyWith(users: testUsers);

      expect(updatedState.users, testUsers);
      expect(updatedState.users.length, 2);
      expect(updatedState.isLoading, false);
      expect(updatedState.error, isNull);
    });

    test('should copy state with updated isLoading', () {
      final updatedState = initialState.copyWith(isLoading: true);

      expect(updatedState.users, isEmpty);
      expect(updatedState.isLoading, true);
      expect(updatedState.error, isNull);
    });

    test('should copy state with updated error', () {
      final updatedState = initialState.copyWith(error: 'Network error');

      expect(updatedState.users, isEmpty);
      expect(updatedState.isLoading, false);
      expect(updatedState.error, 'Network error');
    });

    test('should copy state with multiple updates', () {
      final updatedState = initialState.copyWith(
        users: testUsers,
        isLoading: true,
        error: 'Loading users...',
      );

      expect(updatedState.users, testUsers);
      expect(updatedState.users.length, 2);
      expect(updatedState.isLoading, true);
      expect(updatedState.error, 'Loading users...');
    });

    test('should handle null error in copyWith', () {
      final stateWithError = initialState.copyWith(error: 'Some error');
      final stateWithoutError = stateWithError.copyWith(error: null);

      expect(stateWithError.error, 'Some error');
      expect(stateWithoutError.error, isNull);
    });

    test('should maintain immutability', () {
      final originalState = UserListState(
        users: [testUser1],
        isLoading: false,
        error: null,
      );

      final modifiedState = originalState.copyWith(
        users: testUsers,
        isLoading: true,
        error: 'Modified error',
      );

      expect(originalState.users.length, 1);
      expect(originalState.isLoading, false);
      expect(originalState.error, isNull);
      expect(modifiedState.users.length, 2);
      expect(modifiedState.isLoading, true);
      expect(modifiedState.error, 'Modified error');
    });

    test('should handle empty users list', () {
      final stateWithUsers = UserListState(users: testUsers);
      final stateWithEmptyUsers = stateWithUsers.copyWith(users: []);

      expect(stateWithUsers.users.length, 2);
      expect(stateWithEmptyUsers.users, isEmpty);
    });

    test('should preserve user data integrity', () {
      final stateWithUsers = UserListState(users: testUsers);

      expect(stateWithUsers.users[0].firstName, 'Juan');
      expect(stateWithUsers.users[0].lastName, 'Pérez');
      expect(stateWithUsers.users[1].firstName, 'Ana');
      expect(stateWithUsers.users[1].lastName, 'García');
      expect(stateWithUsers.users[1].addresses.length, 1);
    });

    test('should handle single user in list', () {
      final singleUserState = UserListState(users: [testUser1]);

      expect(singleUserState.users.length, 1);
      expect(singleUserState.users.first, testUser1);
    });
  });
}
