// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gestión de Usuarios';

  @override
  String get userManagement => 'Gestión de Usuarios';

  @override
  String get manageUsersAndAddresses => 'Administra usuarios y direcciones';

  @override
  String get users => 'Usuarios';

  @override
  String get addresses => 'Direcciones';

  @override
  String get newUser => 'Nuevo Usuario';

  @override
  String get editUser => 'Editar Usuario';

  @override
  String get userNotFound => 'Usuario no encontrado';

  @override
  String get userDoesNotExist => 'El usuario no existe';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get birthDate => 'Fecha de Nacimiento';

  @override
  String get age => 'Edad';

  @override
  String get years => 'años';

  @override
  String get country => 'País';

  @override
  String get department => 'Departamento';

  @override
  String get municipality => 'Municipio';

  @override
  String get address => 'Dirección';

  @override
  String get additionalInfo => 'Información Adicional';

  @override
  String get primaryAddress => 'Dirección Principal';

  @override
  String get markAsPrimaryAddress =>
      'Marcar como dirección principal del usuario';

  @override
  String get newAddress => 'Nueva Dirección';

  @override
  String get editAddress => 'Editar Dirección';

  @override
  String get addAddress => 'Agregar';

  @override
  String get createAddress => 'Crear Dirección';

  @override
  String get updateAddress => 'Actualizar Dirección';

  @override
  String get createUser => 'Crear Usuario';

  @override
  String get updateUser => 'Actualizar Usuario';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirmDeletion => 'Confirmar eliminación';

  @override
  String areYouSureDeleteUser(Object userName) {
    return '¿Estás seguro de que deseas eliminar a $userName?';
  }

  @override
  String areYouSureDeleteAddress(Object address) {
    return '¿Estás seguro de que deseas eliminar esta dirección?\n\n$address';
  }

  @override
  String get noUsersRegistered => 'Sin usuarios registrados';

  @override
  String get addFirstUser => 'Agrega el primer usuario';

  @override
  String get noAddressesRegistered => 'Sin direcciones registradas';

  @override
  String get addFirstAddress => 'Agrega la primera dirección';

  @override
  String get primary => 'Principal';

  @override
  String get information => 'Información';

  @override
  String get primaryAddressInfo =>
      'Si marcas esta dirección como principal, se convertirá en la dirección predeterminada del usuario.';

  @override
  String get firstNameRequired => 'El nombre es requerido';

  @override
  String get lastNameRequired => 'El apellido es requerido';

  @override
  String get birthDateRequired => 'La fecha de nacimiento es requerida';

  @override
  String get countryRequired => 'El país es requerido';

  @override
  String get departmentRequired => 'El departamento es requerido';

  @override
  String get municipalityRequired => 'El municipio es requerido';

  @override
  String get addressRequired => 'La dirección es requerida';

  @override
  String get userCreatedSuccessfully => 'Usuario creado exitosamente';

  @override
  String get userUpdatedSuccessfully => 'Usuario actualizado exitosamente';

  @override
  String get addressCreatedSuccessfully => 'Dirección agregada exitosamente';

  @override
  String get addressUpdatedSuccessfully => 'Dirección actualizada exitosamente';

  @override
  String get userDeleted => 'Usuario eliminado';

  @override
  String get addressDeleted => 'Dirección eliminada';

  @override
  String errorSavingUser(Object error) {
    return 'Error al guardar usuario: $error';
  }

  @override
  String errorSavingAddress(Object error) {
    return 'Error al guardar dirección: $error';
  }

  @override
  String get invalidUserForm => 'Formulario de usuario inválido';

  @override
  String get invalidAddressForm => 'Formulario de dirección inválido';
}
