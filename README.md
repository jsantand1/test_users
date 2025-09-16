# Gestión de Usuarios - Flutter App

Una aplicación móvil Flutter que implementa un sistema completo de gestión de usuarios con direcciones, utilizando **Riverpod** para el manejo de estado y siguiendo el patrón de arquitectura **MVVM**.

## 🚀 Características

- ✅ **Gestión completa de usuarios**: Crear, editar, eliminar y visualizar usuarios
- ✅ **Gestión de direcciones**: Cada usuario puede tener múltiples direcciones
- ✅ **Formularios validados**: Validación en tiempo real de todos los campos
- ✅ **Patrón MVVM**: Separación clara entre Vista, ViewModel y Modelo
- ✅ **Riverpod**: Gestión de estado reactiva y eficiente
- ✅ **UI moderna**: Interfaz de usuario limpia y responsive
- ✅ **Manejo de errores**: Control robusto de errores y estados de carga

## 📱 Pantallas Principales

### 1. Lista de Usuarios
- Visualización de todos los usuarios registrados
- Búsqueda y filtrado
- Acciones rápidas (editar, eliminar)
- Estado vacío cuando no hay usuarios

### 2. Formulario de Usuario
- Campos: Nombre, Apellido, Fecha de Nacimiento
- Validación en tiempo real
- Selector de fecha interactivo
- Modo creación y edición

### 3. Detalle de Usuario
- Información completa del usuario
- Lista de direcciones asociadas
- Gestión de direcciones (agregar, editar, eliminar)
- Indicador de dirección principal

### 4. Formulario de Dirección
- Campos: País, Departamento, Municipio, Dirección, Info adicional
- Opción de marcar como dirección principal
- Validación completa de campos

## 🏗️ Arquitectura

### Patrón MVVM
```
├── Models/          # Modelos de datos (User, Address)
├── ViewModels/      # Lógica de negocio y estado
├── Views/           # Pantallas y widgets de UI
└── Providers/       # Configuración de Riverpod
```

### Estructura del Proyecto
```
lib/
├── models/
│   ├── user.dart           # Modelo de Usuario
│   └── address.dart        # Modelo de Dirección
├── viewmodels/
│   ├── user_viewmodel.dart # ViewModel para gestión de usuarios
│   └── form_viewmodel.dart # ViewModels para formularios
├── ui/
│   └── screens/
│       ├── user_list_screen.dart      # Lista de usuarios
│       ├── user_form_screen.dart      # Formulario de usuario
│       ├── user_detail_screen.dart    # Detalle de usuario
│       └── address_form_screen.dart   # Formulario de dirección
└── main.dart               # Punto de entrada de la app
```

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Riverpod**: Gestión de estado reactiva
- **Material Design 3**: Sistema de diseño moderno
- **Dart**: Lenguaje de programación

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9  # Gestión de estado
  cupertino_icons: ^1.0.8   # Iconos iOS
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

### Validaciones
- Validación en tiempo real de formularios
- Campos requeridos claramente marcados
- Mensajes de error descriptivos

### Manejo de Errores
- Estados de carga visual
- Mensajes de error contextuales
- Recuperación automática de errores

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
- **Responsive**: Adaptable a diferentes tamaños de pantalla
- **Navegación intuitiva**: Flujo lógico entre pantallas
- **Feedback visual**: Indicadores de carga y estados
- **Accesibilidad**: Etiquetas y navegación por teclado

## 🧪 Testing

Para ejecutar las pruebas:
```bash
flutter test
```

## 📝 Próximas Mejoras

- [ ] Persistencia local con SQLite
- [ ] Búsqueda y filtrado avanzado
- [ ] Exportación de datos
- [ ] Sincronización con backend
- [ ] Modo oscuro
- [ ] Internacionalización

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 👨‍💻 Autor

Desarrollado con ❤️ usando Flutter y Riverpod
