class EducationModel {
  final String degree;
  final String institution;
  final String startDate;
  final String endDate;
  final List<String> details;

  const EducationModel()
    : degree = 'Bachelor of Computer Science',
      institution =
          'Cairo University - Faculty of Computers and Artificial Intelligence',
      startDate = 'Sep 2020',
      endDate = 'May 2024',
      details = const ['GPA: 3.24 (Very good)'];
}
