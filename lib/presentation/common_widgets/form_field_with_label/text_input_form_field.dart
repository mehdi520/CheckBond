import 'package:check_bond/presentation/common_widgets/input_fields/text_input_field.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_large_text.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_medium_text.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/text_exports.dart';
import 'package:flutter/material.dart';

class TextInputFormField extends StatelessWidget {
  final TextEditingController ctrl;
  final TextInputAction? imeAction;
  final TextInputType? keyboardType;
  final bool? isSecureTextField;
  final String? Function(String?)? validator;
  final String hintText;
  final String formLabel;
  final bool isEnabled;

  const TextInputFormField({
    super.key,
    required this.hintText,
    this.imeAction,
    this.keyboardType,
    this.isSecureTextField,
    this.validator,
    required this.ctrl,
    required this.formLabel,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: BodyLargeText(contentText: formLabel),
          ),
          SizedBox(height: 8),
          TextInputField(
            hintText: hintText,
            ctrl: ctrl,
            imeAction: imeAction,
            keyboardType: keyboardType,
            isSecureTextField: isSecureTextField,
            validator: validator,
            isEnabled: isEnabled,
          )
        ],
      ),
    );
  }
}
