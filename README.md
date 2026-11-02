# BalanceTracker

Aplicación multiplataforma de finanzas personales y gastos compartidos, desarrollada con **Flutter**, **Riverpod** y **Firebase** como Proyecto Final del Grado Superior en Desarrollo de Aplicaciones Multiplataforma (DAM).

🔗 **Demo en vivo:** [balancetracker-g.web.app](https://balancetracker-g.web.app)

<!-- Sustituye las rutas por tus capturas reales (por ejemplo, en docs/screenshots/) -->
<p align="center">
  <img src="docs/screenshots/dashboard.png" width="220" alt="Dashboard" />
  <img src="docs/screenshots/transactions.png" width="220" alt="Transacciones" />
  <img src="docs/screenshots/groups.png" width="220" alt="Grupos" />
  <img src="docs/screenshots/analytics.png" width="220" alt="Análisis" />
</p>

## Funcionalidades

- **Autenticación** con email y contraseña (Firebase Auth), con opción de recordar la sesión.
- **Dashboard** con saldo, ingresos y gastos actualizados en tiempo real.
- **Transacciones**: alta, edición y borrado de ingresos y gastos por categorías.
- **Presupuestos** por categoría con seguimiento de lo gastado.
- **Deudas y préstamos**: control de lo que debes y de lo que te deben.
- **Suscripciones** recurrentes.
- **Grupos de gastos compartidos**: miembros, roles de administrador, reparto de gastos, saldos por persona y liquidación de deudas ("Tú debes" / "Otros").
- **Análisis** con gráficos de gastos por categoría (fl_chart).
- **Tres idiomas**: español, inglés y euskera.
- **Tema claro y oscuro**, y moneda configurable.

## Stack

| Capa | Tecnología |
| --- | --- |
| Frontend | Flutter (Dart 3), Material 3, Google Fonts |
| Estado | Riverpod 2 (con generación de código) |
| Navegación | go_router |
| Backend | Firebase Authentication, Cloud Firestore |
| Modelos | freezed, json_serializable |
| Gráficos | fl_chart |
| i18n | flutter_localizations + ARB (es, en, eu) |
| Despliegue | Firebase Hosting (web), Android |

## Arquitectura

El código está organizado **por funcionalidades** (*feature-first*). Cada módulo separa los datos, el dominio y la presentación:

```
lib/
├── core/              # Router, tema, providers globales (idioma, moneda, tema) y utilidades
├── features/
│   ├── auth/          # Login, registro y repositorio de autenticación
│   ├── dashboard/
│   ├── transactions/
│   ├── budgets/
│   ├── debts/
│   ├── subscriptions/
│   ├── groups/        # Gastos compartidos, saldos y liquidaciones
│   ├── categories/
│   └── analytics/
└── l10n/              # Traducciones ARB
```

```
features/<módulo>/
├── data/repositories/      # Acceso a Firestore
├── domain/models/          # Modelos inmutables (freezed)
└── presentation/screens/   # Pantallas y widgets
```

Los repositorios exponen *streams* de Firestore y Riverpod los convierte en estado reactivo, de modo que la interfaz se actualiza sola cuando cambian los datos.

## Cómo ejecutarlo

Requisitos: Flutter 3.x, una cuenta de Firebase y la [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup).

```bash
git clone https://github.com/guillearana/Balance_Tracker.git
cd Balance_Tracker
flutter pub get

# Conecta la app a tu propio proyecto de Firebase
# (genera lib/firebase_options.dart y android/app/google-services.json, que no se suben al repositorio)
flutterfire configure

# Genera el código de Riverpod, freezed y json_serializable
dart run build_runner build --delete-conflicting-outputs

flutter run
```

En tu proyecto de Firebase tienes que activar **Authentication** (email y contraseña) y **Cloud Firestore**.

## Próximas mejoras

- Notificaciones push con Firebase Cloud Messaging.
- Tests unitarios de la lógica de saldos y liquidaciones.
- Publicación en iOS.

## Autores

- **Guillermo Arana** — [@guillearana](https://github.com/guillearana)
- **Nick Jeremy Delgado** — [@JeremyFloydz](https://github.com/JeremyFloydz)

Proyecto Final de DAM · CIFP Ciudad Jardín, Vitoria-Gasteiz · 2026
