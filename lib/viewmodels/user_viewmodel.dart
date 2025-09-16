import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/address.dart';
import '../states/user_list_state.dart';

class UserViewModel extends StateNotifier<UserListState> {
  UserViewModel() : super(const UserListState());

  Future<void> addUser(User user) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = [...state.users, user];
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al agregar usuario: ${e.toString()}',
      );
    }
  }

  Future<void> updateUser(User updatedUser) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = state.users.map((user) {
        return user.id == updatedUser.id ? updatedUser : user;
      }).toList();
      
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al actualizar usuario: ${e.toString()}',
      );
    }
  }

  Future<void> deleteUser(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = state.users.where((user) => user.id != userId).toList();
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al eliminar usuario: ${e.toString()}',
      );
    }
  }

  Future<void> addAddressToUser(String userId, Address address) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = state.users.map((user) {
        if (user.id == userId) {
          final updatedAddresses = [...user.addresses, address];
          return user.copyWith(addresses: updatedAddresses);
        }
        return user;
      }).toList();
      
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al agregar dirección: ${e.toString()}',
      );
    }
  }

  Future<void> updateUserAddress(String userId, Address updatedAddress) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = state.users.map((user) {
        if (user.id == userId) {
          final updatedAddresses = user.addresses.map((address) {
            return address.id == updatedAddress.id ? updatedAddress : address;
          }).toList();
          return user.copyWith(addresses: updatedAddresses);
        }
        return user;
      }).toList();
      
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al actualizar dirección: ${e.toString()}',
      );
    }
  }

  Future<void> deleteUserAddress(String userId, String addressId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final updatedUsers = state.users.map((user) {
        if (user.id == userId) {
          final updatedAddresses = user.addresses.where((address) => address.id != addressId).toList();
          return user.copyWith(addresses: updatedAddresses);
        }
        return user;
      }).toList();
      
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al eliminar dirección: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  User? getUserById(String userId) {
    try {
      return state.users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }
}

final userViewModelProvider = StateNotifierProvider<UserViewModel, UserListState>((ref) {
  return UserViewModel();
});

final userByIdProvider = Provider.family<User?, String>((ref, String userId) {
  final userState = ref.watch(userViewModelProvider);
   print("🔄 Rebuild userByIdProvider for id=$userId, total=${userState.users.length}");
  try {
    return userState.users.firstWhere((user) => user.id == userId);
  } catch (_) {
    return null;
  }
});
