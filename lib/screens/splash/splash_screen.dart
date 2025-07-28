import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
              // Top spacing
              const Spacer(flex: 2),
              
              // Logo section
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated logo container
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.flash_on_rounded,
                              size: 60,
                              color: Colors.white,
                            ),
                          ).animate().fadeIn(duration: 800.ms).scale(
                            begin: const Offset(0.5, 0.5),
                            duration: 800.ms,
                            curve: Curves.elasticOut,
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // App name
                    ShaderMask(
                      shaderCallback: (bounds) => AppTheme.primaryGradient
                          .createShader(bounds),
                      child: Text(
                        'TechNews',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ).animate().fadeIn(
                      delay: 400.ms,
                      duration: 600.ms,
                    ).slideY(
                      begin: 0.3,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Tagline
                    Text(
                      'Stay ahead with the latest tech',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ).animate().fadeIn(
                      delay: 600.ms,
                      duration: 600.ms,
                    ).slideY(
                      begin: 0.3,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),
                  ],
                ),
              ),
              
              // Loading indicator
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Custom loading dots
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: _LoadingDot(
                            delay: Duration(milliseconds: index * 200),
                          ),
                        );
                      }),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(
                      delay: 1000.ms,
                      duration: 400.ms,
                    ),
                  ],
                ),
              ),
              
              // Bottom spacing
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingDot extends StatefulWidget {
  final Duration delay;
  
  const _LoadingDot({required this.delay});

  @override
  State<_LoadingDot> createState() => _LoadingDotState();
}

class _LoadingDotState extends State<_LoadingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}