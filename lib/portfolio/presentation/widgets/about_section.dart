import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../data/portfolio_data_source.dart';
import 'section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;

    return Section(
      title: 'About Me',
      child: Text(
        personalInfo.about,
        style: context.textStyles.body.regular.copyWith(
          color: context.colorManager.onSurface,
        ),
      ),
    );
  }
}
