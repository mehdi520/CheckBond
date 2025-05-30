import 'package:flutter/material.dart';

import '../../../infra/configs/config_exports.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const PrimaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
