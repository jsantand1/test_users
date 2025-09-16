import '../models/user.dart';

// Estado para la lista de usuarios
class UserListState {
  final List<User> users;
  final bool isLoading;
  final String? error;

  const UserListState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  UserListState copyWith({
    List<User>? users,
    bool? isLoading,
    String? error,
  }) {
    return UserListState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
