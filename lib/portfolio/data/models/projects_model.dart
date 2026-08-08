import 'icon_model.dart';

class ProjectsModel {
  final List<ProjectModel> projects;

  const ProjectsModel()
    : projects = const [
        _talabety,
        _auditStation,
        _lampe,
        _wadjetPartners,
        _azulzinho,
        _gitJunior,
      ];

  static const ProjectModel _talabety = ProjectModel(
    name: 'Talabety',
    description: 'B2B mobile application',
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.talabety.promosigns&pcampaignid=web_share',
    ),
    appStore: AppStoreIconModel(
      url: 'https://apps.apple.com/eg/app/طلبيتي/id6761391585',
    ),
  );

  static const ProjectModel _auditStation = ProjectModel(
    name: 'Audit Station',
    description: 'Accounting platform mobile application',
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.stationsGroup.auditStation',
    ),
    appStore: AppStoreIconModel(
      url: 'https://apps.apple.com/eg/app/audit-station/id6746169066',
    ),
  );

  static const ProjectModel _lampe = ProjectModel(
    name: 'Lampe',
    description: 'Electric products e-commerce mobile application',
    isInternalOrNotPublished: true,
  );

  static const ProjectModel _wadjetPartners = ProjectModel(
    name: 'Wadjet Partners',
    description: 'F&B marketing mobile application',
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.goodgame.wadjetpartners',
    ),
  );

  static const ProjectModel _azulzinho = ProjectModel(
    name: 'Azulzinho',
    description: 'Studio rent management mobile application',
    isInternalOrNotPublished: true,
    details: ['Freelance project, internal use'],
  );

  static const ProjectModel _gitJunior = ProjectModel(
    name: 'GitJunior',
    description:
        'Git commands visualization desktop application (graduation project)',
    details: [
      'Contributed to developing a desktop app designed to visualize Git commands, simplifying the learning process for newcomers.',
    ],
  );
}

class ProjectModel {
  final String name;
  final String description;
  final PlayStoreIconModel? playStore;
  final AppStoreIconModel? appStore;
  final bool isInternalOrNotPublished;
  final List<String> details;

  const ProjectModel({
    required this.name,
    required this.description,
    this.playStore,
    this.appStore,
    this.isInternalOrNotPublished = false,
    this.details = const [],
  });
}
