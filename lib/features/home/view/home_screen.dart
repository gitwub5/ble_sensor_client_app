import 'package:bluetooth_app/shared/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_app/features/tag_management/tag/view/tag_screen.dart';
import 'package:bluetooth_app/features/fridge_management/view/fridge_screen.dart';
import 'package:bluetooth_app/features/medicine_management/view/medicine_screen.dart';
import 'package:bluetooth_app/test/ble/view/ble_scan_screen.dart';
import 'package:bluetooth_app/features/home/viewmodel/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Widget> _pages = [
    TagScreen(),
    MedicineScreen(),
    FridgeScreen(),
    BleTestScanScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final homeViewModel = Provider.of<HomeViewModel>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeViewModel.snackMessage != null) {
        CustomSnackbar.show(
          context,
          homeViewModel.snackMessage!,
          backgroundColor: homeViewModel.snackBackgroundColor,
          textColor: homeViewModel.snackTextColor,
        );
        homeViewModel.clearSnackbarRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: _pages,
          ),
          if (homeViewModel.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.label),
            label: 'Tag 관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: '의약품 관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: '냉장고 관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'BLE TEST',
          ),
        ],
      ),
    );
  }
}
