part of 'profile_cubit.dart';

enum ProfileStatus { initial, themeToggled, languageToggled }

@immutable
class ProfileState {
  final ProfileStatus? status;

  final ThemeMode themeMode;
  final LanguageEnum language;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.themeMode = ThemeMode.light,
    this.language = ConstantsManager.fallbackLanguage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ThemeMode? themeMode,
    LanguageEnum? language,
  }) {
    return ProfileState(
      status: status,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  String toString() {
    final List<String> states = [if (status != null) 'status: $status'];

    return PrintStateHelper.printState('ProfileState', states);
  }

  bool get isInitial => status == ProfileStatus.initial;
  bool get isThemeToggled => status == ProfileStatus.themeToggled;
  bool get isLanguageToggled => status == ProfileStatus.languageToggled;
}
