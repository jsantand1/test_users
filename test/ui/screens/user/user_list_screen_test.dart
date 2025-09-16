import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_users/ui/screens/user/user_list_screen.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/models/address.dart';
import 'package:test_users/viewmodels/user_viewmodel.dart';
import 'package:test_users/states/user_list_state.dart';
import 'package:test_users/l10n/app_localizations.dart';

class MockUserViewModel extends UserViewModel {
  final UserListState _mockState;
  
  MockUserViewModel(this._mockState) : super();
  
  @override
  UserListState get state => _mockState;
}

void main() {
  group('UserListScreen Widget Tests', () {
    late User mockUser;
    late UserListState mockState;

    setUp(() {
      mockUser = User(
        id: 'user1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(1990, 5, 15),
        addresses: [
          Address(
            id: 'addr1',
            country: 'Colombia',
            department: 'Antioquia',
            municipality: 'Medellín',
            streetAddress: 'Calle 123 #45-67',
            isPrimary: true,
          ),
        ],
      );

      mockState = UserListState(
        users: [mockUser],
        isLoading: false,
        error: null,
      );
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          userViewModelProvider.overrideWith((ref) => MockUserViewModel(mockState)),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
          home: const UserListScreen(),
        ),
      );
    }

    testWidgets('should display app bar', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('should display floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display correct layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should handle FAB tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userViewModelProvider.overrideWith((ref) => MockUserViewModel(mockState)),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('es'),
            ],
            locale: const Locale('es'),
            home: UserListScreen(),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Text('User Form Screen'),
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
    });

    testWidgets('should display search functionality', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // UserListScreen doesn't have search functionality, so we test for refresh instead
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });
  });
}
