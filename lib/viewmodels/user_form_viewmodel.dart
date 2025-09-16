import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../states/user_form_state.dart';

class UserFormViewModel extends StateNotifier<UserFormState> {
  UserFormViewModel() : super(const UserFormState());

  void updateFirstName(String firstName) {
    state = state.copyWith(firstName: firstName, error: null);
    _updateValidation();
  }

  void updateLastName(String lastName) {
    state = state.copyWith(lastName: lastName, error: null);
    _updateValidation();
  }

  void updateBirthDate(DateTime birthDate) {
    state = state.copyWith(birthDate: birthDate, error: null);
    _updateValidation();
  }

  void _updateValidation() {
    final isValid = _validateForm();
    state = state.copyWith(isValid: isValid);
  }

  bool _validateForm() {
    return state.firstName.trim().isNotEmpty &&
           state.lastName.trim().isNotEmpty &&
           state.birthDate != null &&
           state.birthDate!.isBefore(DateTime.now());
  }

  User createUser() {
    if (!state.isValid) {
      throw Exception('Formulario inválido');
    }

    return User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      birthDate: state.birthDate!,
    );
  }

  void reset() {
    state = const UserFormState();
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final userFormViewModelProvider = StateNotifierProvider<UserFormViewModel, UserFormState>((ref) {
  return UserFormViewModel();
});
