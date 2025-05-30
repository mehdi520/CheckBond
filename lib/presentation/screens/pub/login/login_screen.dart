import 'package:check_bond/infra/extensions/media_query_extension.dart';
import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/infra/utils/toast_utils.dart';
import 'package:check_bond/presentation/common_widgets/buttons/PrimaryButton.dart';
import 'package:check_bond/presentation/common_widgets/form_field_with_label/text_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infra/configs/config_exports.dart';
import '../../../../infra/utils/utils_exports.dart';
import '../../../common_widgets/text_ctl/text_exports.dart';
import '../../../providers/providers/auth_provider.dart';
import '../../../providers/states/auth_state.dart';
import '../../../../data/models/auth_models/sign_up_req_model.dart';

class LoginScreen extends ConsumerWidget {
  final OverlayService _loadingService = OverlayService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  LoginScreen({super.key});

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!ValidationUtils.isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 2) {
      return 'Password must be at least 3 characters long';
    }
    return null;
  }

  void _submitLogin(BuildContext context, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).signin(
        SignUpReqModel(
          email: _emailController.text.trim(),
          password: _passController.text,
          name: 'dfger',
          phone: '3535'
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.apiStatus == ApiStatus.loading) {
        _loadingService.showLoadingOverlay(context);
      }
      if (next.apiStatus == ApiStatus.success) {
        _loadingService.hideLoadingOverlay();
        Navigator.pushReplacementNamed(context, AppRoutes.landingRoute);
      }
      if (next.apiStatus == ApiStatus.error) {
        _loadingService.hideLoadingOverlay();
        ToastUtils.showError(next.resp?.message ?? 'Login failed');
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.mediaQueryHeight * 0.1),
                    Center(
                      child: SizedBox(
                        width: 110,
                        child: Image.asset(
                          AppImages.logo,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    TitleLargeText(
                      contentText: 'Welcome back!',
                    ),
                    const SizedBox(height: 2),
                    BodyLargeText(
                      contentText: 'Enter your credentials below to get started.',
                    ),
                    const SizedBox(height: 30),
                    TextInputFormField(
                      hintText: 'Enter your email here',
                      ctrl: _emailController,
                      formLabel: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 10),
                    TextInputFormField(
                      hintText: 'Enter your password here',
                      ctrl: _passController,
                      formLabel: 'Password',
                      isSecureTextField: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 30),
                    PrimaryButton(
                      text: 'Login',
                      onTap: () => _submitLogin(context, ref),
                    ),
                    const SizedBox(height: 20),
                    _dont_have_Acc(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dont_have_Acc(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.registerRoute);
          },
          child: BodyLargeText(contentText: 'Do not have an Account?',textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.primary
          ),)

        ),
        Center(
          child: Container(
            height: 2,
            width: 190,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

