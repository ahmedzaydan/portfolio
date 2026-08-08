import 'models/education_model.dart';
import 'models/experiences_model.dart';
import 'models/personal_info_model.dart';
import 'models/projects_model.dart';
import 'models/skills_model.dart';

abstract final class PortfolioDataSource {
  static const PersonalInfoModel personalInfo = PersonalInfoModel();

  static const EducationModel education = EducationModel();

  static const ExperiencesModel experiences = ExperiencesModel();

  static const ProjectsModel projects = ProjectsModel();

  static const SkillsModel skills = SkillsModel();
}
