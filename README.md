# Gestión de Usuarios - Flutter App

Una aplicación móvil Flutter que implementa un sistema completo de gestión de usuarios con direcciones, utilizando **Riverpod** para el manejo de estado, **Atomic Design** para la arquitectura de componentes, e **internacionalización completa** en español e inglés.

## 🚀 Características

- ✅ **Gestión completa de usuarios**: Crear, editar, eliminar y visualizar usuarios
- ✅ **Gestión de direcciones**: Cada usuario puede tener múltiples direcciones
- ✅ **Formularios validados**: Validación en tiempo real de todos los campos
- ✅ **Patrón MVVM**: Separación clara entre Vista, ViewModel y Modelo
- ✅ **Riverpod**: Gestión de estado reactiva y eficiente
- ✅ **Atomic Design**: Arquitectura de componentes reutilizables
- ✅ **Internacionalización**: Soporte completo para español e inglés
- ✅ **UI moderna**: Interfaz de usuario limpia y responsive
- ✅ **Manejo de errores**: Control robusto de errores y estados de carga
- ✅ **Testing completo**: Pruebas unitarias para todos los componentes
- ✅ **Organización modular**: Estructura de carpetas por características

## 📱 Pantallas Principales

### 1. Splash Screen
- Pantalla de bienvenida con animaciones
- Logo animado con efectos de escala
- Transición automática a la lista de usuarios
- Textos localizados

### 2. Lista de Usuarios
- Visualización de todos los usuarios registrados
- Componente `UserListItem` reutilizable
- Acciones rápidas (editar, eliminar)
- Estado vacío con componente `EmptyState`
- Indicadores de carga y manejo de errores

### 3. Formulario de Usuario
- Campos: Nombre, Apellido, Fecha de Nacimiento
- Componentes `CustomInput` y `CustomButton`
- Validación en tiempo real con mensajes localizados
- Selector de fecha interactivo
- Modo creación y edición

### 4. Detalle de Usuario
- Información completa con `UserInfoCard`
- Lista de direcciones con `AddressCard`
- Gestión de direcciones (agregar, editar, eliminar)
- Estado vacío para direcciones

### 5. Formulario de Dirección
- Campos: País, Departamento, Municipio, Dirección
- Validación completa con mensajes localizados

## 🏗️ Arquitectura

### Patrón MVVM + Atomic Design
```
├── Models/          # Modelos de datos (User, Address)
├── ViewModels/      # Lógica de negocio y estado
├── Views/           # Pantallas y widgets de UI
├── Components/      # Sistema de componentes atómicos
```

### Atomic Design System
```
shared/components/
├── atoms/           # Componentes básicos
│   ├── custom_button.dart
│   ├── custom_card.dart
│   └── custom_input.dart
├── molecules/       # Combinación de átomos
│   ├── info_row.dart
│   └── empty_state.dart
├── organisms/       # Componentes complejos
│   ├── user_info_card.dart
│   ├── address_card.dart
│   └── user_list_item.dart
└── templates/       # Layouts base
    └── app_scaffold.dart
```

### Estructura del Proyecto
```
lib/
├── models/
│   ├── user.dart           # Modelo de Usuario (sin JSON serialization)
│   └── address.dart        # Modelo de Dirección (sin JSON serialization)
├── viewmodels/
│   ├── user_viewmodel.dart # ViewModel para gestión de usuarios
│   ├── user_form_viewmodel.dart
│   └── address_form_viewmodel.dart
├── states/
│   ├── user_list_state.dart      # Estado para lista de usuarios
│   ├── user_form_state.dart      # Estado para formulario de usuario
│   └── address_form_state.dart   # Estado para formulario de dirección
├── shared/
│   ├── components/         # Sistema de componentes atómicos
│   └── models/            # Modelos específicos de componentes
├── ui/
│   ├── helpers/
│   │   └── routes.dart    # Configuración de rutas
│   └── screens/
│       ├── splash/
│       │   └── splash_screen.dart
│       ├── user/
│       │   ├── user_list_screen.dart
│       │   ├── user_form_screen.dart
│       │   └── user_detail_screen.dart
│       └── address/
│           └── address_form_screen.dart
├── l10n/                  # Archivos de localización
│   ├── app_en.arb        # Textos en inglés
│   ├── app_es.arb        # Textos en español
│   └── app_localizations.dart # Clases generadas automáticamente
└── main.dart             # Punto de entrada con internacionalización
```

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Riverpod**: Gestión de estado reactiva
- **Material Design 3**: Sistema de diseño moderno
- **Atomic Design**: Metodología de componentes
- **Flutter Localizations**: Internacionalización
- **Dart**: Lenguaje de programación

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9     # Gestión de estado
  flutter_localizations:       # Internacionalización
    sdk: flutter
  intl: any                    # Formateo de fechas y números
  cupertino_icons: ^1.0.8      # Iconos iOS

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0       # Análisis de código

