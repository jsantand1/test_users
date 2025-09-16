import 'package:flutter_test/flutter_test.dart';
import 'package:test_users/viewmodels/address_form_viewmodel.dart';
import 'package:test_users/models/address.dart';

void main() {
  group('AddressFormViewModel Tests', () {
    late AddressFormViewModel viewModel;
    late Address testAddress;

    setUp(() {
      viewModel = AddressFormViewModel();
      testAddress = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        isPrimary: true,
        additionalInfo: 'Apartamento 101',
      );
    });

    test('should initialize with empty state', () {
      expect(viewModel.state.country, '');
      expect(viewModel.state.department, '');
      expect(viewModel.state.municipality, '');
      expect(viewModel.state.streetAddress, '');
      expect(viewModel.state.additionalInfo, '');
      expect(viewModel.state.isPrimary, false);
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.error, isNull);
      expect(viewModel.state.isValid, false);
    });

    test('should update country and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateCountry('Colombia');

      expect(viewModel.state.country, 'Colombia');
      expect(viewModel.state.error, isNull);
    });

    test('should update department and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateDepartment('Antioquia');

      expect(viewModel.state.department, 'Antioquia');
      expect(viewModel.state.error, isNull);
    });

    test('should update municipality and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateMunicipality('Medellín');

      expect(viewModel.state.municipality, 'Medellín');
      expect(viewModel.state.error, isNull);
    });

    test('should update street address and clear error', () {
      viewModel.state = viewModel.state.copyWith(error: 'Test error');
      
      viewModel.updateStreetAddress('Calle 123 #45-67');

      expect(viewModel.state.streetAddress, 'Calle 123 #45-67');
      expect(viewModel.state.error, isNull);
    });

    test('should update additional info without affecting validation', () {
      viewModel.updateAdditionalInfo('Apartamento 101');

      expect(viewModel.state.additionalInfo, 'Apartamento 101');
      expect(viewModel.state.isValid, false); // Still invalid because required fields are empty
    });

    test('should update isPrimary flag', () {
      viewModel.updateIsPrimary(true);

      expect(viewModel.state.isPrimary, true);
    });

    test('should validate form correctly when all required fields are filled', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');

      expect(viewModel.state.isValid, true);
    });

    test('should invalidate form when country is empty', () {
      viewModel.updateCountry('');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when department is empty', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when municipality is empty', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('');
      viewModel.updateStreetAddress('Calle 123 #45-67');

      expect(viewModel.state.isValid, false);
    });

    test('should invalidate form when street address is empty', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('');

      expect(viewModel.state.isValid, false);
    });

    test('should handle whitespace in required fields correctly', () {
      viewModel.updateCountry('  Colombia  ');
      viewModel.updateDepartment('  Antioquia  ');
      viewModel.updateMunicipality('  Medellín  ');
      viewModel.updateStreetAddress('  Calle 123 #45-67  ');

      expect(viewModel.state.isValid, true);
    });

    test('should invalidate form with only whitespace in required fields', () {
      viewModel.updateCountry('   ');
      viewModel.updateDepartment('   ');
      viewModel.updateMunicipality('   ');
      viewModel.updateStreetAddress('   ');

      expect(viewModel.state.isValid, false);
    });

    test('should create address successfully when form is valid', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');
      viewModel.updateAdditionalInfo('Apartamento 101');
      viewModel.updateIsPrimary(true);

      final address = viewModel.createAddress();

      expect(address.country, 'Colombia');
      expect(address.department, 'Antioquia');
      expect(address.municipality, 'Medellín');
      expect(address.streetAddress, 'Calle 123 #45-67');
      expect(address.additionalInfo, 'Apartamento 101');
      expect(address.isPrimary, true);
      expect(address.id, isNotEmpty);
    });

    test('should trim whitespace when creating address', () {
      viewModel.updateCountry('  Colombia  ');
      viewModel.updateDepartment('  Antioquia  ');
      viewModel.updateMunicipality('  Medellín  ');
      viewModel.updateStreetAddress('  Calle 123 #45-67  ');
      viewModel.updateAdditionalInfo('  Apartamento 101  ');

      final address = viewModel.createAddress();

      expect(address.country, 'Colombia');
      expect(address.department, 'Antioquia');
      expect(address.municipality, 'Medellín');
      expect(address.streetAddress, 'Calle 123 #45-67');
      expect(address.additionalInfo, 'Apartamento 101');
    });

    test('should set additionalInfo to null when empty', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');
      viewModel.updateAdditionalInfo('');

      final address = viewModel.createAddress();

      expect(address.additionalInfo, isNull);
    });

    test('should set additionalInfo to null when only whitespace', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');
      viewModel.updateAdditionalInfo('   ');

      final address = viewModel.createAddress();

      expect(address.additionalInfo, isNull);
    });

    test('should throw exception when creating address with invalid form', () {
      viewModel.updateCountry('Colombia');
      // Missing required fields

      expect(() => viewModel.createAddress(), throwsException);
    });

    test('should reset form to initial state', () {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');
      viewModel.updateAdditionalInfo('Apartamento 101');
      viewModel.updateIsPrimary(true);
      viewModel.setError('Test error');
      viewModel.setLoading(true);

      viewModel.reset();

      expect(viewModel.state.country, '');
      expect(viewModel.state.department, '');
      expect(viewModel.state.municipality, '');
      expect(viewModel.state.streetAddress, '');
      expect(viewModel.state.additionalInfo, '');
      expect(viewModel.state.isPrimary, false);
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

    test('should load existing address correctly', () {
      viewModel.loadAddress(testAddress);

      expect(viewModel.state.country, 'Colombia');
      expect(viewModel.state.department, 'Antioquia');
      expect(viewModel.state.municipality, 'Medellín');
      expect(viewModel.state.streetAddress, 'Calle 123 #45-67');
      expect(viewModel.state.additionalInfo, 'Apartamento 101');
      expect(viewModel.state.isPrimary, true);
      expect(viewModel.state.isValid, true);
    });

    test('should load address with null additionalInfo', () {
      final addressWithoutInfo = testAddress.copyWith(additionalInfo: null);
      
      viewModel.loadAddress(addressWithoutInfo);

      expect(viewModel.state.additionalInfo, '');
      expect(viewModel.state.isValid, true);
    });

    test('should generate unique IDs for different addresses', () async {
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');

      final address1 = viewModel.createAddress();
      
      // Small delay to ensure different timestamp
      await Future.delayed(const Duration(milliseconds: 2));
      
      final address2 = viewModel.createAddress();

      expect(address1.id, isNot(equals(address2.id)));
    });

    test('should validate form after each required field update', () {
      expect(viewModel.state.isValid, false);

      viewModel.updateCountry('Colombia');
      expect(viewModel.state.isValid, false);

      viewModel.updateDepartment('Antioquia');
      expect(viewModel.state.isValid, false);

      viewModel.updateMunicipality('Medellín');
      expect(viewModel.state.isValid, false);

      viewModel.updateStreetAddress('Calle 123 #45-67');
      expect(viewModel.state.isValid, true);
    });

    test('should not affect validation when updating non-required fields', () {
      // Set up valid form first
      viewModel.updateCountry('Colombia');
      viewModel.updateDepartment('Antioquia');
      viewModel.updateMunicipality('Medellín');
      viewModel.updateStreetAddress('Calle 123 #45-67');
      
      expect(viewModel.state.isValid, true);

      // Update non-required fields
      viewModel.updateAdditionalInfo('New info');
      expect(viewModel.state.isValid, true);

      viewModel.updateIsPrimary(true);
      expect(viewModel.state.isValid, true);
    });
  });
}
