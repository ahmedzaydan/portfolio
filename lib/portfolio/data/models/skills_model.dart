class SkillsModel {
  final List<SkillModel> skills;

  const SkillsModel() : skills = const [_mobile, _programming, _tools];

  static const SkillModel _mobile = SkillModel(
    category: 'Mobile development',
    items: [
      'Flutter',
      'Cubit',
      'State management',
      'Firebase',
      'Sqflite',
      'Google Maps',
      'Local Notifications',
      'MVVM Architecture',
      'Clean Architecture',
      'Responsive and Adaptive UI',
      'Debugging',
      'Json serialization',
      'Android',
      'iOS',
      'Push Updates',
      'Payment Gateways',
      'Flavors',
      'CI/CD',
      'GitHub Actions',
      'Gitlab CI/CD',
    ],
  );

  static const SkillModel _programming = SkillModel(
    category: 'Programming & Software Principles',
    items: [
      'Dart',
      'Object Oriented Programming (OOP)',
      'SOLID Principles',
      'Design Patterns',
      'RESTful APIs',
      'Clean Code',
      'Algorithms',
      'Data Structures',
    ],
  );

  static const SkillModel _tools = SkillModel(
    category: 'Tools',
    items: [
      'Version control',
      'Git',
      'GitHub',
      'Gitlab',
      'Trello',
      'Postman',
      'Figma',
    ],
  );
}

class SkillModel {
  final String category;
  final List<String> items;

  const SkillModel({required this.category, required this.items});
}
