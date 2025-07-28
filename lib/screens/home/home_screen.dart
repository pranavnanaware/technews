import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/subscription_provider.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Welcome message
                      _buildWelcomeSection(),
                      
                      const SizedBox(height: 32),
                      
                      // Featured news section
                      _buildFeaturedNews(),
                      
                      const SizedBox(height: 32),
                      
                      // News list
                      _buildNewsList(),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
            ),
            child: const Icon(
              Icons.flash_on_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // App name
          Text(
            'TechNews',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          
          const Spacer(),
          
          // Profile menu
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.person_outline,
              color: AppTheme.textSecondary,
            ),
            onSelected: _handleMenuSelection,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'subscription',
                child: Text('Subscription'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildWelcomeSection() {
    final authProvider = context.watch<AuthProvider>();
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final userName = authProvider.user?.displayName ?? 'Tech Enthusiast';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, $userName!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(
          delay: 200.ms,
          duration: 600.ms,
        ).slideY(
          begin: 0.3,
          duration: 600.ms,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          'Stay updated with the latest tech developments',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ).animate().fadeIn(
          delay: 300.ms,
          duration: 600.ms,
        ).slideY(
          begin: 0.3,
          duration: 600.ms,
        ),
        
        // Subscription status
        if (subscriptionProvider.isInTrial) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.secondaryColor.withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    subscriptionProvider.getTrialStatusText(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
            delay: 400.ms,
            duration: 500.ms,
          ),
        ],
      ],
    );
  }

  Widget _buildFeaturedNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Story',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(
          delay: 500.ms,
          duration: 500.ms,
        ),
        
        const SizedBox(height: 16),
        
        // Featured article card
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.secondaryColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'AI & MACHINE LEARNING',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Article title
                Text(
                  'OpenAI Unveils GPT-5: The Next Frontier in Artificial Intelligence',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Article meta
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '2 hours ago',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '12.5K views',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().fadeIn(
          delay: 600.ms,
          duration: 600.ms,
        ).slideY(
          begin: 0.3,
          duration: 600.ms,
        ),
      ],
    );
  }

  Widget _buildNewsList() {
    final newsItems = [
      {
        'title': 'Apple Announces M4 Chip with Revolutionary Performance',
        'category': 'HARDWARE',
        'time': '4 hours ago',
        'views': '8.2K',
      },
      {
        'title': 'Tesla\'s New Autopilot Update Improves Safety by 40%',
        'category': 'AUTOMOTIVE',
        'time': '6 hours ago',
        'views': '15.7K',
      },
      {
        'title': 'Google Cloud Launches New AI-Powered Development Tools',
        'category': 'CLOUD COMPUTING',
        'time': '8 hours ago',
        'views': '6.1K',
      },
      {
        'title': 'Meta\'s Quest 4 VR Headset Leaked with Stunning Features',
        'category': 'VIRTUAL REALITY',
        'time': '12 hours ago',
        'views': '22.3K',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest News',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(
          delay: 700.ms,
          duration: 500.ms,
        ),
        
        const SizedBox(height: 16),
        
        // News items
        ...List.generate(newsItems.length, (index) {
          final item = newsItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _NewsItem(
              title: item['title']!,
              category: item['category']!,
              time: item['time']!,
              views: item['views']!,
            ).animate().fadeIn(
              delay: Duration(milliseconds: 800 + (index * 100)),
              duration: 500.ms,
            ).slideX(
              begin: 0.3,
              duration: 500.ms,
            ),
          );
        }),
      ],
    );
  }

  void _handleMenuSelection(String value) async {
    switch (value) {
      case 'logout':
        final authProvider = context.read<AuthProvider>();
        await authProvider.signOut();
        break;
      case 'profile':
        // Navigate to profile
        break;
      case 'subscription':
        // Navigate to subscription
        break;
      case 'settings':
        // Navigate to settings
        break;
    }
  }
}

class _NewsItem extends StatelessWidget {
  final String title;
  final String category;
  final String time;
  final String views;

  const _NewsItem({
    required this.title,
    required this.category,
    required this.time,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 12),
          
          // Meta information
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: AppTheme.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.visibility,
                size: 14,
                color: AppTheme.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                '$views views',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.bookmark_border,
                size: 20,
                color: AppTheme.textTertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}