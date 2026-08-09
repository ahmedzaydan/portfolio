import 'package:flutter/material.dart';

import '../../../utils/size_manager.dart';
import '../widgets/about_section.dart';
import '../widgets/education_section.dart';
import '../widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 40.w),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomeHeader()),
            _Separator(),
            SliverToBoxAdapter(child: AboutSection()),
            _Separator(),
            SliverToBoxAdapter(child: EducationSection()),
          ],
        ),
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
