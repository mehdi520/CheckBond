import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infra/configs/theme/app_colors.dart';
import '../../../../infra/utils/utils_exports.dart';
import '../../../common_widgets/form_field_with_label/text_input_form_field.dart';
import '../../../common_widgets/text_ctl/text_exports.dart';
import '../../../providers/providers/auth_provider.dart';
import '../../../providers/states/auth_state.dart';
import '../../../../data/models/auth_models/sign_up_req_model.dart';
import '../../../../infra/loader/overlay_service.dart';
import '../../../../infra/utils/toast_utils.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _loadingService = OverlayService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).signup(
        SignUpReqModel(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.apiStatus == ApiStatus.loading) {
        _loadingService.showLoadingOverlay(context);
      }
      if (next.apiStatus == ApiStatus.success) {
        _loadingService.hideLoadingOverlay();
        ToastUtils.showSuccess('Account created successfully');
        Navigator.pop(context); // Navigate back to login screen
      }
      if (next.apiStatus == ApiStatus.error) {
        _loadingService.hideLoadingOverlay();
        ToastUtils.showError(next.resp?.message ?? 'Signup failed');
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Header
                const TitleLargeText(
                  contentText: 'Create Account',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const BodyMediumText(
                  contentText: 'Please fill in the details to create your account',
                  textColor: AppColors.textSecondary,
                ),
                const SizedBox(height: 32),
                // Name Field
                TextInputFormField(
                  ctrl: _nameController,
                  formLabel: 'Full Name',
                  hintText: 'Enter your full name',
                  keyboardType: TextInputType.name,
                  imeAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Email Field
                TextInputFormField(
                  ctrl: _emailController,
                  formLabel: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  imeAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Phone Field
                TextInputFormField(
                  ctrl: _phoneController,
                  formLabel: 'Phone Number',
                  hintText: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                  imeAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field
                TextInputFormField(
                  ctrl: _passwordController,
                  formLabel: 'Password',
                  hintText: 'Enter your password',
                  keyboardType: TextInputType.visiblePassword,
                  imeAction: TextInputAction.next,
                  isSecureTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                TextInputFormField(
                  ctrl: _confirmPasswordController,
                  formLabel: 'Confirm Password',
                  hintText: 'Confirm your password',
                  keyboardType: TextInputType.visiblePassword,
                  imeAction: TextInputAction.done,
                  isSecureTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 24),
                // Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BodyMediumText(
                      contentText: 'Already have an account?',
                      textColor: AppColors.textSecondary,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
