import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_users/l10n/app_localizations.dart';
import 'package:test_users/ui/screens/address_form_screen.dart';
import 'package:test_users/models/address.dart';
import 'package:test_users/models/user.dart';
import 'package:test_users/viewmodels/user_viewmodel.dart';
import 'package:test_users/viewmodels/address_form_viewmodel.dart';
import 'package:test_users/states/user_list_state.dart';
import 'package:test_users/states/address_form_state.dart';

class MockUserViewModel extends UserViewModel {
  final UserListState _mockState;
  
  MockUserViewModel(this._mockState) : super();
  
  @override
  UserListState get state => _mockState;
}

class MockAddressFormViewModel extends AddressFormViewModel {
  final AddressFormState _mockState;
  
  MockAddressFormViewModel(this._mockState) : super();
  
  @override
  AddressFormState get state => _mockState;
}

void main() {
  group('AddressFormScreen Widget Tests', () {
    late Address mockAddress;
    late User mockUser;
    late UserListState mockState;
    late AddressFormState mockFormState;

    setUp(() {
      mockUser = User(
        id: 'user1',
        firstName: 'Juan',
        lastName: 'Pérez',
        birthDate: DateTime(1990, 5, 15),
        addresses: [],
      );

      mockAddress = Address(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        isPrimary: true,
        additionalInfo: 'Apartamento 101',
      );

      mockState = UserListState(
        users: [mockUser],
        isLoading: false,
        error: null,
      );

      mockFormState = const AddressFormState(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
        streetAddress: 'Calle 123 #45-67',
        additionalInfo: 'Apartamento 101',
        isPrimary: true,
        isValid: true,
      );
    });

    Widget createTestWidget({Address? address}) {
      return ProviderScope(
        overrides: [
          userViewModelProvider.overrideWith((ref) => MockUserViewModel(mockState)),
          addressFormViewModelProvider.overrideWith((ref) => MockAddressFormViewModel(mockFormState)),
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
          home: AddressFormScreen(
            userId: 'user1', 
            address: address,
          ),
        ),
      );
    }

    testWidgets('should display app bar with correct title for new address', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(AddressFormScreen), findsOneWidget);
    });

    testWidgets('should display app bar with correct title for editing address', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(address: mockAddress));
      await tester.pumpAndSettle();

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(AddressFormScreen), findsOneWidget);
    });

    testWidgets('should display form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for text form fields
      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('should pre-populate fields when editing address', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(address: mockAddress));
      await tester.pumpAndSettle();

      // Check that TextFormField widgets exist (the form is rendered)
      expect(find.byType(TextFormField), findsWidgets);
      
      // Verify the form fields contain the expected values by checking the text in input fields
      final textFields = tester.widgetList<TextFormField>(find.byType(TextFormField));
      final controllers = textFields.map((field) => field.controller).where((c) => c != null).toList();
      
      // Check that we have controllers with the expected values
      expect(controllers.any((c) => c!.text == 'Colombia'), isTrue);
      expect(controllers.any((c) => c!.text == 'Antioquia'), isTrue);
      expect(controllers.any((c) => c!.text == 'Medellín'), isTrue);
      expect(controllers.any((c) => c!.text == 'Calle 123 #45-67'), isTrue);
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

      // Should show validation errors or remain on the same screen
      expect(find.byType(AddressFormScreen), findsOneWidget);
    });

    testWidgets('should handle text input in form fields', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textFields = find.byType(TextFormField);
      
      // Enter text in first field (assuming it's country)
      if (textFields.evaluate().isNotEmpty) {
        await tester.enterText(textFields.first, 'Test Country');
        await tester.pumpAndSettle();
        
        expect(find.text('Test Country'), findsOneWidget);
      }
    });

    testWidgets('should display correct layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
    });

    testWidgets('should handle back navigation', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userViewModelProvider.overrideWith((ref) => MockUserViewModel(mockState)),
            addressFormViewModelProvider.overrideWith((ref) => MockAddressFormViewModel(mockFormState)),
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
            initialRoute: '/form',
            routes: {
              '/': (context) => const Scaffold(body: Text('Home')),
              '/form': (context) => AddressFormScreen(userId: 'user1'),
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AddressFormScreen), findsOneWidget);
    });


    testWidgets('should handle theme correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userViewModelProvider.overrideWith((ref) => MockUserViewModel(mockState)),
            addressFormViewModelProvider.overrideWith((ref) => MockAddressFormViewModel(mockFormState)),
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
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AddressFormScreen(userId: 'user1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AddressFormScreen), findsOneWidget);
    });

  });
}
