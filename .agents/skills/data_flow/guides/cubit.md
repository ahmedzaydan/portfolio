# Cubit 
**File** `features/<feature>/presentation/cubit/<feature>_cubit.dart`

## Rules

- **Always** use `safeEmit` instead of `emit`
- cubit should use `safeEmitMixin` in `packages/core/lib/src/utils/safe_emit_mixin.dart`
- cubit should be always pure dart file without any flutter import

## Template (Without Pagination)

```dart
Future<void> getProfile(GetProfileParams params) async {
  safeEmit(state.copyWith(getProfileStatus: StateEnum.loading));

  final result = await profileRepository.getProfile(params);

  result.fold(
    (failure) => safeEmit(
      state.copyWith(
        getProfileStatus: StateEnum.failure,
        message: failure.message,
      ),
    ),
    (model) => safeEmit(
      state.copyWith(
        getProfileStatus: StateEnum.success,
        clinicModel: model,
      ),
    ),
  );
}
```

## Template (With Pagination)

```dart
Future<void> getAppointments(GetAppointmentsParams params) async {
  safeEmit(
    state.copyWith(
      getAppointmentsStatus: params.paginationParams.isFirstPage
          ? StateEnum.loading
          : StateEnum.loadingMore,
    ),
  );

  final result = await repository.getAppointments(params);

  result.fold(
    (failure) => safeEmit(
      state.copyWith(
        getAppointmentsStatus: StateEnum.failure,
        message: failure.message,
      ),
    ),
    _onGetAppointmentsSuccess,
  );
}

void _onGetAppointmentsSuccess(AppointmentsModel appointmentsModel) {
  final isFirstPage = appointmentsModel.meta.isFirstPage;

  if (isFirstPage) {
    safeEmit(
      state.copyWith(
        getAppointmentsStatus: StateEnum.success,
        appointmentsModel: appointmentsModel,
      ),
    );
    return;
  }

  safeEmit(
    state.copyWith(
      getAppointmentsStatus: StateEnum.success,
      appointmentsModel: state.appointmentsModel?.addNextPage(appointmentsModel),
    ),
  );
}
```

# State 
**File** `features/<feature>/presentation/cubit/<feature>_state.dart`

## Rules
- For every operation, add a dedicated **nullable `StateEnum?`** field named `<operation>Status`

### `copyWith` rules

- **`StateEnum?` fields** — assign **directly** from the argument, even if it's null
- **Data / model fields** — use `??` to preserve existing value when the argument is not passed

### `toString` rules

- Override `toString()` in every state class
- Only include `StateEnum?` fields in the output, wrapped in `if (field != null)`
- Use `PrintStateHelper.printState('FeatureState', states)` to format the output
- Every time you add a new `StateEnum?` field, **also add its line** to `toString()`

## State Template
```dart
@immutable
class ProfileState {
  final StateEnum? getProfileStatus;
  final String? message;
  final Map<String, dynamic>? errors;
  final UserModel? userModel;

  const ProfileState({
    this.getProfileStatus,
    this.message,
    this.errors,
    this.userModel,
  });

  ProfileState copyWith({
    StateEnum? getProfileStatus,
    String? message,
    Map<String, dynamic>? errors,
    UserModel? userModel,
  }) {
    return ProfileState(
      getProfileStatus: getProfileStatus,
      message: message,
      errors: errors,
      userModel: userModel ?? userModel,
    );
  }

  @override
  String toString() {
    final List<String> states = [
      if (getProfileStatus != null) 'getProfileStatus: $getProfileStatus',
    ];

    return PrintStateHelper.printState('ProfileState', states);
  }
}
```
