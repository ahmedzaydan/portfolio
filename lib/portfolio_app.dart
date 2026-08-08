import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/localization/app_localizations.dart';
import 'config/routes/app_router.dart';
import 'config/themes/theme_manager.dart';
import 'utils/size_manager.dart';
import 'portfolio/presentation/cubit/profile_cubit.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit();
    ThemeManager.instance.setFontFamily(_profileCubit.state.language);
  }

  @override
  void didChangeDependencies() {
    SizeManager.instance.updateInfo(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => BlocProvider<ProfileCubit>(
    create: (context) => _profileCubit,
    child: BlocConsumer<ProfileCubit, ProfileState>(
      listener: _listener,
      builder: (context, profileState) {
        final themeManager = ThemeManager.instance;

        return MediaQuery.withClampedTextScaling(
          minScaleFactor: 1.0,
          maxScaleFactor: 1.3,
          child: MaterialApp.router(
            routerConfig: appRouter,

            // Localization configuration
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: profileState.language.locale,

            // Theme configuration
            theme: themeManager.theme,
            themeMode: profileState.themeMode,
            themeAnimationCurve: themeManager.themeAnimationCurve,
            themeAnimationDuration: themeManager.themeAnimationDuration,
            themeAnimationStyle: themeManager.themeAnimationStyle,

            // Other configurations
            debugShowCheckedModeBanner: false,
            title: 'Portolio App',
          ),
        );
      },
    ),
  );

  void _listener(BuildContext context, ProfileState state) {
    if (state.isLanguageToggled) {
      ThemeManager.instance.onLangaugeChanged(state.language);
    }
  }
}
