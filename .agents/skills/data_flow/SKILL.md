---
name: data_flow
description: This skill generates all the API request flow files for a given feature from data source to the cubit.
allowed-tools: Read Write Edit Glob Grep
---

# API Request Flow

- Ask user for method name that should be used in, method name in remote data source, repository
  Every API operation follows an identical 5-layer flow. The example below uses `getProfile` as the reference.

## Layer 1: Data Layer

### Data Sources
Read the file `guides/remote_data_source.md`

### Models
Read the file `guides/model.md`

### Params
Read the file `guides/params.md`

### Repository
Read the file `guides/repository.md`

## Layer 2: Presentation Layer
Read the file `guides/cubit.md`

When the endpoint requires user input (forms), add:

### Form Data
**File:** `features/<feature>/presentation/form_data/<action>_form_data.dart`

Holds `TextEditingController`s, a `GlobalKey<FormState>`, and any extra state (e.g., file paths).  
Must implement `FormDataInterface` (`core/form_data/form_data_interface.dart`).

```dart
class EditProfileFormData implements FormDataInterface {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  String? avatar;

  EditProfileFormData({required String initialName}) {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    nameController.dispose();
  }
}
```

### Mapper
**File:** `features/<feature>/presentation/mappers/<action>_form_data_mapper.dart`

A pure static class that converts `FormData` → `Params`.

```dart
class EditProfileFormDataMapper {
  static UpdateProfileParams toParams({
    required EditProfileFormData formData,
  }) {
    return UpdateProfileParams(
      name: formData.nameController.text.trim(),
      avatarPath: formData.avatar,
    );
  }
}
```
