import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../extensions/color_extension.dart';
import '../../../extensions/context_extension.dart';
import '../../../utils/assets_manager.dart';
import '../../../utils/size_manager.dart';
import '../../data/portfolio_data_source.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const personalInfo = PortfolioDataSource.personalInfo;
    return Wrap(
      spacing: 4.w,
      children: [
        // _ContactItem(
        //   svgPath: AssetsManager.locationSVG,
        //   value: personalInfo.location,
        // ),
        _ContactItem(
          svgPath: AssetsManager.phoneSVG,
          value: personalInfo.phone,
          url: 'tel:${personalInfo.phone}',
        ),
        _ContactItem(
          svgPath: AssetsManager.emailSVG,
          value: personalInfo.email,
          url: 'mailto:${personalInfo.email}',
        ),
        _ContactItem(
          svgPath: AssetsManager.whatsappSVG,
          url: personalInfo.whatsApp.url,
        ),
        _ContactItem(
          svgPath: AssetsManager.linkedinSVG,
          url: personalInfo.linkedIn.url,
        ),
        _ContactItem(
          svgPath: AssetsManager.githubSVG,
          url: personalInfo.github.url,
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({required this.svgPath, this.value, this.url});

  final String svgPath;
  final String? value;
  final String? url;

  Future<void> _launchUrl() async {
    if (url == null) return;
    final uri = Uri.parse(url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: url != null ? _launchUrl : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 2.w,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: context.colorManager.primary.withCustomOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(
              svgPath,
              width: 24.r,
              height: 24.r,
              colorFilter: ColorFilter.mode(
                context.colorManager.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          if (value != null) ...[
            Text(
              value!,
              style: context.textStyles.bodyMedium?.copyWith(
                color: context.colorManager.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
