import 'package:flutter/material.dart';

import '../../../utils/size_manager.dart';
import '../../utils/sections_enum.dart';
import '../widgets/about_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experiences_section.dart';
import '../widgets/home_header.dart';
import '../widgets/portfolio_navigation_bar.dart';
import '../widgets/projects_section/projects_section.dart';
import '../widgets/responsive_layout_builder.dart';
import '../widgets/skills_section/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<SectionsEnum, GlobalKey> _sectionKeys = {
    SectionsEnum.about: GlobalKey(),
    SectionsEnum.education: GlobalKey(),
    SectionsEnum.experiences: GlobalKey(),
    SectionsEnum.projects: GlobalKey(),
    SectionsEnum.skills: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: PortfolioNavigationBar(sectionKeys: _sectionKeys),
          ),
        ],
      ),
      body: ResponsiveLayoutBuilder(
        mobile: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
          sectionKeys: _sectionKeys,
        ),
        tablet: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 40.w),
          sectionKeys: _sectionKeys,
        ),
        desktop: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 40.w),
          sectionKeys: _sectionKeys,
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.padding, required this.sectionKeys});

  final EdgeInsetsGeometry padding;
  final Map<SectionsEnum, GlobalKey> sectionKeys;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: SliverMainAxisGroup(
            slivers: [
              const SliverToBoxAdapter(child: HomeHeader()),
              const _Separator(),
              AboutSection(key: sectionKeys[SectionsEnum.about]),
              const _Separator(),
              EducationSection(key: sectionKeys[SectionsEnum.education]),
              const _Separator(),
              ExperiencesSection(key: sectionKeys[SectionsEnum.experiences]),
              const _Separator(),
              ProjectsSection(key: sectionKeys[SectionsEnum.projects]),
              const _Separator(),
              SkillsSection(key: sectionKeys[SectionsEnum.skills]),
            ],
          ),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: 40.h));
  }
}
