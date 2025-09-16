import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/address.dart';
import '../states/user_list_state.dart';

// ViewModel para gestionar usuarios
class UserViewModel extends StateNotifier<UserListState> {
  UserViewModel() : super(const UserListState());

  // Agregar un nuevo usuario
  Future<void> addUser(User user) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simular delay de API
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

  // Actualizar un usuario existente
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

  // Eliminar un usuario
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

  // Agregar dirección a un usuario
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

  // Actualizar dirección de un usuario
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

  // Eliminar dirección de un usuario
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

  // Limpiar errores
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Obtener usuario por ID
  User? getUserById(String userId) {
    try {
      return state.users.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }
}

// Provider para el ViewModel de usuarios
final userViewModelProvider = StateNotifierProvider<UserViewModel, UserListState>((ref) {
  return UserViewModel();
});

// Provider para obtener un usuario específico
final userByIdProvider = Provider.family<User?, String>((ref, userId) {
  final userState = ref.watch(userViewModelProvider);
  return userState.users.where((user) => user.id == userId).firstOrNull;
});
