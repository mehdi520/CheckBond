import 'package:check_bond/data/models/bonds/data_model/user_bond_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../infra/configs/theme/app_colors.dart';
import '../../../../../infra/loader/overlay_service.dart';
import '../../../../../infra/utils/utils_exports.dart';
import '../../../../common_widgets/text_ctl/text_exports.dart';
import '../../../../providers/providers/bond_provider.dart';
import '../../../../providers/states/bond_state.dart';
import 'widgets/bond_item_widget.dart';
import 'widgets/add_update_bond_bts.dart';

class MyBondsScreens extends ConsumerStatefulWidget {
  const MyBondsScreens({super.key});

  @override
  ConsumerState<MyBondsScreens> createState() => _MyBondsScreensState();
}

class _MyBondsScreensState extends ConsumerState<MyBondsScreens>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final OverlayService _overlayService = OverlayService();
  ApiStatus? _previousStatus;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize with 1 tab, will update when bond types are loaded
    _tabController = TabController(length: 1, vsync: this);

    // Fetch bond types and initial bonds when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bondProvider.notifier).getBondTypes();
      ref.read(bondProvider.notifier).getUserBonds(0);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.index == 0) {
      // If "All" tab is selected, fetch all bonds
      ref.read(bondProvider.notifier).getUserBonds(0);
    } else {
      // If specific bond type is selected, fetch bonds for that type
      final selectedBondType =
          ref.read(bondProvider).bondTypes[_tabController.index - 1];
      ref.read(bondProvider.notifier).getUserBonds(selectedBondType.typeId);
    }
  }

  void _initializeTabController(List bondTypes) {
    if (!_isInitialized && bondTypes.isNotEmpty) {
      _isInitialized = true;
      // Add +1 for the 'All' tab
      _tabController = TabController(
        length: bondTypes.length + 1,
        vsync: this,
      );
      _tabController.addListener(_onTabChanged);
    }
  }

  void _showDeleteConfirmation(int bondId, String bondNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Bond'),
          content: Text('Are you sure you want to delete bond $bondNumber?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(bondProvider.notifier).delUserBonds(bondId);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    // Listen to bond state changes
    final bondState = ref.watch(bondProvider);

    // Handle API status changes
    if (_previousStatus != bondState.apiStatus) {
      _previousStatus = bondState.apiStatus;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleApiStatus(bondState.apiStatus,bondState.resp?.message);
        if(bondState.apiStatus == ApiStatus.success && bondState.apiIdentifier == "addUpdateUseBonds")
          {
            var currentTabId = 0;
            if(_tabController.index > 0)
              {

                final selectedBondType =
                ref.read(bondProvider).bondTypes[_tabController.index - 1];
                currentTabId = selectedBondType.typeId;
              }

            ref.read(bondProvider.notifier).getUserBonds(currentTabId);
          }
      });
    }

    // Initialize tab controller when bond types are loaded
    _initializeTabController(bondState.bondTypes);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
            bondState.bondTypes.isEmpty
                ? const Center(
                  child: BodyMediumText(contentText: 'No bond types available'),
                )
                : Column(
                  children: [
                    // Tab Bar with enhanced styling
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.secondary100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowLight,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicatorColor: AppColors.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        tabs: [
                          // All tab at index 0
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TitleMediumText(
                                  contentText: 'All',
                                  textStyle: TextStyle(
                                    color:
                                        _tabController.index == 0
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                    fontWeight:
                                        _tabController.index == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Bond type tabs
                          ...bondState.bondTypes.map((bondType) {
                            final index =
                                bondState.bondTypes.indexOf(bondType) + 1;
                            return Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TitleMediumText(
                                    contentText: bondType.bondType,
                                    textStyle: TextStyle(
                                      color:
                                          _tabController.index == index
                                              ? AppColors.primary
                                              : AppColors.textSecondary,
                                      fontWeight:
                                          _tabController.index == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  if (bondType.isPermium) ...[
                                    const SizedBox(width: 4),
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
                        ],
                      ),
                    ),

                    // Tab Bar View with enhanced styling
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // All bonds view
                            _buildBondsList(bondState.userBonds),
                            // Individual bond type views
                            ...bondState.bondTypes.map((bondType) {
                              return _buildBondsList(
                                bondState.userBonds
                                    .where(
                                      (bond) =>
                                          bond.bondType == bondType.typeId,
                                    )
                                    .toList(),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder:
                (context) => AddUpdateBondBts(
              onSubmit: (req) {
                ref.read(bondProvider.notifier).addUpdateUseBonds(req);
              },
            ),
          );
        },
        backgroundColor: const Color(0xFF1976D2),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBondsList(List bonds) {
    if (bonds.isEmpty) {
      return const Center(
        child: BodyMediumText(contentText: 'No bonds available'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: bonds.length,
      itemBuilder: (context, index) {
        final bond = bonds[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BondItemWidget(
            data: bond,
            onEdit: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder:
                    (context) => AddUpdateBondBts(
                      isEditing: true,
                      data: bond,
                      onSubmit: (req) {
                        ref.read(bondProvider.notifier).addUpdateUseBonds(req);
                      },
                    ),
              );
            },
            onDelete:
                () => _showDeleteConfirmation(bond.bondId, bond.bondNumber),
          ),
        );
      },
    );
  }

  void _handleApiStatus(ApiStatus? status,String? message) {
    if (status == ApiStatus.loading) {
      _overlayService.showLoadingOverlay(context);
    } else {
      _overlayService.hideLoadingOverlay();

      if (status == ApiStatus.error) {
        ToastUtils.showError(message ?? "Something went wrong");
      }
      // if (status == ApiStatus.success) {
      //   ToastUtils.showSuccess(message ?? "Something went wrong");
      // }
    }
  }
}
