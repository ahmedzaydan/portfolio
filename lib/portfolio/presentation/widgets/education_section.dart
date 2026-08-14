import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/size_manager.dart';
import '../../data/models/education_model.dart';
import '../../data/portfolio_data_source.dart';
import 'section_title.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    const education = PortfolioDataSource.education;

    return SectionTitle(
      title: 'Education',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _firstRow(education, context),
          SizedBox(height: 8.h),
          Text(
            education.institution,
            style: context.textStyles.title.regular.copyWith(
              color: context.colorManager.onSurface,
            ),
          ),
          SizedBox(height: 16.h),
          _secondRow(education, context),
        ],
      ),
    );
  }

  Wrap _secondRow(EducationModel education, BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: education.details
          .map(
            (detail) => Chip(
              label: Text(
                detail,
                style: context.textStyles.body.regular.copyWith(
                  color: context.colorManager.onPrimary,
                ),
              ),
              backgroundColor: context.colorManager.primary,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
          )
          .toList(),
    );
  }

  Row _firstRow(EducationModel education, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            education.degree,
            style: context.textStyles.title.bold.copyWith(
              color: context.colorManager.primary,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          '${education.startDate} - ${education.endDate}',
          style: context.textStyles.body.regular.copyWith(
            color: context.colorManager.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
