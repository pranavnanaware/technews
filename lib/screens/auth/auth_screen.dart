import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/auth_button.dart';
import 'widgets/email_auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showEmailForm = false;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // Logo and welcome text
                _buildHeader(),
                
                const SizedBox(height: 60),
                
                // Auth form
                _showEmailForm
                    ? _buildEmailForm()
                    : _buildSocialAuthOptions(),
                
                const SizedBox(height: 40),
                
                // Terms and privacy
                _buildTermsText(),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
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
            size: 40,
            color: Colors.white,
          ),
        ).animate().scale(
          duration: 600.ms,
          curve: Curves.elasticOut,
        ),
        
        const SizedBox(height: 32),
        
        // Welcome text
        Text(
          'Welcome to TechNews',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
        
        const SizedBox(height: 12),
        
        Text(
          'Stay ahead with the latest tech news',
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
    );
  }

  Widget _buildSocialAuthOptions() {
    final authProvider = context.watch<AuthProvider>();
    final preferredMethod = authProvider.getPreferredAuthMethod();
    
    return Column(
      children: [
        // Platform-specific primary button
        if (Platform.isIOS) ...[
          AuthButton(
            onPressed: authProvider.isLoading
                ? null
                : () => _handleAppleSignIn(authProvider),
            icon: Icons.apple,
            text: 'Continue with Apple',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            isPrimary: true,
          ).animate().fadeIn(
            delay: 400.ms,
            duration: 500.ms,
          ).slideX(
            begin: -0.3,
            duration: 500.ms,
          ),
          
          const SizedBox(height: 16),
          
          AuthButton(
            onPressed: authProvider.isLoading
                ? null
                : () => _handleGoogleSignIn(authProvider),
            icon: Icons.g_mobiledata,
            text: 'Continue with Google',
            backgroundColor: AppTheme.surfaceColor,
            textColor: AppTheme.textPrimary,
          ).animate().fadeIn(
            delay: 500.ms,
            duration: 500.ms,
          ).slideX(
            begin: -0.3,
            duration: 500.ms,
          ),
        ] else ...[
          AuthButton(
            onPressed: authProvider.isLoading
                ? null
                : () => _handleGoogleSignIn(authProvider),
            icon: Icons.g_mobiledata,
            text: 'Continue with Google',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            isPrimary: true,
          ).animate().fadeIn(
            delay: 400.ms,
            duration: 500.ms,
          ).slideX(
            begin: -0.3,
            duration: 500.ms,
          ),
          
          const SizedBox(height: 16),
          
          AuthButton(
            onPressed: authProvider.isLoading
                ? null
                : () => _handleAppleSignIn(authProvider),
            icon: Icons.apple,
            text: 'Continue with Apple',
            backgroundColor: AppTheme.surfaceColor,
            textColor: AppTheme.textPrimary,
          ).animate().fadeIn(
            delay: 500.ms,
            duration: 500.ms,
          ).slideX(
            begin: -0.3,
            duration: 500.ms,
          ),
        ],
        
        const SizedBox(height: 24),
        
        // Divider
        Row(
          children: [
            const Expanded(
              child: Divider(color: AppTheme.borderColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textTertiary,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppTheme.borderColor),
            ),
          ],
        ).animate().fadeIn(
          delay: 600.ms,
          duration: 400.ms,
        ),
        
        const SizedBox(height: 24),
        
        // Email option
        AuthButton(
          onPressed: authProvider.isLoading
              ? null
              : () {
                  setState(() {
                    _showEmailForm = true;
                  });
                },
          icon: Icons.email_outlined,
          text: 'Continue with Email',
          backgroundColor: AppTheme.surfaceColor,
          textColor: AppTheme.textPrimary,
        ).animate().fadeIn(
          delay: 700.ms,
          duration: 500.ms,
        ).slideX(
          begin: -0.3,
          duration: 500.ms,
        ),
        
        // Error message
        if (authProvider.errorMessage != null) ...[
          const SizedBox(height: 24),
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
                    authProvider.errorMessage!,
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
    );
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        // Back button
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _showEmailForm = false;
                });
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              'Sign in with Email',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Email form
        const EmailAuthForm(),
      ],
    ).animate().fadeIn(duration: 300.ms).slideX(
      begin: 0.3,
      duration: 300.ms,
    );
  }

  Widget _buildTermsText() {
    return Text.rich(
      TextSpan(
        text: 'By continuing, you agree to our ',
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
    ).animate().fadeIn(
      delay: 800.ms,
      duration: 400.ms,
    );
  }

  Future<void> _handleGoogleSignIn(AuthProvider authProvider) async {
    authProvider.clearError();
    final success = await authProvider.signInWithGoogle();
    if (!success && mounted) {
      // Error handling is managed by the provider
    }
  }

  Future<void> _handleAppleSignIn(AuthProvider authProvider) async {
    authProvider.clearError();
    final success = await authProvider.signInWithApple();
    if (!success && mounted) {
      // Error handling is managed by the provider
    }
  }
}