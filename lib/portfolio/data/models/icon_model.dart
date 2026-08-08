import '../../../utils/assets_manager.dart';

class IconModel {
  final String path;
  final String url;

  const IconModel({required this.path, required this.url});
}

class PlayStoreIconModel extends IconModel {
  const PlayStoreIconModel({required super.url})
    : super(path: AssetsManager.googlePlaySVG);
}

class AppStoreIconModel extends IconModel {
  const AppStoreIconModel({required super.url})
    : super(path: AssetsManager.appStoreSVG);
}
