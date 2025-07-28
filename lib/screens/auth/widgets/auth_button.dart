import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool isPrimary;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.isPrimary = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: isPrimary ? 2 : 0,
          shadowColor: isPrimary ? Colors.black.withOpacity(0.1) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: AppTheme.borderColor,
                    width: 1,
                  ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: textColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}