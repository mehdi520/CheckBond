import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/configs/theme/app_colors.dart';
import '../../../infra/utils/utils_exports.dart';
import '../../../infra/loader/overlay_service.dart';
import '../../../infra/utils/toast_utils.dart';
import '../../common_widgets/form_field_with_label/text_input_form_field.dart';
import '../../providers/providers/auth_provider.dart';
import '../../providers/states/auth_state.dart';
import '../../../data/models/user/req_model/pass_change_req_model.dart';

class ChangePassScreen extends ConsumerStatefulWidget {
  const ChangePassScreen({super.key});

  @override
  ConsumerState<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends ConsumerState<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _loadingService = OverlayService();

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).changePassword(
        PassChangeReqModel(
          oldPass: _oldPassController.text.trim(),
          newPass: _newPassController.text.trim(),
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
        ToastUtils.showSuccess('Password changed successfully');
        Navigator.pop(context); // Navigate back after successful password change
      }
      if (next.apiStatus == ApiStatus.error) {
        _loadingService.hideLoadingOverlay();
        ToastUtils.showError(next.resp?.message ?? 'Password change failed');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Old Password Field
                TextInputFormField(
                  ctrl: _oldPassController,
                  formLabel: 'Old Password',
                  hintText: 'Enter your old password',
                  keyboardType: TextInputType.visiblePassword,
                  imeAction: TextInputAction.next,
                  isSecureTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // New Password Field
                TextInputFormField(
                  ctrl: _newPassController,
                  formLabel: 'New Password',
                  hintText: 'Enter your new password',
                  keyboardType: TextInputType.visiblePassword,
                  imeAction: TextInputAction.next,
                  isSecureTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Confirm Password Field
                TextInputFormField(
                  ctrl: _confirmPassController,
                  formLabel: 'Confirm New Password',
                  hintText: 'Confirm your new password',
                  keyboardType: TextInputType.visiblePassword,
                  imeAction: TextInputAction.done,
                  isSecureTextField: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPassController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Change Password Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleChangePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Change Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
