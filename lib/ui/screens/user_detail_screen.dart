import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_users/l10n/app_localizations.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../../models/user.dart';
import '../../models/address.dart';
import '../../shared/components/templates/app_scaffold.dart';
import '../../shared/components/organisms/user_info_card.dart';
import '../../shared/components/organisms/address_card.dart';
import '../../shared/components/molecules/empty_state.dart';
import '../../shared/models/user_info_data.dart';
import '../../shared/models/info_row_data.dart';
import '../../shared/models/address_card_data.dart';
import '../../shared/models/empty_state_data.dart';
import 'address_form_screen.dart';
import 'user_form_screen.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  static const String userDetailRoute = '/user-detail';
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  AppLocalizations? _localizations;
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = ref.read(userViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    _localizations ??= AppLocalizations.of(context)!;
    final user = ref.watch(userByIdProvider(widget.userId));

    if (user == null) {
      return AppScaffold(
        title: _localizations!.userNotFound,
        body: Center(
          child: Text(_localizations!.userDoesNotExist),
        ),
      );
    }

    return AppScaffold(
      title: user.fullName,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _navigateToEditUser(context, user),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoCard(
              data: _createUserInfoData(user),
              onEdit: () => _navigateToEditUser(context, user),
            ),
            const SizedBox(height: 16),
            
            _buildAddressesSection(context, user),
          ],
        ),
      ),
    );
  }

  UserInfoData _createUserInfoData(User user) {
    return UserInfoData(
      fullName: user.fullName,
      initials: user.initials,
      
      infoRows: [
        InfoRowData(label: _localizations!.firstName, value: user.firstName),
        InfoRowData(label: _localizations!.lastName, value: user.lastName),
      ],
    );
  }

  Widget _buildAddressesSection(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _localizations!.addresses,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddressForm(context, user.id),
              icon: const Icon(Icons.add, size: 18),
              label: Text(_localizations!.addAddress),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        user.addresses.isEmpty
            ? EmptyState(
                data: EmptyStateData(
                  iconData: 'location_off',
                  title: _localizations!.noAddressesRegistered,
                  subtitle: _localizations!.addFirstAddress,
                ),
              )
            : _buildAddressList(context, user, userViewModel),
      ],
    );
  }


  Widget _buildAddressList(BuildContext context, User user, UserViewModel userViewModel) {
    return Column(
      children: user.addresses.map((address) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AddressCard(
            data: AddressCardData(
              streetAddress: address.streetAddress,
              location: '${address.municipality}, ${address.department}',
              country: address.country,
              additionalInfo: address.additionalInfo?.isNotEmpty == true ? address.additionalInfo : null,
              isPrimary: address.isPrimary,
            ),
            primaryText: _localizations!.primary,
            editText: _localizations!.edit,
            deleteText: _localizations!.delete,
            onEdit: () => _navigateToAddressForm(context, user.id, address: address),
            onDelete: () => _showDeleteAddressConfirmation(context, user.id, address, userViewModel),
          ),
        );
      }).toList(),
    );
  }


  void _navigateToEditUser(BuildContext context, User user) async {
    final result = await Navigator.of(context).pushNamed(
      UserFormScreen.userFormRoute,
      arguments: user,
    );
    
    if (result == true && context.mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_localizations!.userUpdatedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _navigateToAddressForm(BuildContext context, String userId, {Address? address}) async {
    final result = await Navigator.of(context).pushNamed(
      AddressFormScreen.addressFormRoute,
      arguments: {
        'userId': userId,
        'address': address,
      },
    );
    
    if (result == true && context.mounted) {
      setState(() {});
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(address == null ? _localizations!.addressCreatedSuccessfully : _localizations!.addressUpdatedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showDeleteAddressConfirmation(
    BuildContext context,
    String userId,
    Address address,
    UserViewModel userViewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_localizations!.confirmDeletion),
        content: Text(_localizations!.areYouSureDeleteAddress(address.streetAddress)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_localizations!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              userViewModel.deleteUserAddress(userId, address.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_localizations!.addressDeleted),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(_localizations!.delete),
          ),
        ],
      ),
    );
  }
}
