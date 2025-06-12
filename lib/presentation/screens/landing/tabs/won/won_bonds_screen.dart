import 'package:check_bond/data/models/bonds/data_model/won_bond_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../infra/configs/theme/app_colors.dart';
import '../../../../../infra/loader/overlay_service.dart';
import '../../../../../infra/utils/utils_exports.dart';
import '../../../../common_widgets/text_ctl/text_exports.dart';
import '../../../../providers/providers/bond_provider.dart';
import '../../../../providers/states/bond_state.dart';
import 'widgets/won_bond_card.dart';

class WonBondsScreen extends ConsumerStatefulWidget {
  const WonBondsScreen({super.key});

  @override
  ConsumerState<WonBondsScreen> createState() => _WonBondsScreenState();
}

class _WonBondsScreenState extends ConsumerState<WonBondsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final OverlayService _overlayService = OverlayService();
  ApiStatus? _previousStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Add tab change listener
    _tabController.addListener(_handleTabChange);
    
    // Fetch initial won bonds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bondProvider.notifier).GetUserWonBonds('Pending');
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final status = _tabController.index == 0 ? 'Pending' : 'Claimed';
      ref.read(bondProvider.notifier).GetUserWonBonds(status);
    }
  }

  void _handleClaim(WonBondDataModel data,bool isPending) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const TitleMediumText(contentText: 'Claim Bond'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BodyMediumText(contentText: 'Are you sure you want to claim this bond?'),
            const SizedBox(height: 8),
            BodyMediumText(
              contentText: 'Bond Number: ${data.bond.bondNumber}',
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(bondProvider.notifier).UpdateUserWonBondStatus('Claimed', data.wonId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Claim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bondState = ref.watch(bondProvider);

    // Handle API status changes
    if (_previousStatus != bondState.apiStatus) {
      _previousStatus = bondState.apiStatus;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleApiStatus(bondState.apiStatus, bondState.resp?.message);

        if(bondState.apiStatus == ApiStatus.success && bondState.apiIdentifier == "UpdateUserWonBondStatus")
        {
          ref.read(bondProvider.notifier).GetUserWonBonds('Pending');
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
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
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Claimed'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBondList(bondState.userWonBonds),
                _buildBondList(bondState.userWonBonds),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBondList(List bonds) {
    if (bonds.isEmpty) {
      return const Center(
        child: BodyMediumText(contentText: 'No bonds available'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bonds.length,
      itemBuilder: (context, index) {
        final bond = bonds[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: WonBondCard(
            data: bond,
            onClaim: bond.status == 'Pending' ? () => _handleClaim(bond, true) : null,
          ),
        );
      },
    );
  }

  void _handleApiStatus(ApiStatus? status, String? message) {
    if (status == ApiStatus.loading) {
      _overlayService.showLoadingOverlay(context);
    } else {
      _overlayService.hideLoadingOverlay();

      if (status == ApiStatus.error) {
        ToastUtils.showError(message ?? "Something went wrong");
      }
      // if (status == ApiStatus.success && message != null) {
      //   ToastUtils.showSuccess(message);
      // }
    }
  }
}
