enum SectionsEnum { about, education, experiences, projects, skills }

abstract final class SectionsEnumHelper {
  static String getTitle(SectionsEnum section) => switch (section) {
    SectionsEnum.about => 'About',
    SectionsEnum.education => 'Education',
    SectionsEnum.experiences => 'Experiences',
    SectionsEnum.projects => 'Projects',
    SectionsEnum.skills => 'Skills',
  };
}
