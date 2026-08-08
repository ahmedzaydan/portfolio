enum ImageType {
  network,
  asset,
  svg,
  file;

  static ImageType fromString(String path) {
    final lowerCasePath = path.toLowerCase();

    if (lowerCasePath.contains('http')) {
      return ImageType.network;
    }

    if (lowerCasePath.contains('svg')) {
      return ImageType.svg;
    }

    if (lowerCasePath.startsWith("assets") &&
        (lowerCasePath.contains('png') ||
            lowerCasePath.contains('jpg') ||
            lowerCasePath.contains('jpeg'))) {
      return ImageType.asset;
    }

    return ImageType.file;
  }

  bool get isNetwork => this == ImageType.network;
  bool get isAsset => this == ImageType.asset;
  bool get isSvg => this == ImageType.svg;
  bool get isFile => this == ImageType.file;
}
