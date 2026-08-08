class ExperiencesModel {
  final List<ExperienceModel> experiences;

  const ExperiencesModel() : experiences = const [_drCode, _wadjet];

  static const ExperienceModel _drCode = ExperienceModel(
    role: 'Flutter Developer',
    companyName: 'Dr. Code',
    companyUrl: 'https://doctor-code.net/en',
    location: 'Egypt',
    startDate: 'July 2024',
    endDate: 'Dec 2025',
    type: 'Full-time',
    responsibilities: [
      'Collaborated on and built various Flutter apps in domains like education, and e-commerce.',
      'Implemented complete UI features from scratch in some projects and contributed to others collaboratively.',
    ],
  );

  static const ExperienceModel _wadjet = ExperienceModel(
    role: 'Flutter Developer',
    companyName: 'Wadjet',
    companyUrl: 'https://www.linkedin.com/company/wadjetapp/',
    location: 'Remote',
    startDate: 'July 2024',
    endDate: 'Sep 2024',
    type: 'Part time',
  );
}

class ExperienceModel {
  final String role;
  final String companyName;
  final String companyUrl;
  final String location;
  final String startDate;
  final String endDate;
  final String type;
  final List<String> responsibilities;

  const ExperienceModel({
    required this.role,
    required this.companyName,
    required this.companyUrl,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.type,
    this.responsibilities = const [],
  });
}
