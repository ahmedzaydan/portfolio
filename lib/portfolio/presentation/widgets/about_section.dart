import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../data/portfolio_data_source.dart';
import 'section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;
    
    return SectionTitle(
      title: 'About Me',
      child: Text(
        personalInfo.about,
        style: context.textStyles.bodyLarge?.copyWith(
          color: context.colorManager.onSurface,
        ),
      ),
    );
  }
}
