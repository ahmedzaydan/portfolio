# Repository 
**File** `features/<feature>/data/repositories/<feature>_repository.dart`

## Rules
- Method name and return type of the model and params argument are same in `data_sources/<feature>_remote_data_source.dart`
- Declare the method in the **abstract interface class** with return type `FutureResult<T>`
- **Always** wrap the data-source call in `safeExecute` in the **implementer**

## Template
```dart
// Abstract contract
abstract interface class ProfileRepository {
  FutureResult<ProfileModel> getProfile();
}

// Implementation
class ProfileRepositoryImplementer implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImplementer(this.remoteDataSource);

  @override
  FutureResult<ProfileModel> getProfile() {
    return safeExecute(request: () => remoteDataSource.getProfile());
  }
}
```