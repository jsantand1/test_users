class UserFormState {
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final bool isLoading;
  final String? error;
  final bool isValid;

  const UserFormState({
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    this.isLoading = false,
    this.error,
    this.isValid = false,
  });

  UserFormState copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    bool? isLoading,
    String? error,
    bool? isValid,
  }) {
    return UserFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isValid: isValid ?? this.isValid,
    );
  }
}
