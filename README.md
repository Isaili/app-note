📱 Aplicación de Notas - Flutter
📋 Descripción del Proyecto
Aplicación móvil desarrollada en Flutter para la gestión de notas, implementando arquitecturas modernas como Clean Architecture, MVVM, y principios de Screaming Architecture.

🎯 Objetivos
Demostrar dominio técnico en desarrollo Flutter

Implementar arquitecturas escalables y mantenibles

Consumir APIs REST con cliente HTTP

Gestionar estado con Provider

Crear interfaces responsive con animaciones

🛠️ Tecnologías Utilizadas
Flutter 3.0+

Dart

Provider (Gestión de estado)

HTTP (Cliente HTTP)

Equatable (Comparación de objetos)

Connectivity Plus (Verificación de conexión)

🏗️ Arquitectura
Clean Architecture
text
lib/
├── core/                    # Capa Core
│   ├── error/              # Manejo de errores
│   ├── network/            # Utilidades de red
│   └── utils/              # Utilidades generales
├── features/notes/          # Feature de notas (Vertical Slice)
│   ├── data/               # Capa de Datos
│   │   ├── datasources/    # Fuentes de datos
│   │   ├── models/         # Modelos de datos
│   │   └── repositories/   # Implementación repositorios
│   ├── domain/             # Capa de Dominio
│   │   ├── entities/       # Entidades de negocio
│   │   ├── repositories/   # Contratos abstractos
│   │   └── usecases/       # Casos de uso
│   └── presentation/       # Capa de Presentación
│       ├── pages/          # Pantallas
│       ├── providers/      # ViewModels
│       └── widgets/        # Componentes UI
└── main.dart               # Punto de entrada
Principios Implementados
Screaming Architecture: La estructura "grita" su propósito

Vertical Slicing: Cada feature es independiente

MVVM: Separación clara entre View y ViewModel

Inversión de Dependencias: Depende de abstracciones, no implementaciones

📡 API Consumida
Endpoints
Método	Endpoint	Descripción
GET	http://localhost:3000/api/notas	Obtener todas las notas
POST	http://localhost:3000/api/notas	Crear nueva nota
DELETE	http://localhost:3000/api/notas/:id	Eliminar nota por ID
Estructura de Datos
json
{
  "titulo": "Aprender Flutter",
  "parrafo": "Estudiar arquitecturas limpias",
  "estatus": "en-progreso"
}
🚀 Instalación y Ejecución
Prerrequisitos
Flutter SDK 3.0+

Dart SDK

Dispositivo/Emulador o navegador web

Pasos para Ejecutar
bash
# 1. Cl
pero dame el codigo para el archivo readme
📱 Aplicación de Notas - Flutter
📋 Descripción del Proyecto
Aplicación móvil desarrollada en Flutter para la gestión de notas, implementando arquitecturas modernas como Clean Architecture, MVVM, y principios de Screaming Architecture.

🎯 Características
✅ Crear, visualizar y eliminar notas

✅ Arquitectura Clean + MVVM + Provider

✅ Consumo de API REST con HTTP

✅ Interfaz responsive con animaciones

✅ Gestión de estado con Provider

✅ Manejo de errores y loading states

🛠️ Tecnologías Utilizadas
yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  provider: ^6.1.1
  equatable: ^2.0.5
  connectivity_plus: ^5.0.1
  dartz: ^0.10.1
🏗️ Arquitectura del Proyecto
Estructura de Carpetas
text
lib/
├── core/
│   ├── error/
│   │   ├── failure.dart
│   │   └── exception.dart
│   ├── network/
│   │   └── network_info.dart
│   └── utils/
│       └── typedef.dart
├── features/
│   └── notes/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── note_remote_data_source.dart
│       │   ├── models/
│       │   │   └── note_model.dart
│       │   └── repositories/
│       │       └── note_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── note.dart
│       │   ├── repositories/
│       │   │   └── note_repository.dart
│       │   └── usecases/
│       │       ├── get_notes.dart
│       │       ├── create_note.dart
│       │       └── delete_note.dart
│       └── presentation/
│           ├── pages/
│           │   └── notes_list_page.dart
│           ├── providers/
│           │   └── notes_provider.dart
│           └── widgets/
│               ├── note_card.dart
│               └── add_note_dialog.dart
└── main.dart
Principios Arquitectónicos
Clean Architecture: Separación en capas (Data, Domain, Presentation)

MVVM: Model-View-ViewModel con Provider

Screaming Architecture: Estructura que "grita" su propósito

Vertical Slicing: Features independientes y modulares

📡 API REST Consumida
Endpoints
Método	Endpoint	Descripción
GET	http://localhost:3000/api/notas	Obtener todas las notas
POST	http://localhost:3000/api/notas	Crear nueva nota
DELETE	http://localhost:3000/api/notas/:id	Eliminar nota por ID
Estructura de Datos
json
{
  "titulo": "Aprender Flutter",
  "parrafo": "Estudiar arquitecturas limpias", 
  "estatus": "en-progreso"
}
🚀 Instalación y Ejecución
Prerrequisitos
Flutter SDK 3.0+

Dart SDK

Dispositivo/Emulador o navegador web

Pasos para Ejecutar
bash
# 1. Clonar el proyecto
git clone <url-del-repositorio>
cd flutter_application_app

# 2. Instalar dependencias
flutter pub get

# 3. Ejecutar la aplicación
flutter run

# Para web (Edge/Chrome)
flutter run -d chrome
# o
flutter run -d edge
Configuración para Desarrollo Web
bash
# Para Edge con renderer HTML
flutter run -d edge --web-renderer html --web-port 5000

# Para Chrome
flutter run -d chrome --web-renderer html --web-port 3000
🎨 Interfaz de Usuario
Widgets Implementados
CustomScrollView con SliverAppBar y SliverList

GridView para vista alternativa de notas

Stack para layouts superpuestos

Card y ListTile para diseño Material

AnimatedContainer para efectos hover

FadeTransition para transiciones suaves

Hero para animaciones entre pantallas

Características de UI
Diseño responsive y adaptable

Animaciones fluidas y naturales

Estados de loading y error

Confirmación para eliminación

Diálogo modal para crear notas

📱 Funcionalidades
Gestión de Notas
Ver todas las notas: Lista paginada con scroll infinito

Crear nueva nota: Formulario con validación

Eliminar nota: Con confirmación y feedback visual

Ver detalles: Modal con información completa

Estados de la Aplicación
Loading: Indicador durante operaciones async

Error: Manejo elegante de fallos de red/API

Empty State: Mensaje cuando no hay notas

Success: Feedback visual para acciones exitosas

🔧 Configuración de Desarrollo
Variables de Entorno
Crear archivo .env en la raíz:

dart
BASE_URL=http://localhost:3000
API_TIMEOUT=30000