flutter:
  generate: true              # Generación automática de localizaciones
```

## 🚀 Instalación y Ejecución

### Prerrequisitos
- Flutter SDK (versión 3.8.1 o superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android o dispositivo físico

### Pasos de instalación

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd test_users
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```
   
   > **Nota**: Los archivos de localización se generan automáticamente con `flutter pub get`

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 💡 Uso de la Aplicación

### Crear un Usuario
1. En la pantalla principal, toca el botón **+**
2. Completa el formulario con nombre, apellido y fecha de nacimiento
3. Toca **"Crear Usuario"**

### Gestionar Direcciones
1. Selecciona un usuario de la lista
2. En la pantalla de detalle, toca **"Agregar"** en la sección de direcciones
3. Completa los campos de dirección
4. Marca como principal si es necesario
5. Toca **"Crear Dirección"**

### Editar Información
- **Usuario**: Toca el menú de 3 puntos → "Editar"
- **Dirección**: En el detalle del usuario, toca el menú de la dirección → "Editar"

## 🎯 Características Técnicas

### Gestión de Estado con Riverpod
- **StateNotifier**: Para manejar estados complejos
- **Provider**: Para datos inmutables
- **Family Provider**: Para parámetros dinámicos
- **ConsumerWidget**: Para widgets reactivos

### Sistema de Componentes (Atomic Design)
- **Átomos**: `CustomButton`, `CustomCard`, `CustomInput`
- **Moléculas**: `InfoRow`, `EmptyState`
- **Organismos**: `UserInfoCard`, `AddressCard`, `UserListItem`
- **Templates**: `AppScaffold`
- **Reutilización**: Componentes consistentes en toda la app

### Internacionalización
- **Soporte multiidioma**: Español e inglés
- **Archivos ARB**: Configuración estándar de Flutter
- **Generación automática**: Clases de localización generadas
- **Textos dinámicos**: Soporte para parámetros en mensajes

### Validaciones
- Validación en tiempo real de formularios
- Campos requeridos claramente marcados
- Mensajes de error localizados
- Validación de fechas y campos obligatorios

### Manejo de Errores
- Estados de carga visual con `LinearProgressIndicator`
- Mensajes de error contextuales y localizados
- Recuperación automática de errores
- Estados vacíos con componente `EmptyState`

## 🔄 Estados de la Aplicación

### UserListState
- `users`: Lista de usuarios
- `isLoading`: Estado de carga
- `error`: Mensaje de error si existe

### UserFormState / AddressFormState
- Campos del formulario
- Estado de validación
- Estado de carga
- Manejo de errores

## 🎨 Diseño UI/UX

- **Material Design 3**: Componentes modernos y accesibles
- **Atomic Design**: Sistema de componentes consistente
- **Responsive**: Adaptable a diferentes tamaños de pantalla
- **Navegación intuitiva**: Flujo lógico entre pantallas
- **Feedback visual**: Indicadores de carga, animaciones y estados
- **Estados vacíos**: Componentes dedicados para listas vacías
- **Internacionalización**: Interfaz completamente localizada
- **Accesibilidad**: Etiquetas y navegación por teclado

## 🧪 Testing

La aplicación incluye pruebas unitarias completas para todos los componentes:

### Estructura de Pruebas
```
test/
├── models/
│   ├── user_test.dart           # Pruebas del modelo User
│   └── address_test.dart        # Pruebas del modelo Address
├── states/
│   ├── user_list_state_test.dart
│   ├── user_form_state_test.dart
│   └── address_form_state_test.dart
├── viewmodels/
│   ├── user_viewmodel_test.dart
│   ├── user_form_viewmodel_test.dart
│   └── address_form_viewmodel_test.dart
└── ui/screens/
    ├── splash/
    │   └── splash_screen_test.dart
    └── user/
        └── user_list_screen_test.dart
```

### Tipos de Pruebas Incluidas
- **Modelos**: Pruebas de propiedades calculadas, copyWith, validaciones
- **Estados**: Pruebas de inmutabilidad y integridad de datos
- **ViewModels**: Pruebas con mocks y providers de Riverpod
- **UI**: Pruebas de widgets con localización y navegación

### Ejecutar Pruebas
```bash
# Ejecutar todas las pruebas
flutter test

# Ejecutar pruebas específicas
flutter test test/models/
flutter test test/ui/screens/

# Ejecutar con cobertura
flutter test --coverage
```


