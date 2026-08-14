import 'package:flutter/material.dart';

import '../../../utils/size_manager.dart';
import '../widgets/projects_section/projects_section.dart';
import '../widgets/responsive_layout_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayoutBuilder(
        mobile: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 20.w),
        ),
        tablet: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 40.w),
        ),
        desktop: (context) => _Layout(
          padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 40.w),
        ),
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({required this.padding});

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding,
          sliver: const SliverMainAxisGroup(
            slivers: [
              // SliverToBoxAdapter(child: HomeHeader()),
              // _Separator(),
              // SliverToBoxAdapter(child: AboutSection()),
              // _Separator(),
              // SliverToBoxAdapter(child: EducationSection()),
              // _Separator(),
              // SliverToBoxAdapter(child: ExperiencesSection()),
              // _Separator(),
              SliverToBoxAdapter(child: ProjectsSection()),
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
