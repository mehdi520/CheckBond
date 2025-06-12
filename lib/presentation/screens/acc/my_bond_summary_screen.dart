import 'package:check_bond/data/models/bonds/data_model/user_bond_summary_data_model.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/configs/theme/app_colors.dart';
import '../../../infra/loader/overlay_service.dart';
import '../../../infra/utils/utils_exports.dart';
import '../../common_widgets/text_ctl/text_exports.dart';
import '../../providers/providers/bond_provider.dart';

class MyBondSummaryScreen extends ConsumerStatefulWidget {
  const MyBondSummaryScreen({super.key});

  @override
  ConsumerState<MyBondSummaryScreen> createState() => _MyBondSummaryScreenState();
}

class _MyBondSummaryScreenState extends ConsumerState<MyBondSummaryScreen> {
  final OverlayService _overlayService = OverlayService();
  ApiStatus? _previousStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bondProvider.notifier).GetUserBondsSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bondState = ref.watch(bondProvider);

    // Handle API status changes
    if (_previousStatus != bondState.apiStatus) {
      _previousStatus = bondState.apiStatus;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleApiStatus(bondState.apiStatus, bondState.resp?.message);
      });
    }

    return Scaffold(
      appBar: BasicAppBar(title: 'Bonds Summary'),
      body: Container(
        color: AppColors.secondary100,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(bondState.summaryDataModel),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: const TitleMediumText(
                  contentText: 'Bond Type Breakdown',
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              _buildBondTypeList(bondState.summaryDataModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(UserBondSummaryDataModel? summaryData) {
    if (summaryData == null) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total Bonds',
            summaryData.totalBond.toString(),
            Icons.numbers,
            AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryCard(
            'Total Worth',
            'Rs ${summaryData.totalWorth}',
            Icons.currency_rupee,
            AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              BodySmallText(
                contentText: title,
                textStyle: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TitleMediumText(
            contentText: value,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBondTypeList(UserBondSummaryDataModel? summaryData) {
    if (summaryData == null || summaryData.bonds == null) return const SizedBox.shrink();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: summaryData.bonds.length,
      itemBuilder: (context, index) {
        final bond = summaryData.bonds[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodySmallText(
                      contentText: 'Bond Type',
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TitleMediumText(
                      contentText: 'Rs ${bond.bondType}',
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodySmallText(
                      contentText: 'Count',
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TitleMediumText(
                      contentText: bond.bondCount.toString(),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodySmallText(
                      contentText: 'Worth',
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TitleMediumText(
                      contentText: 'Rs ${bond.bondWorth}',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
    }
  }
}
