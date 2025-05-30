import 'package:flutter/material.dart';

import '../../../infra/configs/config_exports.dart';
import '../../../infra/utils/utils_exports.dart';


class DatePickerFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isOptional;

  const DatePickerFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.isOptional = false,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      var datestr = DateUtil.formatDisplayDateToServer(picked);
      controller.text = datestr;
     // controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              if (!isOptional) 
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.white,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondBackground, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondBackground, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondBackground, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
} 