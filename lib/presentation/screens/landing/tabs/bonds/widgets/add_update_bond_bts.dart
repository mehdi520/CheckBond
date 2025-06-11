import 'package:check_bond/data/models/bonds/data_model/bond_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/bond_type_data_model.dart';
import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../infra/configs/config_exports.dart';
import '../../../../../common_widgets/buttons/PrimaryButton.dart';
import '../../../../../common_widgets/form_field_with_label/date_picker_form_field.dart';
import '../../../../../common_widgets/form_field_with_label/text_input_form_field.dart';
import '../../../../../providers/providers/bond_provider.dart';

class AddUpdateBondBts extends ConsumerStatefulWidget {
  final bool isEditing;
  final UserBondDataModel? data;
  final Function(UserBondDataModel data) onSubmit;

  const AddUpdateBondBts({
    Key? key,
    this.isEditing = false,
    this.data,
    required this.onSubmit,
  }) : super(key: key);

  @override
  ConsumerState<AddUpdateBondBts> createState() => _AddUpdateBondBtsState();
}

class _AddUpdateBondBtsState extends ConsumerState<AddUpdateBondBts> {
  final _formKey = GlobalKey<FormState>();
  final _bondNumberController = TextEditingController();
  final _purchaseDateController = TextEditingController();
  BondTypeDataModel? _selectedBondType;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.data != null) {
      _bondNumberController.text = widget.data!.bondNumber;
      _purchaseDateController.text = widget.data!.createdAt;
      // Find and set the selected bond type
      final bondTypes = ref.read(bondProvider).bondTypes;
      _selectedBondType = bondTypes.firstWhere(
        (type) => type.typeId == widget.data!.bondType,
        orElse: () => bondTypes.first,
      );
    }
  }

  @override
  void dispose() {
    _bondNumberController.dispose();
    _purchaseDateController.dispose();
    super.dispose();
  }

  String? _validateBondNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bond number is required';
    }
    if (value.length != 6) {
      return 'Bond number must be 6 digits';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Bond number must contain only digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bondState = ref.watch(bondProvider);
    final bondTypes = bondState.bondTypes;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widget.isEditing ? Icons.edit : Icons.add,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.isEditing ? 'Update Bond' : 'Add New Bond',
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
                    TextInputFormField(
                      ctrl: _bondNumberController,
                      formLabel: 'Bond Number',
                      hintText: 'Enter 6-digit bond number',
                      keyboardType: TextInputType.number,
                      imeAction: TextInputAction.next,
                      validator: _validateBondNumber,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            'Bond Type',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.secondBackground,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<BondTypeDataModel>(
                              value: _selectedBondType,
                              isExpanded: true,
                              hint: const Text('Select bond type'),
                              items: bondTypes.map((type) {
                                return DropdownMenuItem<BondTypeDataModel>(
                                  value: type,
                                  child: Row(
                                    children: [
                                      Text(type.bondType),
                                      if (type.isPermium) ...[
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBondType = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DatePickerFormField(
                      label: 'Date of Purchase',
                      hint: 'Select purchase date',
                      controller: _purchaseDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Purchase date is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: widget.isEditing ? 'Update' : 'Add Bond',
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_selectedBondType == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a bond type'),
                                ),
                              );
                              return;
                            }

                            widget.onSubmit(
                              UserBondDataModel(
                                bondId: widget.data?.bondId ?? 0,
                                bondNumber: _bondNumberController.text.trim(),
                                bondType: _selectedBondType!.typeId,
                                createdAt: _purchaseDateController.text.trim(),
                              ),
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
