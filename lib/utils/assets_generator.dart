import 'dart:developer';
import 'dart:io';

void _customPrint(String message) {
  log(message);
}

void main(List<String> args) async {
  if (args.length < 2) {
    _customPrint(
      'Usage: dart run assets_generator.dart <assets_path> <output_path>',
    );
    _customPrint(
      'Example: dart run assets_generator.dart ../../apps/patient_app/assets ../../apps/patient_app/lib/core/utils/assets_manager.dart',
    );
    return;
  }

  final assetsPath = args[0];
  final outputPath = args[1];

  await AssetsGenerator(
    assetsPath: assetsPath,
    outputPath: outputPath,
  ).generate();
}

class FileInfo {
  final String fileName;
  final String extension;
  final String relativePath;
  final String folderName;

  FileInfo({
    required this.fileName,
    required this.extension,
    required this.relativePath,
    required this.folderName,
  });

  /// Returns the immediate parent folder name
  /// For 'svgs/icons' returns 'icons'
  /// For 'images' returns 'images'
  String get immediateParentFolder {
    if (folderName.isEmpty) return '';
    final parts = folderName.split('/');
    return parts.last;
  }
}

class AssetsGenerator {
  final String assetsPath;
  final String outputPath;

  const AssetsGenerator({required this.assetsPath, required this.outputPath});

  Future<void> generate() async {
    if (!await FileSystemService.isDirectoryExist(assetsPath)) {
      _customPrint('Assets directory not found: $assetsPath');
      return;
    }

    try {
      final List<FileInfo> allFiles = [];
      final Set<String> allFolders = {};

      await _processDirectory(assetsPath, assetsPath, allFiles, allFolders);

      // Remove excluded folders
      allFolders.removeWhere(
        (folder) =>
            folder == 'fonts' ||
            folder.startsWith('fonts/') ||
            folder == 'localization' ||
            folder.startsWith('localization/'),
      );

      await _generateAssetsManager(allFiles, allFolders);
    } catch (e) {
      _customPrint('Error reading assets directory: $e');
    }
  }

  Future<void> _generateAssetsManager(
    List<FileInfo> allFiles,
    Set<String> allFolders,
  ) async {
    final buffer = StringBuffer();

    _writeClassHeader(buffer);
    _writeFolderPathConstants(buffer, allFolders);
    buffer.writeln();
    _writeFileConstants(buffer, allFiles, allFolders);
    buffer.writeln('}');

    await _writeAndFormatFile(buffer.toString());
  }

  void _writeClassHeader(StringBuffer buffer) {
    buffer.writeln('abstract final class AssetsManager {');
    buffer.writeln('  static const String _basePath = \'assets\';');
  }

  void _writeFolderPathConstants(StringBuffer buffer, Set<String> allFolders) {
    final sortedFolders = _sortFoldersByDepth(allFolders);

    for (final folder in sortedFolders) {
      final folderVarName = _buildFolderVariableName(folder);
      final folderPathValue = _buildFolderPathValue(folder);
      buffer.writeln(
        '  static const String $folderVarName = $folderPathValue;',
      );
    }
  }

  List<String> _sortFoldersByDepth(Set<String> folders) {
    return folders.toList()..sort((a, b) {
      final aDepth = a.split('/').length;
      final bDepth = b.split('/').length;
      if (aDepth != bDepth) return aDepth.compareTo(bDepth);
      return a.compareTo(b);
    });
  }

  String _buildFolderVariableName(String folder) {
    return '_${folder.toCamelCase}Path';
  }

  String _buildFolderPathValue(String folder) {
    final folderParts = folder.split('/');

    if (folderParts.length > 1) {
      // Nested folder: use parent path variable
      final parentFolder = folderParts
          .sublist(0, folderParts.length - 1)
          .join('/');
      final parentVarName = _buildFolderVariableName(parentFolder);
      final lastPart = folderParts.last;
      return '\'\$$parentVarName/$lastPart\'';
    } else {
      // Top-level folder: use base path
      return '\'\$_basePath/$folder\'';
    }
  }

