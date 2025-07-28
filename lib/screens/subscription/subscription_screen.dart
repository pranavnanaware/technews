import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/providers/subscription_provider.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/subscription_plan_card.dart';
import 'widgets/feature_list.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlanIndex = 1; // Annual plan selected by default

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
                    children: [
                      const SizedBox(height: 20),
                      
                      // Free trial section
                      _buildFreeTrialSection(),
                      
                      const SizedBox(height: 32),
                      
                      // Subscription plans
                      _buildSubscriptionPlans(),
                      
                      const SizedBox(height: 32),
                      
                      // Features list
                      const FeatureList(),
                      
                      const SizedBox(height: 32),
                      
                      // Continue button
                      _buildContinueButton(),
                      
                      const SizedBox(height: 16),
                      
                      // Restore purchases
                      _buildRestorePurchases(),
                      
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Logo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Icon(
              Icons.flash_on_rounded,
              size: 30,
              color: Colors.white,
            ),
          ).animate().scale(
            duration: 600.ms,
            curve: Curves.elasticOut,
          ),
          
          const SizedBox(height: 24),
          
          // Title
          Text(
            'Unlock Premium Tech News',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(
            delay: 200.ms,
            duration: 600.ms,
          ).slideY(
            begin: 0.3,
            duration: 600.ms,
          ),
          
          const SizedBox(height: 12),
          
          // Subtitle
          Text(
            'Get unlimited access to exclusive tech insights and breaking news',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(
            delay: 300.ms,
            duration: 600.ms,
          ).slideY(
            begin: 0.3,
            duration: 600.ms,
          ),
        ],
      ),
    );
  }

  Widget _buildFreeTrialSection() {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    
    if (subscriptionProvider.hasUsedTrial) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.secondaryColor.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Free trial badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '3-Day Free Trial',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Trial description
          Text(
            'Start your free trial now and explore all premium features',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'No commitment • Cancel anytime',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(
      delay: 400.ms,
      duration: 600.ms,
    ).slideY(
      begin: 0.3,
      duration: 600.ms,
    );
  }

  Widget _buildSubscriptionPlans() {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final plans = subscriptionProvider.plans;

    return Column(
      children: [
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ).animate().fadeIn(
          delay: 500.ms,
          duration: 500.ms,
        ),
        
        const SizedBox(height: 20),
        
        // Plan cards
        ...List.generate(plans.length, (index) {
          final plan = plans[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SubscriptionPlanCard(
              plan: plan,
              isSelected: _selectedPlanIndex == index,
              onTap: () {
                setState(() {
                  _selectedPlanIndex = index;
                });
              },
            ).animate().fadeIn(
              delay: Duration(milliseconds: 600 + (index * 100)),
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

  Widget _buildContinueButton() {
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final hasTrialAvailable = !subscriptionProvider.hasUsedTrial;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: subscriptionProvider.isLoading ? null : _handleContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: subscriptionProvider.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasTrialAvailable ? Icons.play_arrow : Icons.shopping_cart,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hasTrialAvailable ? 'Start Free Trial' : 'Subscribe Now',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    ).animate().fadeIn(
      delay: 900.ms,
      duration: 500.ms,
    ).slideY(
      begin: 0.3,
      duration: 500.ms,
    );
  }

  Widget _buildRestorePurchases() {
    final subscriptionProvider = context.watch<SubscriptionProvider>();

    return Column(
      children: [
        TextButton(
          onPressed: subscriptionProvider.isLoading
              ? null
              : () => _handleRestorePurchases(),
          child: Text(
            'Restore Purchases',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Terms and conditions
        Text.rich(
          TextSpan(
            text: 'By subscribing, you agree to our ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textTertiary,
            ),
            children: [
              TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        
        // Error message
        if (subscriptionProvider.errorMessage != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.errorColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppTheme.errorColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    subscriptionProvider.errorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.errorColor,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).shake(
            hz: 4,
            curve: Curves.easeInOut,
          ),
        ],
      ],
    ).animate().fadeIn(
      delay: 1000.ms,
      duration: 400.ms,
    );
  }

  Future<void> _handleContinue() async {
    final subscriptionProvider = context.read<SubscriptionProvider>();
    
    // Clear any previous errors
    subscriptionProvider.clearError();
    
    // If free trial is available, start it
    if (!subscriptionProvider.hasUsedTrial) {
      final success = await subscriptionProvider.startFreeTrial();
      if (success && mounted) {
        _showSuccessMessage('Free trial started! Enjoy 3 days of premium access.');
      }
      return;
    }
    
    // Otherwise, handle subscription purchase
    final selectedPlan = subscriptionProvider.plans[_selectedPlanIndex];
    final package = subscriptionProvider.getPackageById(selectedPlan.id);
    
    if (package != null) {
      final success = await subscriptionProvider.purchasePackage(package);
      if (success && mounted) {
        _showSuccessMessage('Subscription activated! Welcome to premium.');
      }
    } else {
      subscriptionProvider.clearError();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Selected plan is not available'),
            backgroundColor: AppTheme.errorColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  Future<void> _handleRestorePurchases() async {
    final subscriptionProvider = context.read<SubscriptionProvider>();
    
    subscriptionProvider.clearError();
    final success = await subscriptionProvider.restorePurchases();
    
    if (success && mounted) {
      _showSuccessMessage('Purchases restored successfully.');
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}