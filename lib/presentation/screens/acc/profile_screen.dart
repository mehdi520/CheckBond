import 'package:check_bond/data/data_sources/local/hive_manager.dart';
import 'package:check_bond/data/models/user/req_model/update_profile_req_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/configs/theme/app_colors.dart';
import '../../../infra/utils/utils_exports.dart';
import '../../../infra/loader/overlay_service.dart';
import '../../../infra/utils/toast_utils.dart';
import '../../common_widgets/form_field_with_label/text_input_form_field.dart';
import '../../common_widgets/form_field_with_label/date_picker_form_field.dart';
import '../../common_widgets/text_ctl/text_exports.dart';
import '../../providers/providers/auth_provider.dart';
import '../../providers/states/auth_state.dart';
import '../../../data/models/auth_models/sign_up_req_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _loadingService = OverlayService();

  @override
  void initState() {
    super.initState();
    // TODO: Load user profile data
    _loadUserProfile();
  }

  void _loadUserProfile() {
    var user = HiveManager.getUserJson();
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phone ?? '';
    _dateController.text = user?.createdAt ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleUpdateProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).updateProfile(
        UpdateProfileReqModel(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
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
        ToastUtils.showSuccess('Profile updated successfully');
      }
      if (next.apiStatus == ApiStatus.error) {
        _loadingService.hideLoadingOverlay();
        ToastUtils.showError(next.resp?.message ?? 'Profile update failed');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                // Joined Date Field (Read-only)
                DatePickerFormField(
                  label: 'Joined Date',
                  hint: 'Select date',
                  controller: _dateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                // Update Profile Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleUpdateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Update Profile'),
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