  void _writeFileConstants(
    StringBuffer buffer,
    List<FileInfo> allFiles,
    Set<String> allFolders,
  ) {
    final filesByFolder = _groupFilesByFolder(allFiles);
    final sortedFolders = _sortFoldersByDepth(allFolders);

    for (final folder in sortedFolders) {
      if (filesByFolder.containsKey(folder)) {
        _writeFolderSection(buffer, folder, filesByFolder[folder]!);
      }
    }
  }

  Map<String, List<FileInfo>> _groupFilesByFolder(List<FileInfo> allFiles) {
    final Map<String, List<FileInfo>> filesByFolder = {};
    for (final file in allFiles) {
      filesByFolder.putIfAbsent(file.folderName, () => []).add(file);
    }
    return filesByFolder;
  }

  void _writeFolderSection(
    StringBuffer buffer,
    String folder,
    List<FileInfo> files,
  ) {
    buffer.writeln('  /// ${folder.capitalizeFirstLetter}');

    for (final file in files) {
      final variableName = _buildFileVariableName(file);
      final folderVarName = _buildFolderVariableName(folder);
      final filePath = '${file.fileName}.${file.extension.toLowerCase()}';

      buffer.writeln(
        '  static const String $variableName = \'\$$folderVarName/$filePath\';',
      );
    }

    buffer.writeln();
  }

  /// Builds file variable name using: fileName + extension
  /// Only adds folder name if the parent folder is 'icons'
  /// Example: download.svg in svgs/icons → downloadIconSVG
  /// Example: loading_audio_waves.json in jsons → loadingAudioWavesJSON
  String _buildFileVariableName(FileInfo file) {
    final fileNameCamel = file.fileName.toCamelCase;

    // Only add folder name if it's "icons"
    final folderSuffix = file.immediateParentFolder.toLowerCase() == 'icons'
        ? file.immediateParentFolder.singularize.toUpperCase()
        : '';

    final extensionUpperCase = file.extension.toUpperCase();

    return '$fileNameCamel$folderSuffix$extensionUpperCase';
  }

  Future<void> _writeAndFormatFile(String content) async {
    await FileSystemService.writeToFile(path: outputPath, content: content);

    await Process.run('dart', ['format', outputPath]);
    _customPrint('Generated assets_manager.dart at: $outputPath');
  }

  Future<void> _processDirectory(
    String directoryPath,
    String assetsBasePath,
    List<FileInfo> allFiles,
    Set<String> allFolders,
  ) async {
    try {
      final directory = Directory(directoryPath);
      final entities = await directory.list().toList();

      for (final entity in entities) {
        if (entity is File) {
          _processFile(entity, assetsBasePath, allFiles, allFolders);
        } else if (entity is Directory) {
          await _processDirectory(
            entity.path,
            assetsBasePath,
            allFiles,
            allFolders,
          );
        }
      }
    } catch (e) {
      _customPrint('Error processing directory $directoryPath: $e');
    }
  }

  void _processFile(
    File file,
    String assetsBasePath,
    List<FileInfo> allFiles,
    Set<String> allFolders,
  ) {
    final relativePath = _getRelativePath(file.path, assetsBasePath);
    final fileName = file.path.split(Platform.pathSeparator).last;
    final fileNameWithoutExtension = _extractFileNameWithoutExtension(fileName);
    final extension = _extractExtension(fileName);
    final folderName = _extractFolderName(relativePath);

    allFiles.add(
      FileInfo(
        fileName: fileNameWithoutExtension,
        extension: extension,
        relativePath: relativePath,
        folderName: folderName,
      ),
    );

    _addFolderHierarchy(folderName, allFolders);
  }

  String _extractFileNameWithoutExtension(String fileName) {
    return fileName.contains('.')
        ? fileName.substring(0, fileName.lastIndexOf('.'))
        : fileName;
  }

  String _extractExtension(String fileName) {
    return fileName.contains('.')
        ? fileName.substring(fileName.lastIndexOf('.') + 1).toUpperCase()
        : '';
  }

