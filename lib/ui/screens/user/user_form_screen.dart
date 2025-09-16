import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_users/l10n/app_localizations.dart';
import '../../../viewmodels/user_form_viewmodel.dart';
import '../../../viewmodels/user_viewmodel.dart';
import '../../../models/user.dart';
import '../../../shared/components/templates/app_scaffold.dart';
import '../../../shared/components/atoms/custom_input.dart';
import '../../../shared/components/atoms/custom_button.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  static const String userFormRoute = '/user-form';
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _selectedDate;
  late AppLocalizations _localizations;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _firstNameController.text = widget.user!.firstName;
      _lastNameController.text = widget.user!.lastName;
      _selectedDate = widget.user!.birthDate;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final formViewModel = ref.read(userFormViewModelProvider.notifier);
        formViewModel.updateFirstName(widget.user!.firstName);
        formViewModel.updateLastName(widget.user!.lastName);
        formViewModel.updateBirthDate(widget.user!.birthDate);
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context)!;
    final formState = ref.watch(userFormViewModelProvider);
    final formViewModel = ref.read(userFormViewModelProvider.notifier);
    final userViewModel = ref.read(userViewModelProvider.notifier);

    return AppScaffold(
      title: widget.user == null ? _localizations.newUser : _localizations.editUser,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInput(
                controller: _firstNameController,
                labelText: _localizations.firstName,
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations.firstNameRequired;
                  }
                  return null;
                },
                onChanged: (value) {
                  ref.read(userFormViewModelProvider.notifier).updateFirstName(value);
                },
              ),
              const SizedBox(height: 16),

              CustomInput(
                controller: _lastNameController,
                labelText: _localizations.lastName,
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return _localizations.lastNameRequired;
                  }
                  return null;
                },
                onChanged: (value) {
                  ref.read(userFormViewModelProvider.notifier).updateLastName(value);
                },
              ),
              const SizedBox(height: 16),

              InkWell(
                onTap: () => _selectDate(context, formViewModel),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: '${_localizations.birthDate} *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: _selectedDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _selectedDate = null;
                              });
                            },
                          )
                        : null,
                  ),
                  child: Text(
                    _selectedDate != null
                        ? _formatDate(_selectedDate!)
                        : _localizations.birthDate,
                    style: TextStyle(
                      color: _selectedDate != null
                          ? Theme.of(context).textTheme.bodyLarge?.color
                          : Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade600),
                          const SizedBox(width: 8),
                          Text(
                            _localizations.information,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.blue.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Después de crear el usuario, podrás agregar direcciones desde la pantalla de detalles.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: _localizations.cancel,
                      type: ButtonType.secondary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: widget.user == null ? _localizations.save : _localizations.updateUser,
                      type: ButtonType.primary,
                      isLoading: formState.isLoading,
                      onPressed: formState.isLoading ? null : () => _saveUser(context, formViewModel, userViewModel),
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

  Future<void> _selectDate(
    BuildContext context,
    UserFormViewModel formViewModel,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: _localizations.birthDate,
      cancelText: _localizations.cancel,
      confirmText: 'Aceptar',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      formViewModel.updateBirthDate(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _saveUser(
    BuildContext context,
    UserFormViewModel formViewModel,
    UserViewModel userViewModel,
  ) async {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_localizations.birthDateRequired),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    try {
      formViewModel.setLoading(true);

      if (widget.user == null) {
        final newUser = formViewModel.createUser();
        await userViewModel.addUser(newUser);

        if (context.mounted) {
          formViewModel.reset();
          Navigator.of(context).pop(true);
        }
      } else {
        final updatedUser = widget.user!.copyWith(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          birthDate: _selectedDate!,
        );
        await userViewModel.updateUser(updatedUser);

        if (context.mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      formViewModel.setError(_localizations.errorSavingUser(e.toString()));
    } finally {
      formViewModel.setLoading(false);
    }
  }
}
