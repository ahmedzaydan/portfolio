# Params 
**File** `features/<feature>/data/params/<method_name>_params.dart`

## Rules

- Ask user for proprties defintion
- Ask user for Params class name which is at same time params file name
- Class should always extend `BaseParams` in `packages/core/core.dart`
- Use `APIKeysManager` for keys in methods
- In `body`/`query_params`/`files` methods, only include non-null and non-empty values in the resulting map

## Template

```dart
class UpdateProfileParams extends BaseParams {
  final String? name;
  final String? avatarPath;

  UpdateProfileParams({
    this.name,
    this.avatarPath,
  });

  @override
  Map<String, dynamic> get body => {
    if (name != null) APIKeysManager.name: name,
  };

  @override
  List<UploadFile> get files => [
    if (avatarPath != null)
      UploadFile(fieldName: APIKeysManager.avatar, filePath: avatarPath!),
  ];
}
```