  String _extractFolderName(String relativePath) {
    final pathParts = relativePath.split('/');
    return pathParts.length > 2
        ? pathParts.sublist(1, pathParts.length - 1).join('/')
        : '';
  }

  void _addFolderHierarchy(String folderName, Set<String> allFolders) {
    if (folderName.isEmpty) return;

    final folderParts = folderName.split('/');
    for (int i = 0; i < folderParts.length; i++) {
      final folderPath = folderParts.sublist(0, i + 1).join('/');
      allFolders.add(folderPath);
    }
  }

  String _getRelativePath(String fullPath, String basePath) {
    final normalizedFullPath = fullPath.replaceAll('\\', '/');
    final normalizedBasePath = basePath.replaceAll('\\', '/');

    if (normalizedFullPath.startsWith(normalizedBasePath)) {
      String relativePath = normalizedFullPath.substring(
        normalizedBasePath.length,
      );

      if (relativePath.startsWith('/')) {
        relativePath = relativePath.substring(1);
      }

      return 'assets/$relativePath';
    }

    return normalizedFullPath;
  }
}

// FileSystemService and extensions remain the same...
abstract class FileSystemService {
  static Future<String> readFile(String path) async {
    try {
      final sanitizedPath = _sanitizePath(path);
      final isExist = await isFileExist(sanitizedPath);

      if (!isExist) return '';

      final file = File(sanitizedPath);
      return await file.readAsString();
    } on FileSystemException catch (_) {
      _customPrint("Error while reading file: $path");
      return '';
    }
  }

  static Future<void> writeToFile({
    required String path,
    required String content,
    FileMode mode = FileMode.write,
  }) async {
    final file = await createFile(_sanitizePath(path));
    await file.writeAsString(content, mode: mode);
  }

  static String _sanitizePath(String path) {
    return path.split('/').map((part) => part.toSnakeCase).join('/');
  }

  static Future<File> createFile(String path) async {
    final file = File(_sanitizePath(path));

    try {
      if (!await isFileExist(file.path)) {
        await file.create(recursive: true);
      }
      return file;
    } on Exception catch (_) {
      _customPrint(
        'Error while creating file:\n ${file.path.sanitizePathForPrinting}',
      );
    }

    return file;
  }

  static Future<bool> isFileExist(String path) async {
    return await File(_sanitizePath(path)).exists();
  }

  static Future<Directory> createDirectory(String path) async {
    final dir = Directory(_sanitizePath(path));
    final isExist = await isDirectoryExist(path);

    if (!isExist) {
      await dir.create(recursive: true);
    }

    return dir;
  }

  static Future<bool> isDirectoryExist(String path) async {
    return await Directory(_sanitizePath(path)).exists();
  }

  static Future<void> deleteDirectory(String path) async {
    final dir = Directory(_sanitizePath(path));

    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}

extension _StringExtension on String {
  String get toSnakeCase {
    final normalizedInput = replaceAll(RegExp(r'[ /]'), '_');
    String result = normalizedInput
        .split(RegExp(r'(?=[A-Z])'))
        .join('_')
        .toLowerCase();
    result = result.replaceAll(RegExp(r'^_+|_+$'), '');
    return result;
  }

  /// Singularize a word by removing trailing 's'
  /// icons → icon, pngs → png, svgs → svg, images → image
  String get singularize {
    if (isEmpty) return this;
    if (endsWith('s')) {
      return substring(0, length - 1);
    }
    return this;
  }

  String get toCamelCase {
    if (isEmpty) return '';

    final normalizedInput = replaceAll(RegExp(r'[_\-./]'), ' ');
    final words = normalizedInput.split(RegExp(r'(?=[A-Z])| '));
    final capitalizedWords = words
        .asMap()
        .map(
          (index, word) => MapEntry(
            index,
            index == 0
                ? word.toLowerCase()
                : word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                : '',
          ),
        )
        .values
        .toList();

    return capitalizedWords.join();
  }

  String get capitalizeFirstLetter => this[0].toUpperCase() + substring(1);

  String get sanitizePathForPrinting {
    return replaceAll('../lib/', '');
  }
}
