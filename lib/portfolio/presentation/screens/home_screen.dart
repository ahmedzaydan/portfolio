import 'package:flutter/material.dart';

import '../../../utils/size_manager.dart';
import '../widgets/about_section.dart';
import '../widgets/education_section.dart';
import '../widgets/experiences_section.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 40.w),
            sliver: const SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(child: HomeHeader()),
                _Separator(),
                SliverToBoxAdapter(child: AboutSection()),
                _Separator(),
                SliverToBoxAdapter(child: EducationSection()),
                _Separator(),
                SliverToBoxAdapter(child: ExperiencesSection()),
              ],
            ),
          ),
        ],
      ),
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
