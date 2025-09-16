import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_users/l10n/app_localizations.dart';
import '../../viewmodels/address_form_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../../models/address.dart';
import '../../shared/components/templates/app_scaffold.dart';
import '../../shared/components/atoms/custom_input.dart';
import '../../shared/components/atoms/custom_button.dart';

class AddressFormScreen extends ConsumerStatefulWidget {
  static const String addressFormRoute = '/address-form';
  final String userId;
  final Address? address;

  const AddressFormScreen({
    super.key,
    required this.userId,
    this.address,
  });

  @override
  ConsumerState<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends ConsumerState<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _departmentController = TextEditingController();
  final _municipalityController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  bool _isPrimary = false;
  AppLocalizations? _localizations;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _countryController.text = widget.address!.country;
      _departmentController.text = widget.address!.department;
      _municipalityController.text = widget.address!.municipality;
      _streetAddressController.text = widget.address!.streetAddress;
      _additionalInfoController.text = widget.address!.additionalInfo ?? '';
      _isPrimary = widget.address!.isPrimary;
      
      // Inicializar el ViewModel con los datos de la dirección
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final formViewModel = ref.read(addressFormViewModelProvider.notifier);
        formViewModel.loadAddress(widget.address!);
      });
    }
  }

  @override
  void dispose() {
    _countryController.dispose();
    _departmentController.dispose();
    _municipalityController.dispose();
    _streetAddressController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localizations ??= AppLocalizations.of(context)!;
    final formState = ref.watch(addressFormViewModelProvider);
    final formViewModel = ref.read(addressFormViewModelProvider.notifier);
    final userViewModel = ref.read(userViewModelProvider.notifier);

    return AppScaffold(
      title: widget.address == null ? _localizations!.newAddress : _localizations!.editAddress,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mostrar error si existe
              if (formState.error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          formState.error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),

              // Campo País
              CustomInput(
                controller: _countryController,
                labelText: _localizations!.country,
                prefixIcon: Icons.public,
                hintText: 'Ej: Colombia',
                onChanged: (value) {
                  formViewModel.updateCountry(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations!.countryRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Departamento
              CustomInput(
                controller: _departmentController,
                labelText: _localizations!.department,
                prefixIcon: Icons.location_city,
                hintText: 'Ej: Antioquia',
                onChanged: (value) {
                  formViewModel.updateDepartment(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations!.departmentRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Municipio
              CustomInput(
                controller: _municipalityController,
                labelText: _localizations!.municipality,
                prefixIcon: Icons.location_on,
                hintText: 'Ej: Medellín',
                onChanged: (value) {
                  formViewModel.updateMunicipality(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations!.municipalityRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Dirección
              CustomInput(
                controller: _streetAddressController,
                labelText: _localizations!.address,
                prefixIcon: Icons.home,
                hintText: 'Ej: Calle 123 #45-67',
                onChanged: (value) {
                  formViewModel.updateStreetAddress(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations!.addressRequired;
                  }
                  return null;
                },
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),

              // Botones de acción
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: _localizations!.cancel,
                      type: ButtonType.secondary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: widget.address == null ? _localizations!.save : _localizations!.updateAddress,
                      type: ButtonType.primary,
                      isLoading: formState.isLoading,
                      onPressed: formState.isLoading ? null : () => _saveAddress(context, formViewModel, userViewModel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddress(
    BuildContext context,
    AddressFormViewModel formViewModel,
    UserViewModel userViewModel,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      formViewModel.setLoading(true);

      if (widget.address == null) {
        // Crear nueva dirección
        final newAddress = formViewModel.createAddress();
        await userViewModel.addAddressToUser(widget.userId, newAddress);
        
        if (context.mounted) {
          formViewModel.reset();
          Navigator.of(context).pop(true); // Retorna true para indicar éxito
        }
      } else {
        // Actualizar dirección existente
        final updatedAddress = widget.address!.copyWith(
          country: _countryController.text.trim(),
          department: _departmentController.text.trim(),
          municipality: _municipalityController.text.trim(),
          streetAddress: _streetAddressController.text.trim(),
          additionalInfo: _additionalInfoController.text.trim().isEmpty 
              ? null 
              : _additionalInfoController.text.trim(),
          isPrimary: _isPrimary,
        );
        await userViewModel.updateUserAddress(widget.userId, updatedAddress);
        
        if (context.mounted) {
          Navigator.of(context).pop(true); // Retorna true para indicar éxito
        }
      }
    } catch (e) {
      formViewModel.setError(_localizations!.errorSavingAddress(e.toString()));
    } finally {
      formViewModel.setLoading(false);
    }
  }
}
