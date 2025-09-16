import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/address.dart';
import '../states/address_form_state.dart';

class AddressFormViewModel extends StateNotifier<AddressFormState> {
  AddressFormViewModel() : super(const AddressFormState());

  void updateCountry(String country) {
    state = state.copyWith(country: country, error: null);
    _updateValidation();
  }

  void updateDepartment(String department) {
    state = state.copyWith(department: department, error: null);
    _updateValidation();
  }

  void updateMunicipality(String municipality) {
    state = state.copyWith(municipality: municipality, error: null);
    _updateValidation();
  }

  void updateStreetAddress(String streetAddress) {
    state = state.copyWith(streetAddress: streetAddress, error: null);
    _updateValidation();
  }

  void updateAdditionalInfo(String additionalInfo) {
    state = state.copyWith(additionalInfo: additionalInfo, error: null);
  }

  void updateIsPrimary(bool isPrimary) {
    state = state.copyWith(isPrimary: isPrimary, error: null);
  }

  void _updateValidation() {
    final isValid = _validateForm();
    state = state.copyWith(isValid: isValid);
  }

  bool _validateForm() {
    return state.country.trim().isNotEmpty &&
           state.department.trim().isNotEmpty &&
           state.municipality.trim().isNotEmpty &&
           state.streetAddress.trim().isNotEmpty;
  }

  Address createAddress() {
    if (!state.isValid) {
      throw Exception('Formulario de dirección inválido');
    }

    return Address(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      country: state.country.trim(),
      department: state.department.trim(),
      municipality: state.municipality.trim(),
      streetAddress: state.streetAddress.trim(),
      additionalInfo: state.additionalInfo.trim().isEmpty ? null : state.additionalInfo.trim(),
      isPrimary: state.isPrimary,
    );
  }

  void reset() {
    state = const AddressFormState();
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void loadAddress(Address address) {
    state = AddressFormState(
      country: address.country,
      department: address.department,
      municipality: address.municipality,
      streetAddress: address.streetAddress,
      additionalInfo: address.additionalInfo ?? '',
      isPrimary: address.isPrimary,
      isValid: true,
    );
  }
}

final addressFormViewModelProvider = StateNotifierProvider<AddressFormViewModel, AddressFormState>((ref) {
  return AddressFormViewModel();
});
