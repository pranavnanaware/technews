import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';

class EmailAuthForm extends StatefulWidget {
  const EmailAuthForm({super.key});

  @override
  State<EmailAuthForm> createState() => _EmailAuthFormState();
}

class _EmailAuthFormState extends State<EmailAuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();

  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _isPasswordResetMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isPasswordResetMode) ...[
            _buildPasswordResetForm(authProvider),
          ] else ...[
            _buildMainForm(authProvider),
          ],
          
          // Error message
          if (authProvider.errorMessage != null) ...[
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
      ),
    );
  }

  Widget _buildMainForm(AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Name field (only for sign up)
        if (_isSignUp) ...[
          _buildTextField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            label: 'Full Name',
            hint: 'Enter your full name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your full name';
              }
              if (value.trim().length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        ],

        // Email field
        _buildTextField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          label: 'Email',
          hint: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.email_outlined,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email address';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // Password field
        _buildTextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          label: 'Password',
          hint: _isSignUp ? 'Create a password' : 'Enter your password',
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: AppTheme.textTertiary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (_isSignUp && value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),

        const SizedBox(height: 24),

        // Sign in/up button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: authProvider.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _isSignUp ? 'Create Account' : 'Sign In',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 16),

        // Forgot password (only for sign in)
        if (!_isSignUp) ...[
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isPasswordResetMode = true;
                });
              },
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Switch between sign in and sign up
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isSignUp ? 'Already have an account? ' : 'Don\'t have an account? ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                  authProvider.clearError();
                });
              },
              child: Text(
                _isSignUp ? 'Sign In' : 'Sign Up',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordResetForm(AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Reset Password',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          'Enter your email address and we\'ll send you a link to reset your password.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        const SizedBox(height: 24),

        // Email field
        _buildTextField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          label: 'Email',
          hint: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          prefixIcon: Icons.email_outlined,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your email address';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),

        const SizedBox(height: 24),

        // Reset password button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _handlePasswordReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: authProvider.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Send Reset Link',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 16),

        // Back to sign in
        Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                _isPasswordResetMode = false;
                authProvider.clearError();
              });
            },
            child: Text(
              'Back to Sign In',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppTheme.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          prefixIcon,
          color: AppTheme.textTertiary,
        ),
        suffixIcon: suffixIcon,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.textSecondary,
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.textTertiary,
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    authProvider.clearError();

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final name = _nameController.text.trim();

    bool success;
    if (_isSignUp) {
      success = await authProvider.signUpWithEmail(email, password, name);
    } else {
      success = await authProvider.signInWithEmail(email, password);
    }

    if (!success && mounted) {
      // Error handling is managed by the provider
    }
  }

  Future<void> _handlePasswordReset() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    authProvider.clearError();

    final email = _emailController.text.trim();
    final success = await authProvider.resetPassword(email);

    if (success && mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset link sent to $email',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: AppTheme.successColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      
      setState(() {
        _isPasswordResetMode = false;
      });
    }
  }
}