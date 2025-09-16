// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'User Management';

  @override
  String get userManagement => 'User Management';

  @override
  String get manageUsersAndAddresses => 'Manage users and addresses';

  @override
  String get users => 'Users';

  @override
  String get addresses => 'Addresses';

  @override
  String get newUser => 'New User';

  @override
  String get editUser => 'Edit User';

  @override
  String get userNotFound => 'User not found';

  @override
  String get userDoesNotExist => 'The user does not exist';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get age => 'Age';

  @override
  String get years => 'years';

  @override
  String get country => 'Country';

  @override
  String get department => 'Department';

  @override
  String get municipality => 'Municipality';

  @override
  String get address => 'Address';

  @override
  String get additionalInfo => 'Additional Information';

  @override
  String get primaryAddress => 'Primary Address';

  @override
  String get markAsPrimaryAddress => 'Mark as user\'s primary address';

  @override
  String get newAddress => 'New Address';

  @override
  String get editAddress => 'Edit Address';

  @override
  String get addAddress => 'Add Address';

  @override
  String get createAddress => 'Create Address';

  @override
  String get updateAddress => 'Update Address';

  @override
  String get createUser => 'Create User';

  @override
  String get updateUser => 'Update User';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get confirmDeletion => 'Confirm deletion';

  @override
  String areYouSureDeleteUser(Object userName) {
    return 'Are you sure you want to delete $userName?';
  }

  @override
  String areYouSureDeleteAddress(Object address) {
    return 'Are you sure you want to delete this address?\n\n$address';
  }

  @override
  String get noUsersRegistered => 'No users registered';

  @override
  String get addFirstUser => 'Add the first user';

  @override
  String get noAddressesRegistered => 'No addresses registered';

  @override
  String get addFirstAddress => 'Add the first address';

  @override
  String get primary => 'Primary';

  @override
  String get information => 'Information';

  @override
  String get primaryAddressInfo =>
      'If you mark this address as primary, it will become the user\'s default address.';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get birthDateRequired => 'Birth date is required';

  @override
  String get countryRequired => 'Country is required';

  @override
  String get departmentRequired => 'Department is required';

  @override
  String get municipalityRequired => 'Municipality is required';

  @override
  String get addressRequired => 'Address is required';

  @override
  String get userCreatedSuccessfully => 'User created successfully';

  @override
  String get userUpdatedSuccessfully => 'User updated successfully';

  @override
  String get addressCreatedSuccessfully => 'Address created successfully';

  @override
  String get addressUpdatedSuccessfully => 'Address updated successfully';

  @override
  String get userDeleted => 'User deleted';

  @override
  String get addressDeleted => 'Address deleted';

  @override
  String errorSavingUser(Object error) {
    return 'Error saving user: $error';
  }

  @override
  String errorSavingAddress(Object error) {
    return 'Error saving address: $error';
  }

  @override
  String get invalidUserForm => 'Invalid user form';

  @override
  String get invalidAddressForm => 'Invalid address form';
}
