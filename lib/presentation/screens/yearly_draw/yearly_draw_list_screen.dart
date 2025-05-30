import 'package:check_bond/data/data_sources/local/hive_manager.dart';
import 'package:check_bond/data/models/bonds/data_model/record_avail_year_data_model.dart';
import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/infra/utils/utils_exports.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:check_bond/presentation/providers/providers/bond_provider.dart';
import 'package:check_bond/presentation/screens/yearly_draw/widgets/item_sch_bond.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/configs/config_exports.dart';

class YearlyDrawListScreen extends ConsumerWidget {
  final OverlayService _loadingService = OverlayService();
  bool isAPiCalled = false;
  final RecordAvailYearDataModel data;

  YearlyDrawListScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiStatus = ref.watch(bondProvider);
    print(apiStatus.apiStatus.toString());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (apiStatus.apiStatus == ApiStatus.loading) {
        _loadingService.showLoadingOverlay(context);
      } else {
        _loadingService.hideLoadingOverlay();
      }

      if (!isAPiCalled) {
        ref.read(bondProvider.notifier).getSchBondsByYear(data.id);
        isAPiCalled = true;
      }
    });

    return Scaffold(
      appBar: BasicAppBar(title: '2025 Draws'),
      body: Consumer(
        builder: (context, ref, child) {
          final bondsYears = ref.watch(
            bondProvider.select((state) => state.schBonds),
          );
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bondsYears.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final draw = bondsYears[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.draw_resultRoute);
                },
                onLongPress: () {
                  final user = HiveManager.getUserJson();
                  Navigator.pushNamed(context, AppRoutes.upload_draw_resultRoute,arguments: {
                    'data' : draw
                  });
                  if (user?.id == 10) {

                  }
                },
                child: ItemSchBond(data: draw),
              );
            },
          );
        },
      ),
    );
  }
}
