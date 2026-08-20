class SkillsModel {
  final List<SkillModel> skills;

  const SkillsModel()
    : skills = const [
        _appDev,
        _architecture,
        _coreFeatures,
        _devOps,
        _computerScience,
      ];

  static const SkillModel _appDev = SkillModel(
    category: 'App Development & Languages',
    items: ['Flutter', 'Dart', 'Android', 'iOS'],
  );

  static const SkillModel _architecture = SkillModel(
    category: 'Architecture & State Management',
    items: [
      'Clean Architecture',
      'MVVM',
      'Cubit (State Management)',
      'SOLID Principles',
      'Design Patterns',
      'OOP',
      'Clean Code',
    ],
  );

  static const SkillModel _coreFeatures = SkillModel(
    category: 'Core Features & Integrations',
    items: [
      'Responsive & Adaptive UI',
      'Firebase',
      'RESTful APIs',
      'Sqflite',
      'Google Maps',
      'Local Notifications',
      'Payment Gateways',
      'Push Updates',
      'JSON Serialization',
      'App Flavors',
    ],
  );

  static const SkillModel _devOps = SkillModel(
    category: 'DevOps, CI/CD & Tools',
    items: [
      'Git & Version Control',
      'GitHub',
      'GitLab',
      'GitHub Actions',
      'GitLab CI/CD',
      'Postman',
      'Figma',
      'Trello',
      'Debugging',
    ],
  );

  static const SkillModel _computerScience = SkillModel(
    category: 'Computer Science',
    items: ['Algorithms', 'Data Structures'],
  );
}

class SkillModel {
  final String category;
  final List<String> items;

  const SkillModel({required this.category, required this.items});
}
