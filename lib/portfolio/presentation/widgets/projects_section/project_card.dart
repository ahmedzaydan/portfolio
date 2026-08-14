import 'package:flutter/material.dart';

import '../../../../extensions/color_extension.dart';
import '../../../../extensions/context_extension.dart';
import '../../../../utils/size_manager.dart';
import '../../../data/models/projects_model.dart';
import 'project_available_stores.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({required this.project, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cyanColor = context.colorManager.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.02, 1.02, 1.0)
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colorManager.surfaceContainer.withCustomOpacity(20),
          border: Border.all(color: cyanColor.withCustomOpacity(0.15)),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 4, child: _LogoBanner(image: widget.project.image)),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.name,
                      style: context.textStyles.title.medium.copyWith(
                        color: cyanColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: context.textStyles.body.regular.copyWith(
                          color: context.colorManager.onSurfaceVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    PorojectAvailableStores(project: widget.project),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoBanner extends StatelessWidget {
  const _LogoBanner({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: AspectRatio(aspectRatio: 1, child: Image.asset(image)),
        ),
      ),
    );
  }
}
