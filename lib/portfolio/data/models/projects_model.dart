import '../../../utils/assets_manager.dart';
import 'icon_model.dart';

class ProjectsModel {
  final List<ProjectModel> projects;

  const ProjectsModel()
    : projects = const [
        _taaMarboutaClinic,
        _taaMarbouta,
        _talabety,
        _auditStation,
        _wadjetPartners,
        _nabihDigital,
        _azulzinho,
        _gitJunior,
      ];

  static const ProjectModel _taaMarboutaClinic = ProjectModel(
    name: 'Taa Marbouta - Clinic',
    description:
        'Women healthcare and beuty clinic management mobile application',
    image: AssetsManager.taaMarboutaClinicPNG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.taamarbouta.clinic',
    ),
  );
  static const ProjectModel _taaMarbouta = ProjectModel(
    name: 'Taa Marbouta',
    description: 'Women healthcare and beauty mobile application',
    image: AssetsManager.taaMarboutaPNG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.taamarbouta.patient',
    ),
  );
  static const ProjectModel _talabety = ProjectModel(
    name: 'Talabety',
    description: 'B2B mobile application',
    image: AssetsManager.talabetyJPG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.talabety.promosigns',
    ),
    appStore: AppStoreIconModel(
      url: 'https://apps.apple.com/eg/app/طلبيتي/id6761391585',
    ),
  );

  static const ProjectModel _nabihDigital = ProjectModel(
    name: 'Nabih Digital',
    description: 'Smart platform for managing students pickups',
    image: AssetsManager.nabihDigitalJPEG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.nabih_digital.app',
    ),
  );

  static const ProjectModel _auditStation = ProjectModel(
    name: 'Audit Station',
    description: 'Accounting platform mobile application',
    image: AssetsManager.auditPNG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.stationsGroup.auditStation',
    ),
    appStore: AppStoreIconModel(
      url: 'https://apps.apple.com/eg/app/audit-station/id6746169066',
    ),
  );

  static const ProjectModel _wadjetPartners = ProjectModel(
    name: 'Wadjet Partners',
    description: 'F&B marketing mobile application',
    image: AssetsManager.wadjetPartnersPNG,
    playStore: PlayStoreIconModel(
      url:
          'https://play.google.com/store/apps/details?id=com.goodgame.wadjetpartners',
    ),
  );

  static const ProjectModel _azulzinho = ProjectModel(
    name: 'Azulzinho',
    description: 'Studio rent management mobile application',
    image: AssetsManager.azulzinhoPNG,
    isInternalOrNotPublished: true,
    details: ['Freelance project, internal use'],
  );

  static const ProjectModel _gitJunior = ProjectModel(
    name: 'GitJunior',
    description:
        'Git commands visualization desktop application (graduation project)',
    image: AssetsManager.gitJuniorPNG,
    details: [
      'Contributed to developing a desktop app designed to visualize Git commands, simplifying the learning process for newcomers.',
    ],
  );
}

class ProjectModel {
  final String name;
  final String description;
  final String image;
  final PlayStoreIconModel? playStore;
  final AppStoreIconModel? appStore;
  final bool isInternalOrNotPublished;
  final List<String> details;

  const ProjectModel({
    required this.name,
    required this.description,
    required this.image,
    this.playStore,
    this.appStore,
    this.isInternalOrNotPublished = false,
    this.details = const [],
  });
}
