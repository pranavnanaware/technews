import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class FeatureList extends StatelessWidget {
  const FeatureList({super.key});

  static const List<Feature> _features = [
    Feature(
      icon: Icons.flash_on_rounded,
      title: 'Breaking News Alerts',
      description: 'Get instant notifications for major tech developments',
    ),
    Feature(
      icon: Icons.trending_up_rounded,
      title: 'Market Analysis',
      description: 'Deep insights into tech stocks and market trends',
    ),
    Feature(
      icon: Icons.workspace_premium_rounded,
      title: 'Premium Articles',
      description: 'Exclusive long-form content from industry experts',
    ),
    Feature(
      icon: Icons.bookmark_added_rounded,
      title: 'Unlimited Bookmarks',
      description: 'Save and organize your favorite articles',
    ),
    Feature(
      icon: Icons.download_rounded,
      title: 'Offline Reading',
      description: 'Download articles to read anywhere, anytime',
    ),
    Feature(
      icon: Icons.block_rounded,
      title: 'Ad-Free Experience',
      description: 'Enjoy clean, distraction-free reading',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s Included',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Feature grid
        ...List.generate(_features.length, (index) {
          final feature = _features[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _FeatureItem(feature: feature),
          );
        }),
      ],
    );
  }
}

class Feature {
  final IconData icon;
  final String title;
  final String description;

  const Feature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureItem extends StatelessWidget {
  final Feature feature;

  const _FeatureItem({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon container
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            feature.icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                feature.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}