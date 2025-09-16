// Estado para el formulario de dirección
class AddressFormState {
  final String country;
  final String department;
  final String municipality;
  final String streetAddress;
  final String additionalInfo;
  final bool isPrimary;
  final bool isLoading;
  final String? error;
  final bool isValid;

  const AddressFormState({
    this.country = '',
    this.department = '',
    this.municipality = '',
    this.streetAddress = '',
    this.additionalInfo = '',
    this.isPrimary = false,
    this.isLoading = false,
    this.error,
    this.isValid = false,
  });

  AddressFormState copyWith({
    String? country,
    String? department,
    String? municipality,
    String? streetAddress,
    String? additionalInfo,
    bool? isPrimary,
    bool? isLoading,
    String? error,
    bool? isValid,
  }) {
    return AddressFormState(
      country: country ?? this.country,
      department: department ?? this.department,
      municipality: municipality ?? this.municipality,
      streetAddress: streetAddress ?? this.streetAddress,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      isPrimary: isPrimary ?? this.isPrimary,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isValid: isValid ?? this.isValid,
    );
  }
}
