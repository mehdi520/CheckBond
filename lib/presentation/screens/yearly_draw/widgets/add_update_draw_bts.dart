import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/presentation/common_widgets/buttons/PrimaryButton.dart';
import 'package:check_bond/presentation/common_widgets/form_field_with_label/date_picker_form_field.dart';
import 'package:check_bond/presentation/common_widgets/form_field_with_label/text_input_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../infra/configs/config_exports.dart';


class AddUpdateDrawBts extends StatefulWidget {
  final DrawDataModel? data;
  final bool? isEditing;
  final void Function(String date, String day, String place)? onCreate;

  const AddUpdateDrawBts({Key? key, this.onCreate,this.data,this.isEditing}) : super(key: key);

  @override
  State<AddUpdateDrawBts> createState() =>
      _AddUpdateDrawBtsState();
}

class _AddUpdateDrawBtsState extends State<AddUpdateDrawBts> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _placeController = TextEditingController();
  final _dayController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _dayController.dispose();
    _placeController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if(widget.isEditing ?? false)
    {
      // _nameController.text = widget.data!.name ?? "";
      // _descController.text = widget.data!.description ?? "";

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Create New Draw',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DatePickerFormField(
                      label: 'Draw Date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      }, hint: 'Select draw date',
                      controller: _dateController,
                    ),
                    const SizedBox(height: 16),
                    TextInputFormField(
                      ctrl: _dayController,
                      formLabel: 'Day',
                      hintText: 'Enter the Draw Day',
                      imeAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Day is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextInputFormField(
                      ctrl: _placeController,
                      formLabel: 'Place',
                      hintText: 'Enter draw place',
                      imeAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Place is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text:  'Create',
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            widget.onCreate?.call(
                              _dateController.text.trim(),
                              _dayController.text.trim(),
                              _placeController.text.trim()
                            );

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
