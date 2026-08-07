# Remote Data Source 
**File** `features/<feature>/data/data_sources/<feature>_remote_data_source.dart`

## Rules
- Ask user to enter return type and params class of method
- Define the method in the **abstract interface class**
- Implement it in the **implementer class** by calling `apiService`
- Use `apiService.get / post / put / delete / patch`

## Template
```dart
// Abstract contract
abstract interface class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile(GetProfileParams params);
}

// Implementation
class ProfileRemoteDataSourceImplementer implements ProfileRemoteDataSource {
  final ApiService apiService;
  ProfileRemoteDataSourceImplementer(this.apiService);

  @override
  Future<ProfileModel> getProfile(GetProfileParams params) async {
    if (_enableApi) {
      final response = await apiService.put(
        path: EndPoints.profile,
        params: params,
      );
      return ProfileModel.fromJson(response.data['data']);
    }

    await Future.delayed(const Duration(seconds: 2));
    return ProfileModel.dummy();
  }
}
```