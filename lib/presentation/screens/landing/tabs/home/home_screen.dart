import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/presentation/providers/providers/bond_provider.dart';
import 'package:check_bond/presentation/providers/states/bond_state.dart';
import 'package:check_bond/presentation/screens/landing/tabs/home/widgets/year_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../infra/utils/utils_exports.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final OverlayService _loadingService;
  bool _isInitialized = false;
  ProviderSubscription<BondState>? _subscription;

  void _showLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadingService.showLoadingOverlay(context);
    });
  }

  void _hideLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadingService.hideLoadingOverlay();
    });
  }

  void _handleError(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadingService.hideLoadingOverlay();
      ToastUtils.showError(message);
    });
  }

  void _handleStateChange(BondState? previous, BondState next) {
    if (previous?.apiStatus == next.apiStatus) return;

    switch (next.apiStatus) {
      case ApiStatus.loading:
        _showLoading();
        break;
      case ApiStatus.success:
        _hideLoading();
        break;
      case ApiStatus.error:
        _handleError(next.resp?.message ?? 'Login failed');
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadingService = OverlayService();
    
    Future.microtask(() {
      _subscription = ref.listenManual(bondProvider, _handleStateChange);
      
      if (!_isInitialized) {
        _isInitialized = true;
        ref.read(bondProvider.notifier).getRecordsAvailableYears();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.close();
    _hideLoading();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final bondsYears = ref.watch(
                bondProvider.select((state) => state.dataYears),
              );
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: bondsYears.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final draw = bondsYears[index];
                  return YearItemWidget(data: draw);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
