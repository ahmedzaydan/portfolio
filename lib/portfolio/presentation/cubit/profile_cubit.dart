import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/language_enum.dart';
import '../../../core/extensions/theme_mode_extension.dart';
import '../../../core/utils/constants_manager.dart';
import '../../../core/utils/print_state_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void toggleTheme() => emit(
    state.copyWith(
      status: ProfileStatus.themeToggled,
      themeMode: state.themeMode.toggle,
    ),
  );

  void toggleLanguage() {
    final LanguageEnum newLanguage = state.language.isEnglish
        ? LanguageEnum.arabic
        : LanguageEnum.english;

    emit(
      state.copyWith(
        status: ProfileStatus.languageToggled,
        language: newLanguage,
      ),
    );
  }
}
