# Model 
**File** `features/<feature>/data/models/<model_name>_model.dart`

## Rules
- Ask user to enter model name which at same time is the model file name
- Ask user to enter properties definition
- Model should have final properties
- Model should have default constructure with named attributes
- Model should have factory constructur .fromJson(Map<String, dynamic> json)
- Model should have factory constructor .dummy()
- Model should have copyWith method with empty arguments
- If model has `PaginationMetaModel`, add method named addNextPage accept object from same model and update its items by appending new page items at the end of the list and update meta object
- `PaginationMetaModel` should be always named `meta`
- If model contains submodel, also ask user to enter proprties definition of submodel, create submodel in same file unless file become too large then (ask user before creating it in separate file)

## Template 
```dart
class AppointmentsModel {
  final List<AppointmentModel> appointments;
  final PaginationMetaModel meta;

  const AppointmentsModel({required this.appointments, required this.meta});

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      appointments: (json['data'] as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList(),
      meta:  PaginationMetaModel.fromJson(json['meta'])
    );
  }


  factory AppointmentsModel.dummy() {
    return AppointmentsModel(
      appointments: List.generate(10, (_) => AppointmentModel.dummy()),
      meta: PaginationMetaModel.dummy()
    );
  }

  AppointmentsModel copyWith({
    List<AppointmentModel>? appointments,
    PaginationMetaModel? meta,
  }) {
    return AppointmentsModel(
      appointments: appointments ?? this.appointments,
      meta: meta ?? this.meta,
    );
  }

  AppointmentsModel addNextPage(AppointmentsModel nextPage) {
    return copyWith(
      appointments: [...appointments, ...nextPage.appointments],
      meta: nextPage.meta,
    );
  }
}

class AppointmentModel {
  final int id;

  const AppointmentModel({
    required this.id,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
    );
  }

  factory AppointmentModel.dummy() {
    return AppointmentModel(id: 5);
  }

  AppointmentModel copyWith() {
    return AppointmentModel(id: id);
  }
}

```