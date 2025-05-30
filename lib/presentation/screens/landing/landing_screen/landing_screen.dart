import 'package:check_bond/presentation/common_widgets/app_bars/home_app_bar.dart';
import 'package:check_bond/presentation/screens/landing/landing_screen/widgets/side_menu.dart';
import 'package:check_bond/presentation/screens/landing/tabs/bonds/my_bonds_screens.dart';
import 'package:check_bond/presentation/screens/landing/tabs/home/home_screen.dart';
import 'package:check_bond/presentation/screens/landing/tabs/info/bond_info_screen.dart';
import 'package:check_bond/presentation/screens/landing/tabs/won/won_bonds_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs =  [
    HomeScreen(),
    MyBondsScreens(),
    BondInfoScreen(),
    WonBondsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: const HomeAppBar(),
      drawer: const SideMenu(),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Bonds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Won',
          ),
        ],
      ),
    );
  }
}
