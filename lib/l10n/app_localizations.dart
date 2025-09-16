import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Usuarios'**
  String get appTitle;

  /// No description provided for @userManagement.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Usuarios'**
  String get userManagement;

  /// No description provided for @manageUsersAndAddresses.
  ///
  /// In es, this message translates to:
  /// **'Administra usuarios y direcciones'**
  String get manageUsersAndAddresses;

  /// No description provided for @users.
  ///
  /// In es, this message translates to:
  /// **'Usuarios'**
  String get users;

  /// No description provided for @addresses.
  ///
  /// In es, this message translates to:
  /// **'Direcciones'**
  String get addresses;

  /// No description provided for @newUser.
  ///
  /// In es, this message translates to:
  /// **'Nuevo Usuario'**
  String get newUser;

  /// No description provided for @editUser.
  ///
  /// In es, this message translates to:
  /// **'Editar Usuario'**
  String get editUser;

  /// No description provided for @userNotFound.
  ///
  /// In es, this message translates to:
  /// **'Usuario no encontrado'**
  String get userNotFound;

  /// No description provided for @userDoesNotExist.
  ///
  /// In es, this message translates to:
  /// **'El usuario no existe'**
  String get userDoesNotExist;

  /// No description provided for @firstName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get lastName;

  /// No description provided for @birthDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de Nacimiento'**
  String get birthDate;

  /// No description provided for @age.
  ///
  /// In es, this message translates to:
  /// **'Edad'**
  String get age;

  /// No description provided for @years.
  ///
  /// In es, this message translates to:
  /// **'años'**
  String get years;

  /// No description provided for @country.
  ///
  /// In es, this message translates to:
  /// **'País'**
  String get country;

  /// No description provided for @department.
  ///
  /// In es, this message translates to:
  /// **'Departamento'**
  String get department;

  /// No description provided for @municipality.
  ///
  /// In es, this message translates to:
  /// **'Municipio'**
  String get municipality;

  /// No description provided for @address.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get address;

  /// No description provided for @additionalInfo.
  ///
  /// In es, this message translates to:
  /// **'Información Adicional'**
  String get additionalInfo;

  /// No description provided for @primaryAddress.
  ///
  /// In es, this message translates to:
  /// **'Dirección Principal'**
  String get primaryAddress;

  /// No description provided for @markAsPrimaryAddress.
  ///
  /// In es, this message translates to:
  /// **'Marcar como dirección principal del usuario'**
  String get markAsPrimaryAddress;

  /// No description provided for @newAddress.
  ///
  /// In es, this message translates to:
  /// **'Nueva Dirección'**
  String get newAddress;

  /// No description provided for @editAddress.
  ///
  /// In es, this message translates to:
  /// **'Editar Dirección'**
  String get editAddress;

  /// No description provided for @addAddress.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get addAddress;

  /// No description provided for @createAddress.
  ///
  /// In es, this message translates to:
  /// **'Crear Dirección'**
  String get createAddress;

  /// No description provided for @updateAddress.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Dirección'**
  String get updateAddress;

  /// No description provided for @createUser.
  ///
  /// In es, this message translates to:
  /// **'Crear Usuario'**
  String get createUser;

  /// No description provided for @updateUser.
  ///
  /// In es, this message translates to:
  /// **'Actualizar Usuario'**
  String get updateUser;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @confirmDeletion.
  ///
  /// In es, this message translates to:
  /// **'Confirmar eliminación'**
  String get confirmDeletion;

  /// No description provided for @areYouSureDeleteUser.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar a {userName}?'**
  String areYouSureDeleteUser(Object userName);

  /// No description provided for @areYouSureDeleteAddress.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar esta dirección?\n\n{address}'**
  String areYouSureDeleteAddress(Object address);

  /// No description provided for @noUsersRegistered.
  ///
  /// In es, this message translates to:
  /// **'Sin usuarios registrados'**
  String get noUsersRegistered;

  /// No description provided for @addFirstUser.
  ///
  /// In es, this message translates to:
  /// **'Agrega el primer usuario'**
  String get addFirstUser;

  /// No description provided for @noAddressesRegistered.
  ///
  /// In es, this message translates to:
  /// **'Sin direcciones registradas'**
  String get noAddressesRegistered;

  /// No description provided for @addFirstAddress.
  ///
  /// In es, this message translates to:
  /// **'Agrega la primera dirección'**
  String get addFirstAddress;

  /// No description provided for @primary.
  ///
  /// In es, this message translates to:
  /// **'Principal'**
  String get primary;

  /// No description provided for @information.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get information;

  /// No description provided for @primaryAddressInfo.
  ///
  /// In es, this message translates to:
  /// **'Si marcas esta dirección como principal, se convertirá en la dirección predeterminada del usuario.'**
  String get primaryAddressInfo;

  /// No description provided for @firstNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El nombre es requerido'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In es, this message translates to:
  /// **'El apellido es requerido'**
  String get lastNameRequired;

  /// No description provided for @birthDateRequired.
  ///
  /// In es, this message translates to:
  /// **'La fecha de nacimiento es requerida'**
  String get birthDateRequired;

  /// No description provided for @countryRequired.
  ///
  /// In es, this message translates to:
  /// **'El país es requerido'**
  String get countryRequired;

  /// No description provided for @departmentRequired.
  ///
  /// In es, this message translates to:
  /// **'El departamento es requerido'**
  String get departmentRequired;

  /// No description provided for @municipalityRequired.
  ///
  /// In es, this message translates to:
  /// **'El municipio es requerido'**
  String get municipalityRequired;

  /// No description provided for @addressRequired.
  ///
  /// In es, this message translates to:
  /// **'La dirección es requerida'**
  String get addressRequired;

  /// No description provided for @userCreatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Usuario creado exitosamente'**
  String get userCreatedSuccessfully;

  /// No description provided for @userUpdatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Usuario actualizado exitosamente'**
  String get userUpdatedSuccessfully;

  /// No description provided for @addressCreatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Dirección agregada exitosamente'**
  String get addressCreatedSuccessfully;

  /// No description provided for @addressUpdatedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Dirección actualizada exitosamente'**
  String get addressUpdatedSuccessfully;

  /// No description provided for @userDeleted.
  ///
  /// In es, this message translates to:
  /// **'Usuario eliminado'**
  String get userDeleted;

  /// No description provided for @addressDeleted.
  ///
  /// In es, this message translates to:
  /// **'Dirección eliminada'**
  String get addressDeleted;

  /// No description provided for @errorSavingUser.
  ///
  /// In es, this message translates to:
  /// **'Error al guardar usuario: {error}'**
  String errorSavingUser(Object error);

  /// No description provided for @errorSavingAddress.
  ///
  /// In es, this message translates to:
  /// **'Error al guardar dirección: {error}'**
  String errorSavingAddress(Object error);

  /// No description provided for @invalidUserForm.
  ///
  /// In es, this message translates to:
  /// **'Formulario de usuario inválido'**
  String get invalidUserForm;

  /// No description provided for @invalidAddressForm.
  ///
  /// In es, this message translates to:
  /// **'Formulario de dirección inválido'**
  String get invalidAddressForm;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
