import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../portfolio/presentation/cubit/profile_cubit.dart';
import '../config/themes/text_styles_theme_extension.dart';
import '../enums/language_enum.dart';

extension ContextExtension on BuildContext {
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;

  ColorScheme get colorManager {
    return Theme.of(this).colorScheme;
  }

  TextStylesThemeExtension get textStyles {
    return Theme.of(this).extension<TextStylesThemeExtension>()!;
  }

  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom != 0;

  LanguageEnum get language =>
      LanguageEnum.fromCode(Localizations.localeOf(this).languageCode);

  void maybePop() {
    if (canPop()) pop();
  }

  ProfileCubit get cubit => read<ProfileCubit>();
}
