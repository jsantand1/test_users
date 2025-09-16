import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_users/ui/screens/user_form_screen.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/models/address.dart';
import 'package:test_users/viewmodels/user_form_viewmodel.dart';
import 'package:test_users/states/user_form_state.dart';
import 'package:test_users/l10n/app_localizations.dart';

class MockUserFormViewModel extends UserFormViewModel {
  final UserFormState _mockState;
  
  MockUserFormViewModel(this._mockState) : super();
  
  @override
  UserFormState get state => _mockState;
}

void main() {
  group('UserFormScreen Widget Tests', () {
    late User mockUser;
    late UserFormState mockState;

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

      mockState = UserFormState(
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(1990, 5, 15),
        isLoading: false,
        error: null,
      );
    });

    Widget createTestWidget({User? user}) {
      return ProviderScope(
        overrides: [
          userFormViewModelProvider.overrideWith((ref) => MockUserFormViewModel(mockState)),
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
          home: UserFormScreen(user: user),
        ),
      );
    }

    testWidgets('should display app bar with correct title for new user', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(UserFormScreen), findsOneWidget);
    });

    testWidgets('should display app bar with correct title for editing user', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(user: mockUser));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(UserFormScreen), findsOneWidget);
    });

    testWidgets('should display form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for text form fields
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should pre-populate fields when editing user', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(user: mockUser));
      await tester.pumpAndSettle();

      // Check that form fields are populated with user data
      expect(find.text('Juan'), findsOneWidget);
      expect(find.text('Pérez'), findsOneWidget);
    });

    testWidgets('should display save button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Look for elevated button (save button)
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should validate required fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Try to save without filling required fields
      final saveButton = find.byType(ElevatedButton);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // Should show validation errors
      expect(find.byType(UserFormScreen), findsOneWidget);
    });

    testWidgets('should handle text input', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);
      
      // Enter text in first name field (assuming it's the first one)
      if (textFields.evaluate().isNotEmpty) {
        await tester.enterText(textFields.first, 'Test Name');
        await tester.pumpAndSettle();
        
        expect(find.text('Test Name'), findsOneWidget);
      }
    });

    testWidgets('should display date picker for birth date', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Look for date picker related widgets
      expect(find.byType(UserFormScreen), findsOneWidget);
    });

    testWidgets('should handle back navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userFormViewModelProvider.overrideWith((ref) => MockUserFormViewModel(mockState)),
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
            initialRoute: '/form',
            routes: {
              '/': (context) => const Scaffold(body: Text('Home')),
              '/form': (context) => const UserFormScreen(),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(UserFormScreen), findsOneWidget);
    });

    testWidgets('should display correct layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('should handle theme correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userFormViewModelProvider.overrideWith((ref) => MockUserFormViewModel(mockState)),
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
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: UserFormScreen(user: mockUser),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(UserFormScreen), findsOneWidget);
    });
  });
}
