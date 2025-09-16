import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_users/l10n/app_localizations.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../../models/user.dart';
import '../../shared/components/templates/app_scaffold.dart';
import '../../shared/components/molecules/empty_state.dart';
import '../../shared/components/organisms/user_list_item.dart';
import '../../shared/models/empty_state_data.dart';
import '../../shared/models/user_list_item_data.dart';
import 'user_form_screen.dart';
import 'user_detail_screen.dart';

class UserListScreen extends ConsumerStatefulWidget {
  static const String userListRoute = '/user-list';
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
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
    final userState = ref.watch(userViewModelProvider);

    return AppScaffold(
      title: _localizations!.users,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            userViewModel.clearError();
          },
        ),
      ],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (userState.error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.red.shade100,
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      userState.error!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => userViewModel.clearError(),
                  ),
                ],
              ),
            ),
          
          // Indicador de carga
          if (userState.isLoading)
            const LinearProgressIndicator(),
          
          // Lista de usuarios
          Expanded(
            child: userState.users.isEmpty
                ? EmptyState(
                    data: EmptyStateData(
                      iconData: 'person_off',
                      title: _localizations!.noUsersRegistered,
                      subtitle: _localizations!.addFirstUser,
                    ),
                  )
                : _buildUserList(context, userState.users, userViewModel),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToUserForm(context),
        tooltip: _localizations!.newUser,
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildUserList(BuildContext context, List<User> users, UserViewModel userViewModel) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return UserListItem(
          data: UserListItemData(
            id: user.id,
            fullName: user.fullName,
            initials: user.initials,
            birthDate: '${_localizations!.birthDate}: ${_formatDate(user.birthDate)}',
            addressCount: user.addresses.length,
            editText: _localizations!.edit,
            deleteText: _localizations!.delete,
          ),
          addressText: _localizations!.address,
          addressesText: _localizations!.addresses,
          onTap: () => _navigateToUserDetail(context, user),
          onEdit: () => _navigateToUserForm(context, user: user),
          onDelete: () => _showDeleteConfirmation(context, user, userViewModel),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _navigateToUserForm(BuildContext context, {User? user}) async {
    final result = await Navigator.of(context).pushNamed(
      UserFormScreen.userFormRoute,
      arguments: user,
    );
    
    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(user == null ? _localizations!.userCreatedSuccessfully : _localizations!.userUpdatedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _navigateToUserDetail(BuildContext context, User user) {
    Navigator.of(context).pushNamed(
      UserDetailScreen.userDetailRoute,
      arguments: user.id,
    );
  }

  void _showDeleteConfirmation(BuildContext context, User user, UserViewModel userViewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_localizations!.confirmDeletion),
        content: Text(_localizations!.areYouSureDeleteUser(user.fullName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_localizations!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              userViewModel.deleteUser(user.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(_localizations!.delete),
          ),
        ],
      ),
    );
  }
}
