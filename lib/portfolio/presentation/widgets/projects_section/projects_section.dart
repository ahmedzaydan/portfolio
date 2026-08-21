import 'package:flutter/material.dart';

import '../../../../utils/size_manager.dart';
import '../../../data/portfolio_data_source.dart';
import '../responsive_layout_builder.dart';
import '../section.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Projects',
      child: ResponsiveLayoutBuilder(
        mobile: (context) => const _ProjectsGrid(crossAxisCount: 1),
        tablet: (context) => const _ProjectsGrid(crossAxisCount: 2),
        desktop: (context) => const _ProjectsGrid(crossAxisCount: 3),
      ),
    );
  }
}

class _ProjectsGrid extends StatelessWidget {
  final int crossAxisCount;

  const _ProjectsGrid({required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioDataSource.projects.projects;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 20.h,
        mainAxisExtent: 400.h,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) => ProjectCard(project: projects[index]),
    );
  }
}
