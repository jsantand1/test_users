import 'package:flutter/material.dart';
import '../screens/user/user_list_screen.dart';
import '../screens/user/user_form_screen.dart';
import '../screens/user/user_detail_screen.dart';
import '../screens/address/address_form_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../../models/user.dart';
import '../../models/address.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case UserListScreen.userListRoute:
      return MaterialPageRoute(
        builder: (_) => const UserListScreen(),
        settings: settings,
      );
      
    case UserFormScreen.userFormRoute:
      final args = settings.arguments as User?;
      return MaterialPageRoute(
        builder: (_) => UserFormScreen(user: args),
        settings: settings,
      );
      
    case UserDetailScreen.userDetailRoute:
      final args = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => UserDetailScreen(userId: args),
        settings: settings,
      );
      
    case AddressFormScreen.addressFormRoute:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => AddressFormScreen(
          userId: args['userId'],
          address: args['address'] as Address?,
        ),
        settings: settings,
      );
      
    case SplashScreen.splashScreenRoute:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
      
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
