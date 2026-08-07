# Create New Feature

Every feature follows this layout. Use this as the template for any new feature.

## Setup Instructions

- Ask User for feature name, and place it under lib/features
- Add registerDependenciesMethod to `core/utils/dependencies_manager.dart` in nonNecessary depedencies
- Add routes path to `config/routes/route_manager.dart` in routes list
```dart
import '../../features/<feature>/<feature>_routes.dart' as <feature>_routes;
```

in routes list
```dart
...<feature>_routes.$appRoutes,
```

## Folder Structure

```text
features/<feature_name>/
├── <feature_name>_routes.dart # Typed go_router route definitions
├── <feature_name>_routes.g.dart # Generated — do not edit
├── register_<feature_name>_dependencies.dart # GetIt registrations for this feature
│
├── data/
│ ├── data_sources/ # Remote & local data sources (abstract + impl)
│ ├── models/ # JSON-serializable data models
│ ├── params/ # Request parameter objects
│ └── repositories/ # Repository implementations
│
└── presentation/
  ├── cubit/
  │ ├── <feature>_cubit.dart # Business logic (extends Cubit<State>)
  │ └── <feature>_state.dart # Immutable state (extends Equatable)
  ├── form_data/ # Form state holders (implement FormDataInterface)
  ├── mappers/ # Convert form_data → params
  ├── screens/ # Full-page widgets (one file per screen)
  └── widgets/ # Screen-specific, reusable sub-widgets
```

## Templates

### 1. Routes File

**File:** `features/<feature>/<feature>_routes.dart`

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core/utils/dependencies_manager.dart';

const TypedShellRoute<<Feature>ShellRoute> <feature>Routes =
    TypedShellRoute<<Feature>ShellRoute>(
      routes: [
        TypedGoRoute<<Feature>Route>(
          path: BottomNavPaths.<feature>,
          routes: [
             // Add sub-routes here
          ],
        ),
      ],
    );

class <Feature>ShellRoute extends ShellRouteData {
  const <Feature>ShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BlocProvider<<Feature>Cubit>(
      create: (_) => DependenciesManager.getIt<<Feature>Cubit>(),
      child: navigator,
    );
  }
}

class <Feature>Route extends CustomRoute with $<Feature>Route {
  const <Feature>Route();

  @override
  Widget buildWidget(BuildContext context, GoRouterState state) {
    return const <Feature>Screen();
  }
}
```

### 2. Register Dependencies File

**File:** `features/<feature>/register_<feature>_dependencies.dart`

```dart
import 'package:core/core.dart';

import '../../core/utils/dependencies_manager.dart';

void register<Feature>Dependencies() {
  final getIt = DependenciesManager.getIt;

  // <Feature> remote data source
  getIt.registerLazySingleton<<Feature>RemoteDataSource>(
    () => <Feature>RemoteDataSourceImplementer(getIt<ApiService>()),
  );

  // <Feature> repository
  getIt.registerLazySingleton<<Feature>Repository>(
    () => <Feature>RepositoryImplementer(
      remoteDataSource: getIt<<Feature>RemoteDataSource>(),
    ),
  );

  // <Feature> cubit
  getIt.registerFactory<<Feature>Cubit>(
    () => <Feature>Cubit(repository: getIt<<Feature>Repository>()),
  );
}
```

### 3. Remote Data Source

**File:** `features/<feature>/data/data_sources/<feature>_remote_data_source.dart`

```dart
import 'package:core/core.dart';

abstract interface class <Feature>RemoteDataSource {
}

class <Feature>RemoteDataSourceImplementer implements <Feature>RemoteDataSource {
  final ApiService apiService;

  <Feature>RemoteDataSourceImplementer(this.apiService);
}
```

### 4. Repository

**File:** `features/<feature>/data/repositories/<feature>_repository.dart`

```dart
import 'package:core/core.dart';

abstract interface class <Feature>Repository {
}

class <Feature>RepositoryImplementer implements <Feature>Repository {
  final <Feature>RemoteDataSource remoteDataSource;

  <Feature>RepositoryImplementer({required this.remoteDataSource});
}
```

### 5. Cubit

**File:** `features/<feature>/presentation/cubit/<feature>_cubit.dart`

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';

part '<feature>_state.dart';

class <Feature>Cubit extends Cubit<<Feature>State> with SafeEmitMixin {
  final <Feature>Repository repository;

  <Feature>Cubit({required this.repository}) : super(const <Feature>State());
}
```

### 6. State

**File:** `features/<feature>/presentation/cubit/<feature>_state.dart`

```dart
part of '<feature>_cubit.dart';

@immutable
class <Feature>State {
  final String? message;
  final Map<String, dynamic>? errors;

  const <Feature>State({
    this.message,
    this.errors,
  });

  <Feature>State copyWith({
    String? message,
    Map<String, dynamic>? errors,
  }) {
    return <Feature>State(
      message: message,
      errors: errors,
    );
  }

  @override
  String toString() {
    final List<String> states = [
    ];
    return PrintStateHelper.printState('<Feature>State', states);
  }
}
```
