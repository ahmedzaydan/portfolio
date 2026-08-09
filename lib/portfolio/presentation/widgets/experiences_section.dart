import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';
import '../../data/models/experiences_model.dart';
import '../../data/portfolio_data_source.dart';
import 'section_title.dart';

class ExperiencesSection extends StatelessWidget {
  const ExperiencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = PortfolioDataSource.experiences.experiences;

    return SectionTitle(
      title: 'Experiences',
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: experiences.length,
        separatorBuilder: (context, index) => SizedBox(height: 32.h),
        itemBuilder: (context, index) =>
            _ExperienceItem(experience: experiences[index]),
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({required this.experience});

  final ExperienceModel experience;

  Future<void> _launchUrl() async {
    final uri = Uri.parse(experience.companyUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Row(
          children: [
            Text(
              '${experience.role} - ',
              style: context.textStyles.titleLarge?.copyWith(
                color: context.colorManager.onSurface,
              ),
            ),
            InkWell(
              onTap: _launchUrl,
              borderRadius: BorderRadius.circular(12.r),
              child: Text(
                experience.companyName,
                style: context.textStyles.titleLarge?.copyWith(
                  color: context.colorManager.primary,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(width: 16.w),
            Text(
              '${experience.startDate} - ${experience.endDate}',
              style: context.textStyles.bodyLarge?.copyWith(
                color: context.colorManager.onSurfaceVariant,
              ),
            ),
          ],
        ),
        
        if (experience.responsibilities.isNotEmpty)
          _ResponsibilitiesList(responsibilities: experience.responsibilities),
      ],
    );
  }
}

class _ResponsibilitiesList extends StatelessWidget {
  const _ResponsibilitiesList({required this.responsibilities});

  final List<String> responsibilities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: responsibilities.length,
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final resp = responsibilities[index];
        return Row(
          children: [
            Text(
              '• ',
              style: context.textStyles.bodyLarge?.copyWith(
                color: context.colorManager.primary,
              ),
            ),
            Expanded(
              child: Text(
                resp,
                style: context.textStyles.bodyMedium?.copyWith(
                  color: context.colorManager.onSurface,
                  height: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
